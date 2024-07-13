//
//  DetailViewRouter.swift
//  ListDetail-Viper
//
//  Created by Afsal on 13/07/2024.
//

import UIKit
import Core

public final class DetailViewRouter: DetailViewRouterProtocol {
  private let view: UIViewController
  
  public init(view: UIViewController) {
    self.view = view
  }
  
  public func dismiss() {
    self.view.dismiss(animated: true)
  }
  
  public static func assemble(with title: String, model: University) -> DetailViewController {
    let bundle = Bundle(for: DetailViewController.self)
    let storyboard = UIStoryboard(name: "Detail", bundle: bundle)
    let detailController = storyboard.instantiateInitialViewController() as! DetailViewController
    detailController.navigationItem.title = title
    
    return detailController
  }
}
