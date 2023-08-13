module Main where
-- import Control.Concurrent (threadDelay)
import Challenges (generateBGC)
-- import HSBlessings (wAddCenterMultiStr, mwAddCenterSingleStr)
import Effects (challengeInput, writeGuess)
import Control.Monad (when)
import Vtyhelper (centerSingleString, centerSingleStringAt, centerMultiStrings)
import Graphics.Vty

-- data State = Start | Challenge Int | End
data State = State {
    challenge :: Int,
    solution :: String,
    guess :: String,
    cipher :: Image
}

-- | Main function, what more is there to say?
main :: IO ()
main = do
    cfg <- standardIOConfig
    vty <- mkVty cfg

    state <- createChallenge vty
    programloop vty state
    shutdown vty

programloop :: Vty -> State -> IO ()
programloop vty (State cha sol guess cipher) = do
    -- let newGuess = appendGuess (State cha sol guess) $ maybe "" (:[]) lastKey  -- Convert the Maybe Char to a string
    guessIn <- writeGuess vty guess sol -- Get the guess input


    let display = cipher <-> guessIn  -- Combine the two inputs

    update vty $ picForImage display
    -- writeGuess guess sol -- Write the current guess
    -- let display = string defAttr "hello world" <->
    --               string defAttr ("Last key: " ++ maybe "None" show lastKey)

    e <- nextEvent vty
    case e of
        EvKey (KChar a) [] -> when (length guess < length sol) $ programloop vty (State cha sol (guess ++ [a]) cipher)
        -- EvKey (KChar a) [] -> programloop vty (State cha sol (guess ++ [a])) (Just a)
        EvKey KBS [] -> when (guess /= []) $ programloop vty (State cha sol (init guess) cipher)
        EvKey KEsc [] -> return ()               -- exit on escape key
        _ -> programloop vty (State cha sol guess cipher)   -- continue with the current state for other events


    -- e <- nextEvent vty
    -- case e of
    --     EvKey (KChar a) [] -> when (length guess < length sol) $ programloop $ State cha sol (guess ++ [a])
    --     EvKey KBS [] -> when (guess /= []) $ programloop $ State cha sol (init guess)
    --     _ -> return ()

    -- threadDelay 10000
    -- programloop $ State cha sol guess

-- appendGuess :: State -> String -> String
-- appendGuess (State _ sol guess) x
--     | length guess < length sol = guess ++ x
--     | otherwise = guess

-- | Creates a new challenge and create a new state with the challenge
createChallenge :: Vty -> IO State
createChallenge vty = do
    bgc <- generateBGC
    cipher <- centerMultiStrings vty $ fst bgc
    return (State 0 (snd bgc) "" cipher)

-- eventLoop :: Vty -> Maybe Char -> IO ()
-- eventLoop vty lastKey = do
--     let displayKey = maybe "None" (:[]) lastKey  -- Convert the Maybe Char to a string
--     let display = string defAttr "hello world" <->
--                   string defAttr ("Last key: " ++ displayKey)
--     update vty $ picForImage display
--     event <- nextEvent vty
--     case event of
--         EvKey (KChar c) [] -> eventLoop vty (Just c)  -- update with the pressed key
--         EvKey KEsc []      -> return ()               -- exit on escape key
--         _                  -> eventLoop vty lastKey   -- continue with the current state for other events