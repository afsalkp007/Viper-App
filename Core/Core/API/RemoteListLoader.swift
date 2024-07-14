//
//  RemoteListLoader.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

public final class RemoteListLoader: ListLoader {
  private let url: URL
  private let client: HTTPClient
  
  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }
}
 
extension RemoteListLoader {
  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }
  
  public typealias Result = ListLoader.Result
  
  public func load(completion: @escaping (Result) -> Void) {
    client.get(from: url) { [weak self] result in
      guard self != nil else { return }
      
      switch result {
      case let .success((data, response)):
        completion(Self.map(data, from: response))
      case .failure:
        completion(.failure(Error.connectivity))
      }
    }
  }
  
  private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
    do {
      let feed = try ListItemsMapper.map(data, from: response)
      return .success(feed.toModels())
    } catch {
      return .failure(error)
    }
  }
}

private extension Array where Element == RemoteListItem {
  func toModels() -> [University] {
    return map { University(name: $0.name, country: $0.country, code: $0.code, state: $0.state, webpage: $0.webpage) }
  }
}
