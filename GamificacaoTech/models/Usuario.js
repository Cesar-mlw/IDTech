"use strict";
const Sql = require("../infra/sql");
const GeradorHash = require("../utils/geradorHash");
module.exports = class Usuario {
    static validate(u) {
        let resp;
        if (u.ra_usuario == null)
            resp = "RA não pode ser nulo\n";
        if (u.id_curso == null)
            resp += "ID do curso não pode ser nulo\n";
        if (u.nome_usuario == null)
            resp += "Nome do usuário não pode ser nulo";
        if (u.email_usuario == null)
            resp += "E-mail do usuário não pode ser nulo";
        if (u.nome_usuario == null)
            resp += "Nome do usuário não pode ser nulo";
        if (u.nome_usuario == null)
            resp += "Nome do usuário não pode ser nulo";
        if (u.isAdmin == null)
            resp += "Hierarquia não pode ser nulo";
        return resp;
    }
    static async list() {
        let lista = null;
        await Sql.conectar(async (sql) => {
            lista = (await sql.query("SELECT u.ra_usuario, u.id_curso, u.nome_usuario, u.email_usuario, u.moedas_usuario, u.dt_entrada_usuario, u.senha_usuario, c.nome_curso FROM usuario u, curso c WHERE c.id_curso = u.id_curso"));
        });
        return lista;
    }
    static async create(u) {
        let res;
        u.senha_usuario = await GeradorHash.criarHash(u.senha_usuario);
        if ((res = Usuario.validate(u)))
            return res;
        u.moedas_usuario = 0;
        await Sql.conectar(async (sql) => {
            try {
                await sql.query("INSERT INTO usuario (ra_usuario, id_curso, nome_usuario, email_usuario, moedas_usuario, dt_entrada_usuario, senha_usuario, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", [
                    u.ra_usuario,
                    u.id_curso,
                    u.nome_usuario,
                    u.email_usuario,
                    u.moedas_usuario,
                    u.dt_entrada_usuario,
                    u.senha_usuario,
                    u.isAdmin
                ]);
            }
            catch (e) {
                if (e.code && e.code === "ER_DUP_ENTRY")
                    res = `O RA ${u.ra_usuario.toString()} já está em uso`;
                else
                    throw e;
            }
        });
        return res;
    }
    static async read(id) {
        let lista = null;
        await Sql.conectar(async (sql) => {
            lista = (await sql.query("select u.ra_usuario, u.id_curso, u.nome_usuario, u.moedas_usuario, u.email_usuario, u.dt_entrada_usuario, c.nome_curso, u.isAdmin from usuario u, curso c where ra_usuario = ? and u.id_curso = c.id_curso", [id]));
        });
        return (lista && lista[0]) || null;
    }
    static async readUserPoints(ra) {
        let lista = null;
        await Sql.conectar(async (sql) => {
            lista = await sql.query("select p.id_area, a.nome_area, sum(t.pontos_tipo_projeto) as 'pontos' from projeto p, tipo_projeto t, area a where p.id_tipo_projeto = t.id_tipo_projeto and p.id_area = a.id_area and ra_usuario = ? group by p.id_area order by p.id_area", [ra]);
        });
        return lista;
    }
    static async update(u) {
        //
        let res;
        await Sql.conectar(async (sql) => {
            await sql.query("UPDATE usuario SET id_curso = ?, nome_usuario = ?, email_usuario = ?, moedas_usuario = ?, dt_entrada_usuario = ? WHERE ra_usuario = ?", [
                u.id_curso,
                u.nome_usuario,
                u.email_usuario,
                u.moedas_usuario,
                u.dt_entrada_usuario,
                u.ra_usuario,
                u.isAdmin
            ]);
            if (!sql.linhasAfetadas)
                res = "Usuário Inexistente";
        });
        return res;
    }
    //public static async checkForAchievements(ra: number): Promise<number[]>{
    // returns list of achievements ids that the user has acess to
    //}
    static async updatePassword(id, pass) {
        let res;
        await Sql.conectar(async (sql) => {
            await sql.query("UPDATE usuario SET senha_usuario = ? WHERE ra_usuario = ?", [
                pass,
                id
            ]);
            if (!sql.linhasAfetadas)
                res = "Usuário Inexistente";
        });
        return res;
    }
    static async updateRA(id, ra) {
        let res;
        await Sql.conectar(async (sql) => {
            await sql.query("UPDATE usuario SET ra_usuario = ? WHERE ra_usuario = ?", [
                ra,
                id
            ]);
            if (!sql.linhasAfetadas)
                res = "Usuário Inexistente";
        });
        return res;
    }
    static async delete(ra) {
        let res = true;
        await Sql.conectar(async (sql) => {
            await sql.query("delete from usuario where ra_usuario = ?", [ra]);
            if (!sql.linhasAfetadas)
                res = false;
        });
        return res;
    }
    static async buyObject(price, ra) {
        let res;
        let user = await this.read(ra);
        if (user.moedas_usuario <= price)
            res = "Saldo Insuficiente";
        else {
            await Sql.conectar(async (sql) => {
                await sql.query("UPDATE usuario SET moedas_usuario = (moedas_usuario - ?) where ra_usuario = ?", [price, ra]);
                if (!sql.linhasAfetadas)
                    res = "Usuario não existe";
            });
        }
        return res;
    }
    static async addCoins(coins, id) {
        let res;
        let user = await this.read(id);
        await Sql.conectar(async (sql) => {
            await sql.query("UPDATE usuario SET moedas_usuario = (moedas_usuario + ?) where ra_usuario = ?", [coins, id]);
            if (!sql.linhasAfetadas)
                res = "Usuário não existente";
        });
        return res;
    }
    static async efetuarLogin(ra, senha) {
        //parametros a serem passados - ra: number / senha: string
        let res = true;
        console.log(ra + " " + senha);
        await Sql.conectar(async (sql) => {
            let hash = await sql.query("select senha_usuario from usuario where ra_usuario = ?", [ra]);
            if (hash.length == 0) {
                res = false;
            }
            else if (!(await GeradorHash.validarSenha(senha, hash[0].senha_usuario))) {
                res = false;
            }
        });
        return res;
    }
};
//# sourceMappingURL=Usuario.js.map