import Control.Monad
import Control.Concurrent (threadDelay)

import Paths
import BinaryTree

import qualified Data.Text    as Text
import qualified Data.Text.IO as TextIO

import qualified Graphics.UI.Threepenny as UI
import Graphics.UI.Threepenny.Core

data ArvBin elemento = Nulo
    |Node elemento (ArvBin elemento)(ArvBin elemento)
    deriving (Show, Eq)

play :: IO ()
play = do
    static <- getStaticDir
    startGUI defaultConfig { jsStatic = Just static } setup

setup :: Window -> UI ()
setup w = void $ do
    return w # set title "HaskellRPG"
    UI.addStyleSheet w "styles.css"

    getBody w #+
        [UI.div #. "wrap" #+ (greet)]

    --script <- fmap Text.lines (TextIO.readFile "storyFile.txt")
    let rpgBinTree = Node "inicio da arvore de batalha\r" (Node "batalha1\r" (Node "batalha1-1\r" Nulo Nulo) (Node "batalha1-2\r" Nulo Nulo)) (Node "batalha2\r" (Node "batalha2-1\r" Nulo Nulo) (Node "batalha2-2" Nulo Nulo))
    gameLoop w rpgBinTree

gameLoop w (Node elemento esq dir) = do
    historyStep <- getHistory elemento

    (buttonLeft, viewLeft) <- mkButton buttonLeftTitle
    on UI.hover buttonLeft $ \_ -> do
        element buttonLeft # set text (rowDiceTitle)
    on UI.leave buttonLeft $ \_ -> do
        element buttonLeft # set text (buttonLeftTitle)
    on UI.click buttonLeft $ \_ -> do
        gameLoop w esq

    (buttonRight, viewRight) <- mkButton buttonRightTitle
    on UI.hover buttonRight $ \_ -> do
        element buttonRight # set text (rowDiceTitle)
    on UI.leave buttonRight $ \_ -> do
        element buttonRight # set text (buttonRightTitle)
    on UI.click buttonRight $ \_ -> do
        gameLoop w dir

    let buttons = [viewLeft, viewRight]

    getBody w #+
        [UI.div #. "wrap" #+ (map element (historyStep ++ buttons))]

    where rowDiceTitle = "Rolar dados!"
          buttonLeftTitle = "Escolher opção 1"
          buttonRightTitle = "Escolher opção 2"

getHistory historyStep = do
    list    <- UI.ul #. "buttons-list"
    element list    #+ [UI.li # set html historyStep]
    return [list]

greet :: [UI Element]
greet =
    [ UI.h1  #+ [string "HaskellRPG!"]
    , UI.div #+ [string "Jogo de RPG baseado em escolhas contruido em Haskell."]
    ]

mkButton :: String -> UI (Element, Element)
mkButton title = do
    button <- UI.button #. "button" #+ [string title]
    view   <- UI.p #+ [element button]
    return (button, view)


mkButtons :: UI [Element]
mkButtons = do
    list    <- UI.ul #. "buttons-list"

    (buttonLeft, viewLeft) <- mkButton buttonLeftTitle
    on UI.hover buttonLeft $ \_ -> do
        element buttonLeft # set text ("Rolar dados!")
    on UI.leave buttonLeft $ \_ -> do
        element buttonLeft # set text (buttonLeftTitle)
    on UI.click buttonLeft $ \_ -> do
        liftIO $ threadDelay $ 1000 * 1000 * 1
        element list    #+ [UI.li # set html "<b>Delayed</b> result!"]
        element buttonLeft # set text (buttonLeftTitle)

    (buttonRight, viewRight) <- mkButton buttonRightTitle
    on UI.hover buttonRight $ \_ -> do
        element buttonRight # set text ("Rolar dados!")
    on UI.leave buttonRight $ \_ -> do
        element buttonRight # set text (buttonRightTitle)
    on UI.click buttonRight $ \_ -> do
        liftIO $ threadDelay $ 1000 * 1000 * 1
        element list    #+ [UI.li # set html "<b>Delayed</b> result!"]
        element buttonRight # set text (buttonRightTitle)

    --dice <- UI.img #. "dices" # set (attr "src") "/static/img/rolldice.gif"
    return [list, viewLeft, viewRight]

  where buttonLeftTitle = "Escolher opção 1"
        buttonRightTitle = "Escolher opção 2"