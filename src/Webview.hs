{-# LANGUAGE OverloadedStrings #-}
module Webview
    (jsFormatterWidget
    ) where

import Reflex.Dom

jsFormatterWidget :: MonadWidget t m => m ()
jsFormatterWidget = do
    ti <- textInput def
    return ()
