//
//  ListViewController.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import UIKit

public final class ListViewController: UITableViewController {
  @IBOutlet private(set) var errorView: ErrorView!
  
  private var onViewIsAppearing: ((ListViewController) -> Void)?
  public var presenter: ListViewPresenterProtocol?
  
  private var tableModel = [ListCellController]() {
    didSet { tableView.reloadData() }
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    onViewIsAppearing = { vc in
      vc.refreshData()
    }
  }
  
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    tableView.sizeTableHeaderToFit()
  }
  
  public override func viewIsAppearing(_ animated: Bool) {
    super.viewIsAppearing(animated)
    
    onViewIsAppearing?(self)
  }
  
  public func display(_ cellControllers: [ListCellController]) {
    self.tableModel = cellControllers
  }
  
  @IBAction func refreshData() {
    presenter?.requestsUniversities()
  }
}

extension ListViewController: ListLoadingViewProtocol, ListErrorViewProtocol {
  public func display(_ viewModel: ListLoadingViewModel) {
    refreshControl?.isHidden = !viewModel.isLoading
    refreshControl?.update(viewModel.isLoading)
  }
  
  public func display(_ viewModel: ListErrorViewModel) {
    errorView.message = viewModel.message
  }
}
 
extension ListViewController: UITableViewDataSourcePrefetching {
  public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableModel.count
  }
  
  public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return cellController(forRowAt: indexPath).view(in: tableView)
  }
  
  public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    removeCellController(forRowAt: indexPath)
  }
  
  public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let dl = cellController(forRowAt: indexPath)
    dl.tableView(tableView, didSelectRowAt: indexPath)
  }
  
  public override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cellController(forRowAt: indexPath).preload()
  }
  
  public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    indexPaths.forEach { indexPath in
      cellController(forRowAt: indexPath).preload()
    }
  }
  
  public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    indexPaths.forEach(removeCellController)
  }
  
  private func removeCellController(forRowAt indexPath: IndexPath) {
    cellController(forRowAt: indexPath).cancelLoad()
  }
  
  private func cellController(forRowAt indexPath: IndexPath) -> ListCellController {
    return tableModel[indexPath.row]
  }
}

