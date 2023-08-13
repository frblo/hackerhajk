module HSBlessings where

-- A group of helper functions for the HSCurses library

import UI.HSCurses.Curses (scrSize, stdScr, mvWAddStr, decodeKey, getch, Key (KeyChar))
import Graphics.Vty

-- | Prints a string to the standard screen in the center of it
wAddCenterSingleStr :: String -> IO ()
wAddCenterSingleStr str = do
    (maxY, maxX) <- scrSize
    mvWAddStr stdScr (maxY `div` 2) ((maxX - length str) `div` 2) str

-- | Prints a string to the standard screen in the center of it at a certain y position
mwAddCenterSingleStr :: Int -> String -> IO ()
mwAddCenterSingleStr y str = do
    (_, maxX) <- scrSize
    mvWAddStr stdScr y ((maxX - length str) `div` 2) str

-- | Prints a multiline string to the standard screen in the center of it
wAddCenterMultiStr :: String -> IO ()
wAddCenterMultiStr str = do
    let strs = lines str
    (maxY, maxX) <- scrSize
    let y = (maxY - length strs) `div` 2
    let x = (maxX - maximum (map length strs)) `div` 2
    mapM_ (\(y', str') -> mvWAddStr stdScr y' x str') $ zip [y..] strs