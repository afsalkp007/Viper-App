//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Afsal on 18/03/2024.
//

import Foundation

struct RemoteFeedItem: Decodable {
  let name: String
  let country: String
  let code: String
  let state: String?
  let webpage: String?
}
