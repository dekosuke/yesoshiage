module Handler.Root where
import Import

-- This is a handler function for the GET request method on the RootR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getRootR :: Handler RepHtml
getRootR = do
    setSession "hoge" "fuga"
    sess <- getSession
    defaultLayout $ do
        h2id <- lift newIdent
        setTitle "yesoshiage homepage"
        $(widgetFile "homepage")

getRegisterR :: Handler RepHtml
getRegisterR = do
    defaultLayout $ do
        h2id <- lift newIdent
        setTitle "新規メモ登録"
        $(widgetFile "register")

postRegisterR :: Handler RepHtml
postRegisterR = do
    memo <- runInputPost $ Memo 
              <$> ireq textField "memo"
    mid <- runDB $ do
        m <- insert $ memo
        return $ m
    let 
    defaultLayout $ do
        h2id <- lift newIdent
        setTitle "新規メモ登録"
        $(widgetFile "registerpost")

getDisplayR :: MemoId -> Handler RepHtml
getDisplayR mid = do
    memo <- runDB $ do
        m <- get404 mid
        return m
    defaultLayout $ do
        h2id <- lift newIdent
        setTitle "メモ表示"
        $(widgetFile "display")


