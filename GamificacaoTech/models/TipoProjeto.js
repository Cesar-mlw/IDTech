"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
const Sql = require("../infra/sql");
module.exports = class TipoProjeto {
    static validate(t) {
        let resp;
        if (t.nome_tipo_projeto == null)
            resp = "nome do tipo do projeto não está presente\n";
        if (t.pontos_tipo_projeto == null)
            resp += "pontos que o tipo do projeto dá não estão presentes";
        return resp;
    }
    static list() {
        return __awaiter(this, void 0, void 0, function* () {
            let lista = null;
            yield Sql.conectar((sql) => __awaiter(this, void 0, void 0, function* () {
                lista = (yield sql.query("SELECT id_tipo_projeto, nome_tipo_projeto, pontos_tipo_projeto FROM tipo_projeto"));
            }));
            return lista;
        });
    }
    static create(t) {
        return __awaiter(this, void 0, void 0, function* () {
            let res;
            if ((res = TipoProjeto.validate(t)))
                throw res;
            yield Sql.conectar((sql) => __awaiter(this, void 0, void 0, function* () {
                try {
                    sql.query("INSERT INTO tipo_projeto (nome_tipo_projeto, pontos_tipo_projeto) VALUES (?, ?)", [t.nome_tipo_projeto, t.pontos_tipo_projeto]);
                }
                catch (e) {
                    if (e.code && e.code == "ER_DUP_ENTRY")
                        res = `O ID ${t.id_tipo_projeto} já está em uso`;
                    else
                        throw e;
                }
            }));
            return res;
        });
    }
    static read(id) {
        return __awaiter(this, void 0, void 0, function* () {
            let lista = null;
            yield Sql.conectar((sql) => __awaiter(this, void 0, void 0, function* () {
                lista = yield sql.query("SELECT id_tipo_projeto, nome_tipo_projeto, pontos_tipo_projeto FROM tipo_projeto WHERE id_tipo_projeto = ?", [id]);
            }));
            return ((lista && lista[0]) || null);
        });
    }
    static update(t) {
        return __awaiter(this, void 0, void 0, function* () {
            let res;
            yield Sql.conectar((sql) => __awaiter(this, void 0, void 0, function* () {
                yield sql.query("UPDATE tipo_projeto SET nome_tipo_projeto = ?, pontos_tipo_projeto = ? WHERE id_tipo_projeto = ?", [t.nome_tipo_projeto, t.pontos_tipo_projeto, t.id_tipo_projeto]);
                if (!sql.linhasAfetadas)
                    res = "Tipo de Projeto não encontrado";
            }));
            return res;
        });
    }
    static delete(id_tipo_projeto) {
        return __awaiter(this, void 0, void 0, function* () {
            let res = true;
            Sql.conectar((sql) => __awaiter(this, void 0, void 0, function* () {
                yield sql.query("DELETE FROM tipo_projeto WHERE id_tipo_projeto = ?", [id_tipo_projeto]);
                if (!sql.linhasAfetadas)
                    res = false;
            }));
            return res;
        });
    }
};
//# sourceMappingURL=TipoProjeto.js.map