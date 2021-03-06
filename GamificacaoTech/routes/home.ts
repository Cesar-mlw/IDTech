﻿
import express = require('express');
import wrap = require('express-async-error-wrapper')
import Usuario = require('../models/Usuario')
import Projeto = require('../models/Projeto');
import StringBuilder = require('../utils/stringBuilder')
import Habilidade = require('../models/Habilidade');
import AchievementUsuario = require('../models/AchievementUsuario');
import Achievement = require('../models/Achievement');
import ItemUsuario = require('../models/ItemUsuario');
import Area = require('../models/Area');
import TipoProjeto = require('../models/TipoProjeto');
import TipoHabilidade = require('../models/TipoHabilidade');
import { CLIENT_RENEG_WINDOW } from 'tls';
import Noticia = require('../models/Noticia');
const router = express.Router();

//import usuario
router.get('/', wrap(async (req: express.Request, res: express.Response) => {
    if(await Usuario.doesNotExist(req.cookies.ra_usuario)){
        res.redirect("/login")
    }
    else if(await Usuario.userIsAdmin(req.cookies.ra_usuario)){
        res.redirect("/admin/home")
    }
    else{
        let points = await Usuario.readUserPoints(req.cookies.ra_usuario)
        let coins = await Usuario.readUserCoins(req.cookies.ra_usuario)
        let dadosUsuario = await Usuario.read(req.cookies.ra_usuario)
        let books = []
        for(let i = 0; i < points.length; i++){
            books.push(StringBuilder.bookSpiller(points[i]['pontos'], points[i]['nome_area'], points[i]['id_area']))
        }
        let allAchievements = await Achievement.listJoin()
        let missingAchievements = await AchievementUsuario.readMissingAchievements(req.cookies.ra_usuario)
        let achieveHTML = StringBuilder.shelfSpiller(allAchievements, missingAchievements)
        let achievePreviewHTML = StringBuilder.shelfPreviewSpiller(allAchievements, missingAchievements)
        let notPlacedItemsJson = await ItemUsuario.readNotPlacedItems(req.cookies.ra_usuario)
        let notPlacedItems = StringBuilder.itemBoxSpiller(await ItemUsuario.readNotPlacedItems(req.cookies.ra_usuario))
        let placedItemsJson = await ItemUsuario.readPlacedItems(req.cookies.ra_usuario)
        let placedItems = StringBuilder.placedItemSpiller(placedItemsJson)
        let newsHTML = StringBuilder.noticiaSpiller(await Noticia.readRecentNews())
        // Book pile string builder
        res.render('home', { titulo: 'Gamificação TECH', 
                            coins: coins,
                            dados: dadosUsuario,
                            books: books, 
                            achieveHTML: achieveHTML,
                            achievePreviewHTML: achievePreviewHTML,
                            notPlacedItemsJson: JSON.stringify(notPlacedItemsJson),
                            notPlacedItems: notPlacedItems,
                            placedItems: placedItems,
                            placedItemsJson: JSON.stringify(placedItemsJson),
                            news: newsHTML
                        });
                            
}}));

router.get('/login', wrap(async (req: express.Request, res: express.Response) => {
    if(!await Usuario.doesNotExist(req.cookies.ra_usuario) && req.cookies.ra_usuario != undefined && req.cookies.logged != undefined){
        res.redirect("/")

    }
    else{
        res.render('loginRegistro', { titulo: 'Gamificação TECH', layout: 'layoutLogin'}); 
    }
    
}));

router.post('/pc', wrap(async (req: express.Request, res: express.Response) => {
    if(req.cookies.ra_usuario == undefined && req.cookies.looged == undefined){
        res.redirect("/login")
    }
    else{
        res.render('pc', { titulo: 'Gamificação TECH' }); 
    }
    
}));

router.post('/feed', wrap(async (req: express.Request, res: express.Response) => {
    if(req.cookies.ra_usuario == undefined && req.cookies.looged == undefined){
        res.redirect("/login")
    }
    else{
        res.render('feed', { titulo: 'Gamificação TECH'}); 
    }
    
}));

router.post('/achieve', wrap(async (req: express.Request, res: express.Response) => {
    if(req.cookies.ra_usuario == undefined && req.cookies.looged == undefined){
        res.redirect("/login")
    }
    else{
        res.render('achieve', { titulo: 'Gamificação TECH'}); 
    }
}));

router.post('/formTest', wrap(async (req: express.Request, res: express.Response) => {
    
    res.render('formTest', { titulo: "Gamificação" })//renderizar a tela
}));

router.post('/portifolio', wrap(async (req: express.Request, res: express.Response) => {

    let projetos = await Projeto.read(req.cookies.ra_usuario)
    console.log(projetos);
    let projetosHTML = StringBuilder.projectSpiller(await Projeto.read(req.cookies.ra_usuario))
    let numeroDeProjetos = projetos.length
    let listaArea = StringBuilder.areaSpiller(await Area.list())
    let listaTipoProjeto = StringBuilder.tipoProjetoSpiller(await TipoProjeto.list())
    res.render('portifolio', { layout:'layoutVazio',
                                projetos: projetos,
                                projetosHTML: projetosHTML,
                                numeroDeProjetos: numeroDeProjetos,
                                listaArea: listaArea,
                                listaTipoProjeto: listaTipoProjeto})//renderizar a tela
}));

router.post('/curriculo', wrap(async (req: express.Request, res: express.Response) => {
    let habs = await Habilidade.read(req.cookies.ra_usuario)
    res.render('curriculo', { layout:'layoutVazio',
                            habilidades: habs})//renderizar a tela
}));

router.post('/info', wrap(async (req: express.Request, res: express.Response) => {
    res.render('info', { layout:'layoutVazio'})
}));

router.post('/testeAjax', wrap(async (req: express.Request, res: express.Response) => {
    res.render('testeAjax', { layout:'layoutVazio'})//renderizar a tela
}));

router.post('/registroProjeto', wrap(async (req: express.Request, res: express.Response) => {
    let listaArea = StringBuilder.areaSpiller(await Area.list())
    let listaTipoProjeto = StringBuilder.tipoProjetoSpiller(await TipoProjeto.list())
    let listaTipoHabilidade = StringBuilder.tipoHabilidadeSpiller(await TipoHabilidade.list());
    res.render('registroProjeto', { layout:'layoutVazio', 
                                    listaArea: listaArea,
                                    listaTipoProjeto: listaTipoProjeto,
                                    listaTipoHabilidade: listaTipoHabilidade})//renderizar a tela
}));

router.post('/loja', wrap(async (req: express.Request, res: express.Response) => {

    let storeItems = StringBuilder.storeItemSpiller(await ItemUsuario.readMissingItems(req.cookies.ra_usuario))
    let coins = await Usuario.readUserCoins(req.cookies.ra_usuario)
    let dadosUsuario = await Usuario.read(req.cookies.ra_usuario)
    res.render('loja', { 
        coins: coins,
        nome: dadosUsuario.nome_usuario,
        layout:'layoutVazio',
        storeItems: storeItems});//renderizar a tela
}));



export = router;