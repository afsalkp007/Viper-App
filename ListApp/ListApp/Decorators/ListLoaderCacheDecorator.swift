//
//  ListLoaderCacheDecorator.swift
//  ListApp
//
//  Created by Afsal on 13/07/2024.
//

import Core

public class ListLoaderCacheDecorator: ListLoader {
  private let decoratee: ListLoader
  private let cache: ListCache
  
  public init(decoratee: ListLoader, cache: ListCache) {
    self.decoratee = decoratee
    self.cache = cache
  }
  
  public func load(completion: @escaping (ListLoader.Result) -> Void) {
    decoratee.load { [weak self] result in
      completion(result.map { feed in
        self?.cache.saveIgnoringResult(feed)
        return feed
      })
    }
  }
}

private extension ListCache {
  func saveIgnoringResult(_ feed: [University]) {
    save(feed) { _ in }
  }
}
