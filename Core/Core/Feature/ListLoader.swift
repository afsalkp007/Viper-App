//
//  ListLoader.swift
//  EssentialFeed
//
//  Created by Afsal on 09/03/2024.
//

import Foundation

public protocol ListLoader {
  typealias Result = Swift.Result<[University], Error>
  
  func load(completion: @escaping (Result) -> Void)
}
