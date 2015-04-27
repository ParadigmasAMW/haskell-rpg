{-# LANGUAGE CPP#-}
module Paths (getStaticDir) where

import Control.Monad
import System.FilePath

getStaticDir :: IO FilePath
getStaticDir = return "static"


