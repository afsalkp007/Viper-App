//
//  DetailViewPresenter.swift
//  ModuleB
//
//  Created by Afsal on 13/07/2024.
//

import Core

public final class DetailViewPresenter: DetailViewPresenterProtocol {
  public var detailView: DetailViewProtocol?
  public var interactor: DetailViewInteractorInputProtocol
  public var router: DetailViewRouterProtocol
  
  public init(interactor: DetailViewInteractorInputProtocol, router: DetailViewRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
  
  public func requestData() {
    interactor.getUniversityData()
  }
  
  public func dismiss() {
    router.dismiss()
  }
}

extension DetailViewPresenter: DetailViewInteractorOutputProtocol {
  public func didFinishLoading(with model: University) {
    detailView?.display(
      DetailViewModel(
        name: model.name,
        country: model.country,
        code: model.code,
        state: model.state ?? "NA",
        webpage: model.webpage))
  }
}
