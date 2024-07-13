//
//  ListViewPresenter.swift
//  ListDetail-Viper
//
//  Created by Afsal on 12/07/2024.
//

import Core

public final class ListViewPresenter: ListViewPresenterProtocol {
  
  public var listView: ListViewProtocol?
  public var listLoadingView: ListLoadingViewProtocol?
  public var listErrorView: ListErrorViewProtocol?
  public let interactor: ListViewInteractorInputProtocol

  public init(interactor: ListViewInteractorInputProtocol) {
    self.interactor = interactor
  }
  
  public func requestsUniversities() {
    listLoadingView?.display(ListLoadingViewModel(isLoading: true))
    interactor.getUniversityList()
  }
}

extension ListViewPresenter: ListViewInteractoryOutputProtocol {
  public func didFinishLoading(with items: [University]) {
    listView?.display(ListViewModel(items: items))
    listLoadingView?.display(ListLoadingViewModel(isLoading: false))
  }
  
  public func didFinishLoading(with error: String) {
    listLoadingView?.display(ListLoadingViewModel(isLoading: false))
    listErrorView?.display(.error(message: Localized.List.loadError))
  }
}
