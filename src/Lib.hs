{-# LANGUAGE OverloadedStrings, ScopedTypeVariables #-}
module Lib
    ( prettify
    ) where

import Data.Aeson (decode, Value(..))
import Data.Aeson.Encode.Pretty (encodePretty)
import qualified Data.ByteString.Lazy.Char8 as LBS

prettify :: LBS.ByteString -> LBS.ByteString
prettify src = let (val :: Maybe Value) = decode src
                in case val of
                    Nothing -> "invalid json"
                    Just val' -> encodePretty val'
