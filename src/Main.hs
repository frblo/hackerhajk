module Main where
import UI.HSCurses.Curses
import Control.Concurrent (threadDelay)
import Challenges (generateBGC)
import HSBlessings (wAddCenterMultiStr)

data State = Start | Challenge Int | End

main :: IO ()
main = do
    initCurses
    setup
    programloop
    endWin

setup :: IO ()
setup = do
    keypad stdScr True
    echo False
    cursSet CursorInvisible
    noDelay stdScr True
    createChallenge

createChallenge :: IO ()
createChallenge = do
    bgc <- generateBGC
    (maxY, maxX) <- scrSize
    wAddCenterMultiStr bgc
    refresh

programloop :: IO ()
programloop = do
    threadDelay 100000
    refresh
    programloop