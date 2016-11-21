{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Lib
    ( prettify
    ) where

import Data.Aeson (eitherDecode, Value(..))
import Data.Aeson.Encode.Pretty (encodePretty', confIndent, Indent(..),
    defConfig)
import qualified Data.ByteString.Lazy.UTF8 as U
import qualified Data.ByteString.Lazy.Char8 as LBS

prettify' :: LBS.ByteString -> LBS.ByteString
prettify' src = let (val :: Either String Value) = eitherDecode src
                in case val of
                    Left err -> LBS.pack err
                    Right val' -> encodePretty' conf val' where
                        conf = defConfig { confIndent = Spaces 2 }

prettify :: String -> String
prettify = U.toString . prettify' . U.fromString
