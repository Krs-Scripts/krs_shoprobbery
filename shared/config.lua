lib.locale()

Config = {}
-- ROBBERY KRS --

Config.MoneyType = 'black_money'
Config.TimerBeforeNewRob  = 60 -- Tempo per startare di nuovo una rapina.
Config.MaxDistance  = 200
Config.DurationProgressLib = 10000 -- Durata della progress lib.
Config.PositionProgress = 'middle' -- Posizione della progress lib.
Config.animDict = "mp_arresting" -- Animation.
Config.animClip = "a_uncuff" -- Animation.
Config.PositionTexUi = "top-center" -- Posizione del showTextUI.
Config.Icon = 'fa-solid fa-sack-dollar' -- Icona del tempo e dell'interazione.
Config.backgroundColor = '#1A1B1E' -- colore background showTextUI.
Config.colorText = 'white' -- Colore del testo.
Config.borderRadius = 10 -- Bordo showTextUI.
Config.backgroundColorNotify = '#141517' -- Colore Background della notify
Config.IconMiniGame = 'fa-solid fa-puzzle-piece' -- Icona MiniGame
Config.IconColorMiniGame = '#22B8CF' -- Colore icona minigame
Config.PositionNotify = 'top' -- Posizione Notify
Config.IconNotPolice = 'fa-solid fa-building-shield' -- Icona della notify della police
Config.IconColorNotPolice = '#4263EB' -- Colore dell'icona della notify
Config.IconGunRobbery = 'fa-solid fa-gun' -- Icona della pistola
Config.IconColorGunRobbery = '#C53030' -- Colore della pistola
Config.TitleColorNotify = '#C1C2C5' -- Colore titolo della notify
Config.TextColorNotify = '#909296' -- Colore del testo della notify

Config.ShopRobbery = {

    ["shop_247_civic_125"] = {
        position = vector3(28.2276, -1339.1611, 29.4970), -- Posizioni
        guadagno = 15000, -- Guadagno della Rapina
        nomeNegozio = "  Robbery", -- Il Testo.
        tempoRapina = 200, --  Il tempo necessario per compiere una rapina in questo luogo
        poliziotti = 0, --  Il numero di poliziotti che risponderanno a una rapina in corso
        prossimaRapina = 3500 -- traccia dell'ultima volta in cui questo negozio o banca è stato rapinato.
    },
}
