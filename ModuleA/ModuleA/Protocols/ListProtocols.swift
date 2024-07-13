//
//  Protocols.swift
//  ListDetail-Viper
//
//  Created by Afsal on 12/07/2024.
//

import Core

public protocol ListViewProtocol: AnyObject {
  func display(_ viewModel: ListViewModel)
}

public protocol ListLoadingViewProtocol: AnyObject {
  func display(_ viewModel: ListLoadingViewModel)
}

public protocol ListErrorViewProtocol: AnyObject {
  func display(_ viewModel: ListErrorViewModel)
}

public protocol ListViewPresenterProtocol: AnyObject {
  var listView: ListViewProtocol? {get set}
  var listLoadingView: ListLoadingViewProtocol? {get set}
  var listErrorView: ListErrorViewProtocol? {get set}
  var interactor: ListViewInteractorInputProtocol {get}

  func requestsUniversities()
}

public protocol ListViewInteractorInputProtocol: AnyObject {
  var presenter: ListViewInteractoryOutputProtocol? {get set}
  func getUniversityList()
}

public protocol ListViewInteractoryOutputProtocol: AnyObject {
  func didFinishLoading(with items: [University])
  func didFinishLoading(with error: String)
}

public protocol ListViewRouterProtocol: AnyObject {
  //unc pushToDetail(with title: String, model: University)
  static func assemble(with title: String) -> ListViewController
}

public protocol ListCellViewProtocol {
  func display(_ viewModel: ListCellViewModel)
}

public protocol ListCellPresenterProtocol {
  var router: ListViewRouterProtocol {get}
  
  func loadData(for model: University)
}


