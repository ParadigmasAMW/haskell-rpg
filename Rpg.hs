import qualified Data.Text    as Text
import qualified Data.Text.IO as Text
import BinaryTree (history, buildTree)
import System.Process

clear = system "clear"

play = do
	clear
	script <- fmap Text.lines (Text.readFile "storyFile.txt")
	let rpgBinTree = buildTree script
	history rpgBinTree
	putStrLn "Deseja batalhar novamente? (1 SIM, 2 NAO)"
	playAgain <- readLn
	if (playAgain == 1) then (play) else  print "Obrigado por jogar!"
