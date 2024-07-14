//
//  ListViewAdapter.swift
//  ListApp
//
//  Created by Afsal on 13/07/2024.
//

import Core
import ModuleA

final class ListViewAdapter: ListViewProtocol {
  private weak var controller: ListViewController?
  private let selection: (University) -> Void
  
  init(controller: ListViewController, selection: @escaping (University) -> Void) {
    self.controller = controller
    self.selection = selection
  }
  
  func display(_ viewModel: ListViewModel) {
    let controller = self.controller
    controller?.display(viewModel.feed.map { [weak self] model in
      let view = ListCellController(model: model, selection: {
        self?.selection(model)
      })
      
      view.presenter = ListCellPresenter(
        view: WeakRefVirtualProxy(view))

      return view
    })
  }
}
