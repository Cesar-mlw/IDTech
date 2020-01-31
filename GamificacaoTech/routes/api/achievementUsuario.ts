import express = require("express")
import wrap = require("express-async-error-wrapper");
import AchievementUsuario = require("../../models/AchievementUsuario");
const router = express.Router()


router.post("/create", wrap(async (req: express.Request, res: express.Response) => {
    let ra = req.body.ra
    let id = req.body.id_achievement
    let erro = await AchievementUsuario.create(ra, id)

    if (erro) {
        res.statusCode = 400
        res.json(erro)
    }
    else {
        res.json("Achievement do usuário criado")
    }

}))

router.get("/list", wrap(async (req: express.Request, res: express.Response) => {
    let lista = await AchievementUsuario.list()

    res.json(lista)
}))

router.post("/delete", wrap(async (req: express.Request, res: express.Response) => {
    let idAchievementUsuario = req.body.idAchievementUsuario
    let a = await AchievementUsuario.delete(idAchievementUsuario)
    if (a == false) {

        res.json("O usuário não possui esse achievement")
    }

    else {
        res.json("Achievement do usuário deletado")
    }
}))

router.post("/read", wrap(async (req: express.Request, res: express.Response) => {
    let idAchievementUsuario = req.body.idAchievementUsuario
    let a = await AchievementUsuario.read(idAchievementUsuario)
    res.json(a)
}))

router.post("/readFromUserID", wrap(async (req: express.Request, res: express.Response) => {
    let ra = req.body.ra
    let a = await AchievementUsuario.readFromUserID(ra)
    res.json(a)
}))

router.post("/readMissingAchievements", wrap(async (req: express.Request, res: express.Response) => {
    let ra = req.body.ra
    let a = await AchievementUsuario.readMissingAchievements(ra)
    res.json(a)
}))

router.post("/readFeaturedAchievements", wrap(async (req: express.Request, res: express.Response) => {
    let ra = req.body.ra
    let a = await AchievementUsuario.readFeaturedAchievements(ra)
    res.json(a)
}))

router.post("/update", wrap(async (req: express.Request, res: express.Response) => {
    let a = req.body as AchievementUsuario
    let erro = await AchievementUsuario.update(a)

    if (erro) {

        res.json("O usuário não possui esse Achievement")
    }

    else {
        res.json("Achievement do usuário alterado")
    }


}))

export = router;