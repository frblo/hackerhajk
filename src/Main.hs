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
      Key (KeyChar),
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

main :: IO ()
main = do
    initCurses
    setup
    -- intro
    state <- createChallenge
    programloop state
    endWin

setup :: IO ()
setup = do
    keypad stdScr True
    echo False
    cursSet CursorInvisible
    noDelay stdScr True

createChallenge :: IO State
createChallenge = do
    bgc <- generateBGC
    wAddCenterMultiStr $ fst bgc
    challengeInput $ snd bgc
    return $ State 0 (snd bgc) ""

programloop :: State -> IO ()
programloop (State cha sol guess) = do
    writeGuess guess sol
    ch <- decodeKey <$> getch
    case ch of
        KeyChar a -> programloop $ State cha sol (guess ++ [a])
        _         -> return ()

    refresh
    threadDelay 100000
    programloop $ State cha sol guess