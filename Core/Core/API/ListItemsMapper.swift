//
//  FeedItemsMapper.swift
//  Core
//
//  Created by Afsal on 14/07/2024.
//

import Foundation

final class ListItemsMapper {

  private struct Item: Decodable {
    let name: String
    let country: String
    let code: String
    let state: String?
    let webpages: [String]

    var remote: RemoteListItem {
      return RemoteListItem(name: name, country: country, code: code, state: state, webpage: webpages.first)
    }
    
    private enum CodingKeys: String, CodingKey {
      case name
      case country
      case code = "alpha_two_code"
      case state = "state-province"
      case webpages = "web_pages"
    }
  }
    
  static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteListItem] {
    guard response.isOK, let feed = try? JSONDecoder().decode([Item].self, from: data) else {
      throw RemoteListLoader.Error.invalidData
    }
    
    return feed.map(\.remote)
  }
}
