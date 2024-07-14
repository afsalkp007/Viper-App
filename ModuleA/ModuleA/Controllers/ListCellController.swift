//
//  FeedImageCellController.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import UIKit
import Core

public typealias EmptyClosure = () -> Void

public final class ListCellController: NSObject, ListCellViewProtocol {
  public var presenter: ListCellPresenterProtocol?
  private let selection: EmptyClosure
  private let model: University
  private var cell: ListCell?
  
  public init(model: University, selection: @escaping EmptyClosure) {
    self.model = model
    self.selection = selection
  }

  func view(in tableView: UITableView) -> UITableViewCell {
    self.cell = tableView.dequeueReusableCell()
    presenter?.loadData(for: model)
    return cell!
  }
  
  public func display(_ viewModel: ListCellViewModel) {
    cell?.nameLabel.text = viewModel.name
    cell?.stateLabel.text = viewModel.state
    
    cell?.onReuse = { [weak self] in
      self?.releaseCellForReuse()
    }
  }
  
  func preload() {
    presenter?.loadData(for: model)
  }
  
  func cancelLoad() {
    releaseCellForReuse()
  }
  
  private func releaseCellForReuse() {
    cell?.onReuse = nil
    cell = nil
  }
}

extension ListCellController: UITableViewDelegate {
  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selection()
  }
}
