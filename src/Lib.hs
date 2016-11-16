{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Lib
    ( prettify
    ) where

import Data.Aeson (eitherDecode, Value(..))
import Data.Aeson.Encode.Pretty (encodePretty)
import qualified Data.ByteString.Lazy.Char8 as LBS

prettify' :: LBS.ByteString -> LBS.ByteString
prettify' src = let (val :: Either String Value) = eitherDecode src
                in case val of
                    Left err -> LBS.concat ["invalid json: ", LBS.pack err]
                    Right val' -> encodePretty val'

prettify :: String -> String
prettify = LBS.unpack . prettify' . LBS.pack
