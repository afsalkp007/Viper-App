//
//  ListViewInteractor.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import Core

public final class ListViewInteractor: ListViewInteractorInputProtocol {
  
  public weak var presenter: ListViewInteractoryOutputProtocol?
  private let listLoader: ListLoader
  
  public init(loader: ListLoader) {
    self.listLoader = loader
  }
  
  public func getUniversityList() {
    listLoader.load { [weak presenter] result in
      switch result {
      case let .success(feed):
        presenter?.didFinishLoading(with: feed)
        
      case let .failure(error):
        presenter?.didFinishLoading(with: error.localizedDescription)
      }
    }
  }
}
