import Control.Monad
import Control.Concurrent (threadDelay)

import Paths

import qualified Graphics.UI.Threepenny as UI
import Graphics.UI.Threepenny.Core

play :: IO ()
play = do
    static <- getStaticDir
    startGUI defaultConfig { jsStatic = Just static } setup

setup :: Window -> UI ()
setup w = void $ do
    return w # set title "HaskellRPG"
    UI.addStyleSheet w "styles.css"

    buttons <- mkButtons
    getBody w #+
        [UI.div #. "wrap" #+ (greet ++ map element buttons)]

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
        liftIO $ threadDelay $ 1000 * 1000 * 3
        element list    #+ [UI.li # set html "<b>Delayed</b> result!"]
        element buttonLeft # set text (buttonLeftTitle)

    (buttonRight, viewRight) <- mkButton buttonRightTitle
    on UI.hover buttonRight $ \_ -> do
        element buttonRight # set text ("Rolar dados!")
    on UI.leave buttonRight $ \_ -> do
        element buttonRight # set text (buttonRightTitle)
    on UI.click buttonRight $ \_ -> do
        liftIO $ threadDelay $ 1000 * 1000 * 3
        element list    #+ [UI.li # set html "<b>Delayed</b> result!"]
        element buttonRight # set text (buttonRightTitle)

    return [list, viewLeft, viewRight]

  where buttonLeftTitle = "Escolher opção 1"
        buttonRightTitle = "Escolher opção 2"