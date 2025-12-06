-- thanks to vgamula for answer after hard struggle
-- I am too weak for haskell
-- https://github.com/vgamula/advent-of-code/tree/main/2025/03

import System.Environment (getArgs)
import System.IO (readFile)

import Data.Char (digitToInt)
import Data.List (lines, elemIndex)
import Data.Maybe (fromJust)

inputsToInts :: String -> [[Int]]
inputsToInts s = map (map digitToInt) (lines s)

slice :: [a] -> Int -> Int -> [a]
slice xs s f = take (f - s) (drop s xs)

maxJ :: [Int] -> Int -> Int -> Int ->Int
maxJ bank from remain res =
    if remain == 0
        then res
        else
            let s = slice bank from (length bank - remain + 1)
                max_from_s = maximum s
                max_idx = fromJust (elemIndex max_from_s s)
            in maxJ bank (from + max_idx + 1) (remain - 1) (res * 10 + max_from_s)

totalOut :: [[Int]] -> Int -> Int
totalOut banks num_batteries =
    let res = map (\bank -> maxJ bank 0 num_batteries 0) banks
        in sum res

main :: IO ()
main = do
    args <- getArgs -- Get a list of command-line arguments
    case args of
        [filePath] -> do -- Expecting exactly one argument: the file path
            contents <- readFile filePath -- Read the entire file content
            print $ totalOut (inputsToInts contents) 2
            print $ totalOut (inputsToInts contents) 12
            -- print $ length $ map findMaxValIdx take (length )(inputsToInts contents)
        _ -> putStrLn "Usage: ./Main <filepath>"

