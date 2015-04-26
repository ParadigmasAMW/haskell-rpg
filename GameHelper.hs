 import System.Random
 module(rollDice)where
 	
  rollDice :: IO Int
  rollDice = getStdRandom (randomR (1,6))