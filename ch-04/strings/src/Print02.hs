-- Print02.hs
module Print02 where

main :: IO () 
main = do
  putStrLn "Count to four for me:"
  putStr   "one, two"
  putStr   ", three, and"
  putStrLn " four!"
