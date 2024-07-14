//
//  Localized+List.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
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
        comment: "Title for the list view"
      )
    }
    
    public static var loadError: String {
      return NSLocalizedString(
        "LIST_VIEW_CONNECTION_ERROR",
        tableName: list,
        bundle: Bundle(for: ListViewPresenter.self),
        comment: "Error message for the list error view"
      )
    }
  }
}
