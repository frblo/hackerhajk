module Vtyhelper where

import Graphics.Vty
    ( defAttr,
      (<->),
      string,
      translate,
      Vty(outputIface),
      Image,
      Output(displayBounds) )

-- | Prints a string to the standard screen in the center of it
centerSingleString :: Vty -> String -> IO Image
centerSingleString vty str = do
    (maxX, maxY) <- displayBounds $ outputIface vty
    return $ translate ((maxX - length str) `div` 2) (maxY `div` 2) $ string defAttr str

-- | Prints a string to the standard screen in the center of it at a certain y position
centerSingleStringAt :: Vty -> Int -> String -> IO Image
centerSingleStringAt vty y str = do
    (maxX, _) <- displayBounds $ outputIface vty
    return $ translate ((maxX - length str) `div` 2) y $ string defAttr str

-- | Prints a multiline string to the standard screen in the center of it
centerMultiStrings :: Vty -> String -> IO Image
centerMultiStrings vty str = do
    let strs = lines str
    (maxX, maxY) <- displayBounds $ outputIface vty
    let y = (maxY - length strs) `div` 2
    let x = (maxX - maximum (map length strs)) `div` 2
    return $ foldl1 (<->) $ zipWith (\ y' str' -> translate x y' $ string defAttr str') [y..] strs