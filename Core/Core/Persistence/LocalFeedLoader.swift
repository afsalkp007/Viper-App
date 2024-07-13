//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Afsal on 18/03/2024.
//

import Foundation

public final class LocalFeedLoader {
  private let store: ListStore
  
  public init(store: ListStore) {
    self.store = store
  }
}

extension LocalFeedLoader: ListCache {
  public typealias SaveResult = ListCache.Result
  
  public func save(_ feed: [University], completion: @escaping (SaveResult) -> Void) {
    store.deleteCachedFeed { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success:
        self.cache(feed, completion: completion)
        
      case let .failure(error):
        completion(.failure(error))
      }
    }
  }
  
  private func cache(_ items: [University], completion: @escaping (SaveResult) -> Void) {
    store.insert(items.toLocal(), completion: { [weak self] result in
      guard self != nil else { return }
      
      switch result {
      case .success:
        break
        
      case let .failure(error):
        completion(.failure(error))
      }
    })
  }
}

extension LocalFeedLoader: ListLoader {
  enum Error: Swift.Error {
    case emptyData
  }
 
  public typealias LoadResult = ListLoader.Result
  
  public func load(completion: @escaping (LoadResult) -> Void) {
    store.retrieve { [weak self] result in
      guard self != nil else { return }
      
      switch result {
      case let .failure(error):
        completion(.failure(error))
        
      case let .success(.some(cache)):
        completion(.success(cache.feed.toModels()))
        
      case .success:
        completion(.failure(Error.emptyData))
      }
    }
  }
}

private extension Array where Element == University {
  func toLocal() -> [LocalListItem] {
    return map { LocalListItem(name: $0.name, country: $0.country, code: $0.code, state: $0.state, webpage: $0.webpage) }
  }
}

private extension Array where Element == LocalListItem {
  func toModels() -> [University] {
    return map { University( name: $0.name, country: $0.country, code: $0.code, state: $0.state, webpage: $0.webpage) }
  }
}
