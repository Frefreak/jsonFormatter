{-# LANGUAGE OverloadedStrings #-}
module Webview
    (jsFormatterWidget
    ) where

import Reflex.Dom
import Lib (prettify)
import Control.Lens ((^.), (&), (.~))

jsFormatterWidget :: MonadWidget t m => m ()
jsFormatterWidget = do
    ta1 <- textArea def
    ta2Value <- holdDyn "" $ ta1 ^. textArea_input
    let ta1Value = ta1 ^. textArea_input
    ta2 <- textArea $ def & textAreaConfig_setValue .~ (prettify <$> ta1Value)
    return ()
