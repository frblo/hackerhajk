module Effects where

import UI.HSCurses.Curses (refresh, wclear, stdScr, scrSize)
import HSBlessings (wAddCenterMultiStr, mwAddCenterSingleStr, wAddCenterSingleStr)
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
        maxY <- fst <$> scrSize
        mwAddCenterSingleStr (maxY - 10) $ "[" ++ replicate progress '#' ++ replicate (30 - progress) ' ' ++ "]"
        refresh
        threadDelay 100000
        progressbar (progress + 1)

challengeInput :: String -> IO ()
challengeInput solution = do
    maxY <- fst <$> scrSize
    mwAddCenterSingleStr (maxY - 10) $ replicateStr (length solution) "‾  "
    refresh
    threadDelay 100000

writeGuess :: String -> String -> IO ()
writeGuess guess solution = do
    maxY <- fst <$> scrSize
    mwAddCenterSingleStr (maxY - 11) $ concatMap (: "  ") guess ++ replicateStr (length solution - length guess) "   "

-- | Replicates a string n times
replicateStr :: Int -> String -> String
replicateStr 0 _ = ""
replicateStr n str = str ++ replicateStr (n - 1) str