module Main where
  import qualified Database.Zookeeper as ZK
  import qualified Data.ByteString.Char8 as C8

  main = do
      let quorumZk     = "10.77.1.2:2181"
          timeoutInMs  = 5000
          watcher      = Nothing
          clientId     = Nothing
          path         = "/test1"
          pathChild    = "/test1/child"

      ZK.withZookeeper quorumZk timeoutInMs watcher clientId $ \zh -> do
          create zh path
          exists zh path watcher
          get zh path watcher
          set zh path "value756"
          get zh path watcher
          create zh pathChild
          getChildren zh path watcher


  create :: ZK.Zookeeper -> String -> IO String
  create zh path = do
      node <- ZK.create zh path (Just $ C8.pack "value") ZK.OpenAclUnsafe []
      case node of
          Left ZK.NodeExistsError -> return "a node already exists"
          Left e  -> error $ "error: " ++ show e
          Right _ -> return "a node has been created"


  exists :: ZK.Zookeeper -> String -> Maybe ZK.Watcher -> IO String
  exists zh path watcher = do
      node <- ZK.exists zh path Nothing
      case node of
          Left e -> error $ "error: " ++ show e
          Right st -> return $ show st


  get :: ZK.Zookeeper -> String -> Maybe ZK.Watcher -> IO String
  get zh path watcher = do
      node <- ZK.get zh path watcher
      case node of
          Left e  -> error $ "error: " ++ show e
          Right (Just value, st) -> return $  "value: " ++ C8.unpack value ++ show st
          Right (Nothing, st) -> return $ show st


  set :: ZK.Zookeeper -> String -> String -> IO String
  set zh path value = do
      node <- ZK.set zh path (Just $ C8.pack value) Nothing
      case node of
          Left e    -> error $ "error: " ++ show e
          Right res -> return $ show res

  getChildren zh path watcher = do
      node <- ZK.getChildren zh path watcher
      case node of
          Left e    -> error $ "error: " ++ show e
          Right res -> return $ show res
