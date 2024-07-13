//
//  WeakRefVirtualProxy.swift
//  EssentialFeediOS
//
//  Created by Afsal on 18/04/2024.
//

import ModuleA
import ModuleB

final class WeakRefVirtualProxy<T: AnyObject> {
  private weak var object: T?
  
  init(_ object: T) {
    self.object = object
  }
}

extension WeakRefVirtualProxy: ListLoadingViewProtocol where T: ListLoadingViewProtocol {
  func display(_ viewModel: ListLoadingViewModel) {
    object?.display(viewModel)
  }
}

extension WeakRefVirtualProxy: ListErrorViewProtocol where T: ListErrorViewProtocol {
  func display(_ viewModel: ListErrorViewModel) {
    object?.display(viewModel)
  }
}

extension WeakRefVirtualProxy: ListCellViewProtocol where T: ListCellViewProtocol {
  func display(_ viewModel: ListCellViewModel) {
    object?.display(viewModel)
  }
}

extension WeakRefVirtualProxy: DetailViewProtocol where T: DetailViewProtocol {
  func display(_ viewModel: DetailViewModel) {
    object?.display(viewModel)
  }
}
