module Main where
import UI.HSCurses.Curses
    ( cursSet,
      echo,
      endWin,
      initCurses,
      keypad,
      noDelay,
      refresh,
      stdScr,
      CursorVisibility(CursorInvisible),
      Key (KeyChar, KeyBackspace),
      decodeKey,
      getch )
import Control.Concurrent (threadDelay)
import Challenges (generateBGC)
import HSBlessings (wAddCenterMultiStr)
import Effects (intro, challengeInput, writeGuess)

-- data State = Start | Challenge Int | End
data State = State {
    challenge :: Int,
    solution :: String,
    guess :: String
}

-- | Main function, what more is there to say?
main :: IO ()
main = do
    initCurses
    setup
    -- intro -- uncomment this to see the intro
    state <- createChallenge
    programloop state
    endWin

-- | Sets up the curses library
setup :: IO ()
setup = do
    keypad stdScr True
    echo False
    cursSet CursorInvisible
    noDelay stdScr True

-- | Creates a new challenge and create a new state with the challenge
createChallenge :: IO State
createChallenge = do
    bgc <- generateBGC
    wAddCenterMultiStr $ fst bgc
    challengeInput $ snd bgc
    return $ State 0 (snd bgc) ""

-- | The loop that runs the program and draws the screen
programloop :: State -> IO ()
programloop (State cha sol guess) = do
    writeGuess guess sol -- Write the current guess

    -- Get the pressed down character, if there is any
    ch <- decodeKey <$> getch
    case ch of
        KeyChar a -> programloop $ State cha sol (guess ++ [a])
        KeyBackspace -> programloop $ State cha sol (init guess)
        _         -> return ()
    
    refresh -- refresh the screen
    threadDelay 100000 -- wait 0.1 seconds until next iteration
    programloop $ State cha sol guess