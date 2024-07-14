//
//  RemoteListItem.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

struct RemoteListItem: Decodable {
  let name: String
  let country: String
  let code: String
  let state: String?
  let webpage: String?
}
