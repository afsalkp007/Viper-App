//
//  Localized+Detail.swift
//  ModuleB
//
//  Created by Afsal on 12/07/2024.
//

import Foundation
import Core

extension Localized {
  private static var detail: String { "Detail" }
  
  public enum Detail {
    public static var title: String {
      return NSLocalizedString(
        "DETAIL_VIEW_TITLE",
        tableName: detail,
        bundle: Bundle(for: DetailViewPresenter.self),
        comment: "Title for the detail view"
      )
    }
  }
}
