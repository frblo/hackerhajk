module Challenges where

import Brädgårdschiffer(encryptBGC)
import System.Random ( randomRIO )

-- | Reads the word file and returns a list of all the words
getWords :: IO [String]
getWords = do
    wordfile <- readFile "resources/ord.txt"
    let ord = words wordfile
    return ord

-- | Returns a random word from the word list
randomWord :: [String] -> IO String
randomWord ord = do
    i <- randomRIO (0, length ord - 1)
    return $ ord !! i

-- | Generates a new brädgårdschiffer and returns the encrypted string and the solution
generateBGC :: IO (String, String)
generateBGC = do
    ord <- getWords
    word <- randomWord ord
    return (encryptBGC word, word)