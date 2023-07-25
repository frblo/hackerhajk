module Main where
import UI.HSCurses.Curses
import Control.Concurrent (threadDelay)
import Brädgårdschiffer(encryptBGC)

main :: IO ()
main = do
    initCurses
    setup
    endWin

setup :: IO ()
setup = do
    keypad stdScr True
    echo False
    cursSet CursorInvisible
    noDelay stdScr True