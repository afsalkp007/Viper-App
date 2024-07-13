//
//  FeedImagePresenter.swift
//  EssentialFeed
//
//  Created by Afsal on 22/04/2024.
//

import Core

public final class ListCellPresenter: ListCellPresenterProtocol {
  private let view: ListCellViewProtocol
  public let router: ListViewRouterProtocol
  
  public init(view: ListCellViewProtocol, router: ListViewRouterProtocol) {
    self.view = view
    self.router = router
  }
  
  public func loadData(for model: University) {
    view.display(
      ListCellViewModel(
        name: model.name,
        state: model.state ?? "NA"
      )
    )
  }
}
