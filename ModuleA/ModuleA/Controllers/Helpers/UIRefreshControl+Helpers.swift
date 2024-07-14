//
//  UIRefreshControl+Helpers.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import UIKit

extension UIRefreshControl {
  func update(_ isRefreshing: Bool) {
    isRefreshing ? beginRefreshing() : endRefreshing()
  }
}

