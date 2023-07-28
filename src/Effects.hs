module Effects where

import UI.HSCurses.Curses (refresh, wclear, stdScr)
import HSBlessings (wAddCenterMultiStr, mwAddCenterSingleStr)
import Control.Concurrent (threadDelay)

intro :: IO ()
intro = do
    logo <- readFile "resources/logo.txt"
    wAddCenterMultiStr logo
    progressbar 0
    wclear stdScr

progressbar :: Int -> IO ()
progressbar progress = do
    if progress >= 30 then return () else do
        mwAddCenterSingleStr 10 $ "[" ++ replicate progress '#' ++ replicate (30 - progress) ' ' ++ "]"
        refresh
        threadDelay 100000
        progressbar (progress + 1)