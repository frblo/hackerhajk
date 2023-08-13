module Main2 where

-- import Control.Concurrent (threadDelay)
-- import Challenges (generateBGC)
-- import HSBlessings (wAddCenterMultiStr, mwAddCenterSingleStr)
-- import Effects (intro, challengeInput, writeGuess)
-- import Control.Monad (when)
-- import Graphics.Vty ()

-- -- data State = Start | Challenge Int | End
-- data State = State {
--     challenge :: Int,
--     solution :: String,
--     guess :: String
-- }

-- -- -- | Main function, what more is there to say?
-- -- main :: IO ()
-- -- main = do
-- --     cfg <- standardIOConfig
-- --     vty <- mkVty cfg
    
-- --     shutdown vty

-- -- programloop :: Vty -> State -> IO ()
-- -- programloop vty (State cha sol guess) = do
-- --     writeGuess guess sol -- Write the current guess

-- --     e <- nextEvent vty
-- --     case e of
-- --         EvKey (KChar a) [] -> when (length guess < length sol) $ programloop $ State cha sol (guess ++ [a])
-- --         EvKey KBS [] -> when (guess /= []) $ programloop $ State cha sol (init guess)
-- --         _ -> return ()
    
-- --     threadDelay 10000
-- --     programloop $ State cha sol guess


-- -- | Main function, what more is there to say?
-- main :: IO ()
-- main = do
--     -- initCurses
--     -- setup
--     -- -- intro -- uncomment this to see the intro
--     -- state <- createChallenge
--     -- programloop state
--     -- endWin

--     cfg <- standardIOConfig
--     vty <- mkVty cfg

--     state <- createChallenge
--     programloop state

--     shutdown vty

-- -- -- | Sets up the curses library
-- -- setup :: IO ()
-- -- setup = do
-- --     keypad stdScr True
-- --     echo False
-- --     cursSet CursorInvisible
-- --     noDelay stdScr True

-- -- | Creates a new challenge and create a new state with the challenge
-- createChallenge :: IO State
-- createChallenge = do
--     bgc <- generateBGC
--     wAddCenterMultiStr $ fst bgc
--     challengeInput $ snd bgc
--     return $ State 0 (snd bgc) ""

-- -- | The loop that runs the program and draws the screen
-- programloop :: State -> IO ()
-- programloop (State cha sol guess) = do
--     writeGuess guess sol -- Write the current guess

--     mwAddCenterSingleStr 0 "           " -- debugging
--     mwAddCenterSingleStr 0 guess -- debugging

--     if guess == sol then do -- If the guess is correct, create a new challenge
--         wAddCenterMultiStr "Correct!"
--         refresh
--         threadDelay 1000000
--         state <- createChallenge
--         programloop state
--     else do
--         -- Get the pressed down character, if there is any
--         -- cint <- getch
--         -- case cint of
--         --     246 -> programloop $ State cha sol (guess ++ "ö")
--         --     228 -> programloop $ State cha sol (guess ++ "ä")
--         --     229 -> programloop $ State cha sol (guess ++ "å")
--         --     _   -> return ()

--         -- print ch
--         ch <- decodeKey <$> getch
--         case ch of
--             -- KeyUnknown x-> programloop $ State cha sol (guess ++ show x)
--             KeyChar a -> when (length guess < length sol) $ programloop $ State cha sol (guess ++ [a])
--             KeyBackspace -> when (guess /= []) $ programloop $ State cha sol (init guess)
--             _         -> return ()

--         refresh -- refresh the screen
--         threadDelay 100000 -- wait 0.1 seconds until next iteration
--         programloop $ State cha sol guess

-- -- -- Å = Ã¥
-- -- -- Ä = Ã¤
-- -- -- Ö = Ã¶
-- -- fixGuess :: String -> String -> String
-- -- fixGuess x sol
-- --     | length x >= 2 && 'Ã' `elem` x = åäö x
-- --     | length x > length sol = init x
-- --     | otherwise = x
-- --     where
-- --         åäö :: String -> String
-- --         åäö y
-- --             | drop 2 y == "Ã¥" = take (length y - 2) y ++ "å"
-- --             | drop 2 y == "Ã¤" = take (length y - 2) y ++ "ä"
-- --             | drop 2 y == "Ã¶" = take (length y - 2) y ++ "ö"
-- --             | otherwise = y
-- -- -- fixGuess [] = []
-- -- -- fixGuess (x:xs)
-- -- --     | x == 'Ã' = 'å' : fixGuess xs
-- -- --     | x == 'Ã' = 'ä' : fixGuess xs
-- -- --     | x == 'Ã' = 'ö' : fixGuess xs
-- -- --     | otherwise = x : fixGuess xs