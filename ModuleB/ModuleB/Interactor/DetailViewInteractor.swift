//
//  DetailViewInteractor.swift
//  ModuleB
//
//  Created by Afsal on 13/07/2024.
//

import Core

public final class DetailViewInteractor: DetailViewInteractorInputProtocol {
  public weak var presenter: DetailViewInteractorOutputProtocol?
  private let model: University
  
  public init(model: University) {
    self.model = model
  }
  
  public func getUniversityData() {
    presenter?.didFinishLoading(with: model)
  }
}
