module Effects where

import UI.HSCurses.Curses (refresh, wclear, stdScr, scrSize)
import HSBlessings (wAddCenterMultiStr, mwAddCenterSingleStr, wAddCenterSingleStr)
import Control.Concurrent (threadDelay)
import Vtyhelper (centerSingleString, centerSingleStringAt, centerMultiStrings)
import Graphics.Vty

-- | Draws a fancy intro screen with a logo and a fictional and meaningless progress bar
-- intro :: IO Image
-- intro = do
--     logo <- readFile "resources/logo.txt"
--     centerMultiStrings logo
--     progressbar 0


-- | Meaningless progress bar meant to trick stupid children that is just 
-- there to look cool and trick stupid children, just like most progress bars
-- progressbar :: Int -> IO ()
-- progressbar progress = do
--     if progress >= 30 then return () else do
--         maxY <- fst <$> scrSize
--         mwAddCenterSingleStr (maxY - 10) $ "[" ++ replicate progress '#' ++ replicate (30 - progress) ' ' ++ "]"
--         refresh
--         threadDelay 100000
--         progressbar (progress + 1)

-- | Draws ‾-characters for each character in the solution for the current challenge
-- with spaces between them to make it easier to see how many characters there are
challengeInput :: Vty -> String -> IO Image
challengeInput vty solution = do
    (_, maxY) <- displayBounds $ outputIface vty
    centerSingleStringAt vty 0 $ replicateStr (length solution) "‾  "

-- | Writes the current guess to the screen
writeGuess :: Vty -> String -> String -> IO Image
writeGuess vty guess solution = do
    textfield <- challengeInput vty solution
    (_, maxY) <- displayBounds $ outputIface vty
    guessIn <- centerSingleStringAt vty 5 $ concatMap (: "  ") guess ++ replicateStr (length solution - length guess) "   "
    return $ textfield <-> guessIn


-- | Replicates a string n times
replicateStr :: Int -> String -> String
replicateStr 0 _ = ""
replicateStr n str = str ++ replicateStr (n - 1) str