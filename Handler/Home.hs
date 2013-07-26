{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import
import Data.Time

import Data.ByteString.Char8 (pack)
import Data.Char (isAlphaNum)
import Crypto.Hash.SHA256 (hash)


getHomeR :: Handler Html
getHomeR = do
    (formWidget, formEnctype) <- generateFormPost secretForm
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Ei äm se pätsch häda!"
        $(widgetFile "homepage")


postHomeR :: Handler Html
postHomeR = do
    ((result, formWidget), formEnctype) <- runFormPost secretForm
    defaultLayout $ do
        aDomId <- newIdent
        mKey <- liftIO getMessageKey
        setTitle $ toHtml mKey
        $(widgetFile "homepage")

preSalt :: String
preSalt = "ASDdasdj2 1sdf2"

postSalt :: String
postSalt = "fskjs23823e d2jh2d 2djhbsd**DSF§ſðđªð"

hashIt :: String -> String
hashIt =  show . hash . pack . (++ postSalt) . ( preSalt ++ )

createMessageKey :: String -> String
createMessageKey = filter ( isAlphaNum ) . hashIt

getMessageKey :: IO String 
getMessageKey = fmap ( createMessageKey . show ) getCurrentTime

secretForm :: Form Text
secretForm = renderDivs $ areq textField "The Message" Nothing

