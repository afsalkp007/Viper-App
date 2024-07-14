//
//  MainQueueDispatchDecorator.swift
//  ListApp
//
//  Created by Afsal on 13/07/2024.
//

import Foundation
import Core

final class MainQueueDispatchDecorator<T> {
  private let decoratee: T
  
  init(decoratee: T) {
    self.decoratee = decoratee
  }
  
  func dispatch(completion: @escaping () -> Void) {
    guard Thread.isMainThread else {
      return DispatchQueue.main.async(execute: completion)
    }
    
    completion()
  }
}

extension MainQueueDispatchDecorator: ListLoader where T == ListLoader {
  func load(completion: @escaping (ListLoader.Result) -> Void) {
    decoratee.load { [weak self] result in
      self?.dispatch { completion(result) }
    }
  }
}
