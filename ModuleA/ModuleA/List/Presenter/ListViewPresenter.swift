//
//  ListViewPresenter.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import Core

public final class ListViewPresenter: ListViewPresenterProtocol {
  public var listView: ListViewProtocol?
  public var listLoadingView: ListLoadingViewProtocol?
  public var listErrorView: ListErrorViewProtocol?
  public let router: ListViewRouterProtocol
  public let interactor: ListViewInteractorInputProtocol

  public init(interactor: ListViewInteractorInputProtocol, router: ListViewRouterProtocol) {
    self.interactor = interactor
    self.router = router
  }
  
  public func requestsUniversities() {
    listLoadingView?.display(ListLoadingViewModel(isLoading: true))
    interactor.getUniversityList()
  }
}

extension ListViewPresenter: ListViewInteractoryOutputProtocol {
  public func didFinishLoading(with feed: [University]) {
    listView?.display(ListViewModel(feed: feed))
    listLoadingView?.display(ListLoadingViewModel(isLoading: false))
  }
  
  public func didFinishLoading(with error: String) {
    listLoadingView?.display(ListLoadingViewModel(isLoading: false))
    listErrorView?.display(.error(message: Localized.List.loadError))
  }
}
