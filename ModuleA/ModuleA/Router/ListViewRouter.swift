//
//  ListViewRouter.swift
//  ListDetail-Viper
//
//  Created by Afsal on 13/07/2024.
//

import UIKit
import CoreData

public final class ListViewRouter: ListViewRouterProtocol {
  public init() {}
    
  public static func assemble(with title: String) -> ListViewController {
    
    let bundle = Bundle(for: ListViewController.self)
    let storyboard = UIStoryboard(name: "List", bundle: bundle)
    let listController = storyboard.instantiateInitialViewController() as! ListViewController
    listController.title = title
        
    return listController
  }
}
