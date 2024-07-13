//
//  ListUIComposer.swift
//  ListApp
//
//  Created by Afsal on 13/07/2024.
//

import Core
import ModuleA

final class ListUIComposer {
  private init() {}
  
  static func listComposedWith(
    with loader: ListLoader, 
    selection: @escaping (University) -> Void) -> ListViewController {
    let controller = ListViewRouter.assemble(with: Localized.List.title)
        
    let interactor = ListViewInteractor(
      loader: MainQueueDispatchDecorator(decoratee: loader))
    let presenter = ListViewPresenter(
      interactor: interactor)
    
    presenter.listView = ListViewAdapter(
      controller: controller,
      selection: selection)
    presenter.listLoadingView = WeakRefVirtualProxy(controller)
    presenter.listErrorView = WeakRefVirtualProxy(controller)
    
    controller.presenter = presenter
    interactor.presenter = presenter

    return controller
  }
}
