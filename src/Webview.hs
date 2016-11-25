{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ForeignFunctionInterface #-}
module Webview
    (jsFormatterWidget
    ) where

import Reflex.Dom
import Lib (prettify)
import Control.Lens ((^.), (&), (.~))
import qualified GHCJS.DOM.Types as GDT
import Data.Monoid ((<>))
import Control.Monad.IO.Class (liftIO)
import JavaScript.JQuery hiding (Event)
import Control.Concurrent
import Control.Monad

autoresize :: MonadWidget t m => GDT.HTMLElement -> Event t a -> m (Event t ())
autoresize el ev = do
    jsel <- liftIO $ selectElement el
    performArg (const $ trigger "autoresize" jsel) ev

performArg :: MonadWidget t m => (b -> IO a) -> Event t b -> m (Event t a)
performArg f x = performEvent (fmap (liftIO . f) x)

jsFormatterWidget :: MonadWidget t m => m ()
jsFormatterWidget = do
    let taAttr = constDyn $ "class" =: "materialize-textarea" <>
                            "style" =: "font-family:monospace;"
    rdOnlyAttr <- mapDyn (\a -> a <> ("readonly" =: "")) taAttr
    divClass "row" $ do
        ta1Ev <- divClass "input-field col s6" $ do
            ta1 <- textArea $ def & textAreaConfig_attributes .~ taAttr
            autoresize (GDT.castToHTMLElement $ _textArea_element ta1)  (ta1 ^. textArea_input)
            return $ ta1 ^. textArea_input
        divClass "input-field col s6" $ do
            let prettifyEv = prettify <$> ta1Ev
            ta2 <- textArea $ def & textAreaConfig_attributes .~ rdOnlyAttr
                                    & textAreaConfig_setValue .~ prettifyEv
            newEv <- delay 0.01 prettifyEv
            autoresize (GDT.castToHTMLElement $ _textArea_element ta2) newEv
    return ()
