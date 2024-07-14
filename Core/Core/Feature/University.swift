//
//  University.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

public struct University: Equatable {
  public let name: String
  public let country: String
  public let code: String
  public let state: String?
  public let webpage: String?
  
  public init(name: String, country: String, code: String, state: String?, webpage: String?) {
    self.name = name
    self.country = country
    self.code = code
    self.state = state
    self.webpage = webpage
  }
}
