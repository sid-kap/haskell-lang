{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS -fno-warn-orphans #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns #-}
{-# OPTIONS -fno-warn-name-shadowing #-}

-- | Yesod foundation.

module HL.Foundation
  (module HL.Static
  ,App(..)
  ,Route(..)
  ,Handler
  ,Widget
  ,resourcesApp
  ,Slug(..)
  ,Human(..)
  ,Mode(..))
  where

import Control.Concurrent.MVar.Lifted
import HL.Static
import HL.Types

import Data.Monoid
import Data.Text (Text)
import Data.Text (pack)
import Network.Wai.Logger
import System.Log.FastLogger
import Yesod
import Yesod.Caching
import Yesod.Core.Types
import Yesod.Slug
import Yesod.Static

-- | Generate boilerplate.
mkYesodData "App" $(parseRoutesFile "config/routes")

-- | Don't log anything to stdout.
instance Yesod App where
  makeLogger _ =
    do set <- newFileLoggerSet 1000 "/dev/null"
       (date,_) <- clockDateCacher
       return (Logger {loggerSet = set
                      ,loggerDate = date})

  defaultLayout widget =
    do app <- getYesod
       appDefaultLayout app widget

  -- We make no usage of Yesod's session features in this site, so disable it
  -- to avoid unnecessary overhead and cookie header generation.
  makeSessionBackend _ = return Nothing

instance MonadCaching (HandlerT App IO) where
  withCacheDir cont =
    do dirVar <- fmap appCacheDir getYesod
       withMVar dirVar cont

instance Human (Route App) where
  toHuman r =
    case r of
      CommunityR           -> "Community"
      IrcR                 -> "IRC"
      DocumentationR       -> "Documentation"
      HomeR                -> "Home"
      DonateR              -> "Donate"
      MailingListsR        -> "Mailing Lists"
      NewsR                -> "News"
      StaticR{}            -> "Static"
      GetStartedR          -> "Get Started"
      AnnouncementsR       -> "Announcements"
      WikiR t              -> "Wiki: " <> t
      ReportNodeR _ _      -> "Report Page"
      ReportModeR Node i   -> "Node " <> pack (show i)
      ReportModeR Mono i   -> "Mono " <> pack (show i)
      ReportR{}            -> "Report"
      WikiHomeR{}          -> "Wiki"
      PackagesR{}          -> "Packages"
      FeedR{}              -> "News Feed"

instance Slug (Route App) where
  toSlug r =
    case r of
      CommunityR        -> "community"
      IrcR              -> "irc"
      DocumentationR    -> "documentation"
      HomeR             -> "home"
      DonateR           -> "donate"
      MailingListsR     -> "mailing-lists"
      NewsR             -> "news"
      StaticR{}         -> "static"
      GetStartedR       -> "get-started"
      AnnouncementsR    -> "announcements"
      WikiR{}           -> "wiki"
      ReportNodeR{}     -> "report"
      ReportModeR{}     -> "report"
      ReportR{}         -> "report"
      WikiHomeR{}       -> "wiki"
      PackagesR{}       -> "packages"
      FeedR{}           -> "feed"
