module Main where

import Lib (prettify)
import Webview (jsFormatterWidget)
import Reflex.Dom
import GHCJS.DOM
import GHCJS.DOM.Document
import GHCJS.DOM.HTMLDivElement

main :: IO ()
main = runWebGUI $ \webview -> do
        doc <- webViewGetDomDocument webview
        case doc of
            Nothing -> mainWidget jsFormatterWidget
            Just doc' -> do
                e <- fmap castToHTMLDivElement <$>
                    getElementById doc' "mountpoint"
                case e of
                    Nothing -> putStrLn
                        "failed to mount widget on div 'mountpoint'"
                    Just e' -> attachWidget e' webview jsFormatterWidget
