//
//  ListCellPresenter.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import Core

public final class ListCellPresenter: ListCellPresenterProtocol {
  private let view: ListCellViewProtocol
  
  public init(view: ListCellViewProtocol) {
    self.view = view
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
