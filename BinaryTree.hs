module BinaryTree (history, buildTree, preOrder) where

import System.Process

data ArvBin elemento = Nulo
	|Node elemento (ArvBin elemento)(ArvBin elemento)
	deriving (Show, Eq)

clear = system "cls"	

history :: (Eq elemento, Show elemento) => BinaryTree.ArvBin elemento -> IO()
history (Node elemento Nulo Nulo) = do
	clear
	print elemento
	putStrLn "Fim de jogo"
history (Node elemento esq dir) = do
	clear
	print elemento
	putStrLn "Faca sua escolha: "
	path <- readLn
	if ((path == 1) && (esq /= Nulo)) then 
			(history (esq)) 
		else (if ((path == 2) && (dir /= Nulo)) then 
			(history (dir))
		else history(Node elemento esq dir))

buildTree :: [elemento] -> BinaryTree.ArvBin elemento
buildTree [] = Nulo
buildTree list = (Node (list !! half)(buildTree $ take half list) (buildTree $ drop (half+1) list))
    where half = length list `quot` 2

preOrder :: (Ord elemento) => BinaryTree.ArvBin elemento -> [elemento]
preOrder Nulo = []
preOrder (Node elemento esq dir) = [elemento] ++ (preOrder esq) ++ (preOrder dir)
