//
//  Protocols.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
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
  var router: ListViewRouterProtocol {get}
  var interactor: ListViewInteractorInputProtocol {get}

  func requestsUniversities()
}

public protocol ListViewInteractorInputProtocol: AnyObject {
  var presenter: ListViewInteractoryOutputProtocol? {get set}
  func getUniversityList()
}

public protocol ListViewInteractoryOutputProtocol: AnyObject {
  func didFinishLoading(with feed: [University])
  func didFinishLoading(with error: String)
}

public protocol ListViewRouterProtocol: AnyObject {
  static func assemble(with title: String) -> ListViewController
}

public protocol ListCellViewProtocol {
  func display(_ viewModel: ListCellViewModel)
}

public protocol ListCellPresenterProtocol {
  func loadData(for model: University)
}


