{-# LANGUAGE OverloadedStrings #-}
-- | View library.

module HL.V
  (module HL.V
  ,module V)
  where

import HL.Foundation as V (Route(..),App)
import HL.Static as V

import Control.Monad as V
import Data.Text as V (Text)
import Prelude as V hiding (span,head,min,max,id,div)
import Senza as V
import Senza.Bootstrap as V (container,row)
import Yesod.Senza as V

-- Latest Bootstrap requires extra work to get the old grid layout
-- behaviour of spans. I'll probably move this into senza.

span1 xs = div ([class_ "span1 col-md-1"] ++ xs)
span2 xs = div ([class_ "span2 col-md-2"] ++ xs)
span3 xs = div ([class_ "span3 col-md-3"] ++ xs)
span4 xs = div ([class_ "span4 col-md-4"] ++ xs)
span5 xs = div ([class_ "span5 col-md-5"] ++ xs)
span6 xs = div ([class_ "span6 col-md-6"] ++ xs)
span7 xs = div ([class_ "span7 col-md-7"] ++ xs)
span8 xs = div ([class_ "span8 col-md-8"] ++ xs)
span9 xs = div ([class_ "span9 col-md-9"] ++ xs)
span10 xs = div ([class_ "span10 col-md-10"] ++ xs)
span11 xs = div ([class_ "span11 col-md-11"] ++ xs)
span12 xs = div ([class_ "span12 col-md-12"] ++ xs)
