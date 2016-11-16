{-# LANGUAGE OverloadedStrings #-}
module Webview
    (jsFormatterWidget
    ) where

import Reflex.Dom
import Lib (prettify)
import Control.Lens ((^.), (&), (.~))
import qualified Data.Map as M

jsFormatterWidget :: MonadWidget t m => m ()
jsFormatterWidget = do
    {-let taAttr = constDyn $ M.singleton "class" "materialize-textarea"-}
    divClass "container" $
        divClass "row" $ do
            ta1Value <- divClass "input-field col s6" $ do
                ta1 <- textArea $ def -- & textAreaConfig_attributes .~ taAttr
                return $ ta1 ^. textArea_input
            divClass "input-field col s6" $ textArea $
                    def & textAreaConfig_setValue .~ (prettify <$> ta1Value)
                        {-& textAreaConfig_attributes .~ taAttr-}
    return ()
