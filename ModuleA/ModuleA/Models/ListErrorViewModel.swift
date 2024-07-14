//
//  ListErrorViewModel.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import Foundation

public struct ListErrorViewModel {
  let message: String?
  
  static var noError: ListErrorViewModel {
    return ListErrorViewModel(message: .none)
  }
  
  static func error(message: String) -> ListErrorViewModel {
    return ListErrorViewModel(message: message)
  }
}
