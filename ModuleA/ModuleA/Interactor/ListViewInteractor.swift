//
//  ListViewInteractor.swift
//  ListDetail-Viper
//
//  Created by Afsal on 13/07/2024.
//

import Core

public final class ListViewInteractor: ListViewInteractorInputProtocol {
  
  public weak var presenter: ListViewInteractoryOutputProtocol?
  private let feedLoader: ListLoader
  
  public init(loader: ListLoader) {
    self.feedLoader = loader
  }
  
  public func getUniversityList() {
    feedLoader.load { [weak presenter] result in
      switch result {
      case let .success(items):
        presenter?.didFinishLoading(with: items)
        
      case let .failure(error):
        presenter?.didFinishLoading(with: error.localizedDescription)
      }
    }
  }
}
