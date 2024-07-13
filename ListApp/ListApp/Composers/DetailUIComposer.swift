//
//  DetailUIComposer.swift
//  ListApp
//
//  Created by Afsal on 13/07/2024.
//

import Core
import ModuleB

final class DetailUIComposer {
  private init() {}
  
  static func detailComposed(with model: University) -> DetailViewController {
    let controller = DetailViewRouter.assemble(with: Localized.Detail.title, model: model)
    
    let router = DetailViewRouter(view: controller)
    let interactor = DetailViewInteractor(model: model)
    let presenter = DetailViewPresenter(
      interactor: interactor,
      router: router)
    
    controller.presenter = presenter
    presenter.detailView = WeakRefVirtualProxy(controller)
    interactor.presenter = presenter

    return controller
  }
}
