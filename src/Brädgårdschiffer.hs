module Brädgårdschiffer where

import Text.Printf (printf)
import System.Environment
import System.IO
import Data.Char(toLower)

-- main :: IO ()
-- main = do
--     args <- getArgs
--     case args of
--         [] -> putStrLn "No string provided"
--         x -> printf "%s\n" $ concrypt $ map toLower $ concat x

encryptBGC :: String -> String
encryptBGC x = printf "%s\n" $ concrypt $ map toLower x

concrypt :: String -> String
concrypt x = unwords a ++ "\n" ++ unwords b ++ "\n" ++ unwords c
    where
        (a, b, c) = unzip3 $ map encryptLetter x

encryptLetter :: Char -> (String, String, String)
encryptLetter 'a' = (   "    |",
                        "    |",
                        "----+")
encryptLetter 'b' = (   "|   |",
                        "|   |",
                        "+---+")
encryptLetter 'c' = (   "|    ",
                        "|    ",
                        "+----")
encryptLetter 'd' = (   "----+",
                        "    |",
                        "----+")
encryptLetter 'e' = (   "+---+",
                        "|   |",
                        "+---+")
encryptLetter 'f' = (   "+----",
                        "|    ",
                        "+----")
encryptLetter 'g' = (   "----+",
                        "    |",
                        "    |")
encryptLetter 'h' = (   "+---+",
                        "|   |",
                        "|   |")
encryptLetter 'i' = (   "+----",
                        "|    ",
                        "|    ")
encryptLetter 'j' = (   "    |",
                        "  * |",
                        "----+")
encryptLetter 'k' = (   "|   |",
                        "| * |",
                        "+---+")
encryptLetter 'l' = (   "|    ",
                        "| *  ",
                        "+----")
encryptLetter 'm' = (   "----+",
                        "  * |",
                        "----+")
encryptLetter 'n' = (   "+---+",
                        "| * |",
                        "+---+")
encryptLetter 'o' = (   "+----",
                        "| *  ",
                        "+----")
encryptLetter 'p' = (   "----+",
                        "    |",
                        "  * |")
encryptLetter 'r' = (   "+---+",
                        "| * |",
                        "|   |")
encryptLetter 's' = (   "+----",
                        "| *  ",
                        "|    ")
encryptLetter 't' = (   "  * |",
                        "  * |",
                        "----+")
encryptLetter 'u' = (   "| * |",
                        "| * |",
                        "+---+")
encryptLetter 'v' = (   "|   *",
                        "| *  ",
                        "+----")
encryptLetter 'x' = (   "----+",
                        " ** |",
                        "----+")
encryptLetter 'y' = (   "+---+",
                        "|* *|",
                        "+---+")
encryptLetter 'z' = (   "+----",
                        "| ** ",
                        "+----")
encryptLetter 'å' = (   "----+",
                        "  * |",
                        "*   |")
encryptLetter 'ä' = (   "+---+",
                        "| * |",
                        "| * |")
encryptLetter 'ö' = (   "+----",
                        "| *  ",
                        "|   *")
encryptLetter x = (     "     ",
                        "  " ++ [x] ++ "  ",
                        "     ")