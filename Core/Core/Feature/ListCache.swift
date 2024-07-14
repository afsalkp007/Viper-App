//
//  ListCache.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

public protocol ListCache {
  typealias Result = Swift.Result<Void, Error>
  
  func save(_ feed: [University], completion: @escaping (Result) -> Void)
}
