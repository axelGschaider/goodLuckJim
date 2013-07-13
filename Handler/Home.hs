{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler Html
getHomeR = do
    (formWidget, formEnctype) <- generateFormPost secretForm
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Ei äm se pätsch häda!"
        $(widgetFile "homepage")
    --(formWidget, formEnctype) <- generateFormPost sampleForm
    --let submission = Nothing :: Maybe (FileInfo, Text)
    --    handlerName = "getHomeR" :: Text
    --defaultLayout $ do
    --    aDomId <- newIdent
    --    setTitle "Welcome To Yesod!"
    --    $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR = do
    ((result, formWidget), formEnctype) <- runFormPost secretForm
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "changed"
        $(widgetFile "homepage")
    --((result, formWidget), formEnctype) <- runFormPost sampleForm
    --let handlerName = "postHomeR" :: Text
    --    submission = case result of
    --        FormSuccess res -> Just res
    --        _ -> Nothing

    --defaultLayout $ do
    --    aDomId <- newIdent
    --    setTitle "Welcome To Yesod!"
    --    $(widgetFile "homepage")

secretForm :: Form Text
secretForm = renderDivs $ areq textField "The Message" Nothing

--sampleForm :: Form (FileInfo, Text)
--sampleForm = renderDivs $ (,)
--    <$> fileAFormReq "Choose a file"
--    <*> areq textField "What's on the file?" Nothing
