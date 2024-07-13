//
//  DetailViewProtocols.swift
//  ListDetail-Viper
//
//  Created by Afsal on 13/07/2024.
//

import Core

public protocol DetailViewProtocol: AnyObject {
  func display(_ viewModel: DetailViewModel)
}

public protocol DetailViewPresenterProtocol: AnyObject {
  var detailView: DetailViewProtocol? {get set}
  var interactor: DetailViewInteractorInputProtocol {get}
  var router: DetailViewRouterProtocol {get}

  func requestData()
  func dismiss()
}

public protocol DetailViewInteractorInputProtocol: AnyObject {
  var presenter: DetailViewInteractorOutputProtocol? {get set}
  func getUniversityData()
}

public protocol DetailViewInteractorOutputProtocol: AnyObject {
  func didFinishLoading(with model: University)
}

public protocol DetailViewRouterProtocol: AnyObject {
  func dismiss()
}


