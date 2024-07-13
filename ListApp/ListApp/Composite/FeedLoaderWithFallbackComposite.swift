//
//  FeedLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Afsal on 27/04/2024.
//

import Core

public final class FeedLoaderWithFallbackComposite: ListLoader {
  private let primary: ListLoader
  private let fallback: ListLoader
  
  public init(primary: ListLoader, fallback: ListLoader) {
    self.primary = primary
    self.fallback = fallback
  }
  
  public func load(completion: @escaping (ListLoader.Result) -> Void) {
    primary.load { [weak self] result in
      switch result {
      case let .success(feed):
        completion(.success(feed))
        
      case .failure:
        self?.fallback.load(completion: completion)
      }
    }
  }
}
