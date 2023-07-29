module Challenges where

import Brädgårdschiffer(encryptBGC)
import System.Random ( randomRIO )

getWords :: IO [String]
getWords = do
    wordfile <- readFile "resources/ord.txt"
    let ord = words wordfile
    return ord

randomWord :: [String] -> IO String
randomWord ord = do
    i <- randomRIO (0, length ord - 1)
    return $ ord !! i

generateBGC :: IO (String, String)
generateBGC = do
    ord <- getWords
    word <- randomWord ord
    return (encryptBGC word, word)