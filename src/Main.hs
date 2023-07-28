module Main where
import UI.HSCurses.Curses
import Control.Concurrent (threadDelay)
import Challenges (generateBGC)
import HSBlessings (wAddCenterMultiStr)
import Effects (intro)

data State = Start | Challenge Int | End

main :: IO ()
main = do
    initCurses
    setup
    intro
    createChallenge
    programloop
    endWin

setup :: IO ()
setup = do
    keypad stdScr True
    echo False
    cursSet CursorInvisible
    noDelay stdScr True

createChallenge :: IO ()
createChallenge = do
    bgc <- generateBGC
    wAddCenterMultiStr bgc

programloop :: IO ()
programloop = do
    threadDelay 100000
    refresh
    programloop