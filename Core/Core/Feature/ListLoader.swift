//
//  ListLoader.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

public protocol ListLoader {
  typealias Result = Swift.Result<[University], Error>
  
  func load(completion: @escaping (Result) -> Void)
}
