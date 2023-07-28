module HSBlessings where

-- A group of helper functions for the HSCurses library

import UI.HSCurses.Curses (Window, scrSize, stdScr, mvWAddStr)

-- | Prints a string to the standard screen in the center of it
wAddCenterSingleStr :: String -> IO ()
wAddCenterSingleStr str = do
    (maxY, maxX) <- scrSize
    mvWAddStr stdScr (maxY `div` 2) ((maxX - length str) `div` 2) str

-- | Prints a multiline string to the standard screen in the center of it
wAddCenterMultiStr :: String -> IO ()
wAddCenterMultiStr str = do
    let strs = lines str
    (maxY, maxX) <- scrSize
    let y = (maxY - length strs) `div` 2
    let x = (maxX - maximum (map length strs)) `div` 2
    mapM_ (\(y', str') -> mvWAddStr stdScr y' x str') $ zip [y..] strs