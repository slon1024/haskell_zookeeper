# Haskell + Zookeeper = :heart::heart::heart:

## Prerequisites
* [ZooKeeper](http://zookeeper.apache.org/) (*you can use this  [vagrant](https://github.com/slon1024/vagrant-cluster-storm) setup*)
* `cabal install` [hzk](https://github.com/dgvncsz0f/hzk)

## Examples
Uncomment line by line and check what happens :smile:
```
ZK.withZookeeper quorumZk timeoutInMs watcher clientId $ \zh -> do
  -- create zh path
  -- exists zh path watcher
  -- get zh path watcher
  -- set zh path "value756"
  -- get zh path watcher
  -- create zh pathChild
  -- getChildren zh path watcher
```
* [Zookeeper.hs](https://github.com/slon1024/haskell_zookeeper/blob/master/Zookeeper.hs)

## Run it
* `vangrant up` #see prerequisites
* `runhaskell` [Zookeeper.hs](https://github.com/slon1024/haskell_zookeeper/blob/master/Zookeeper.hs)
