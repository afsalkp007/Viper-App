//
//  Localized+List.swift
//  EssentialFeed
//
//  Created by Afsal on 22/04/2024.
//

import Foundation
import Core

public extension Localized {
  private static var list: String { "List" }
  
  enum List {
    public static var title: String {
      return NSLocalizedString(
        "LIST_VIEW_TITLE",
        tableName: list,
        bundle: Bundle(for: ListViewPresenter.self),
        comment: "Title for the feed view"
      )
    }
    
    public static var loadError: String {
      return NSLocalizedString(
        "LIST_VIEW_CONNECTION_ERROR",
        tableName: list,
        bundle: Bundle(for: ListViewPresenter.self),
        comment: "Error message for the feed error view"
      )
    }
  }
}
