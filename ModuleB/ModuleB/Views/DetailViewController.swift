//
//  DetailViewController.swift
//  ModuleB
//
//  Created by Afsal on 13/07/2024.
//

import UIKit

public class DetailViewController: UIViewController, DetailViewProtocol {
  public var presenter: DetailViewPresenterProtocol?
  
  @IBOutlet private(set) var nameLabel: UILabel!
  @IBOutlet private(set) var stateLabel: UILabel!
  @IBOutlet private(set) var countryLabel: UILabel!
  @IBOutlet private(set) var webpageLabel: UILabel!
  @IBOutlet private(set) var codeLabel: UILabel!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter?.requestData()
  }
  
  public func display(_ viewModel: DetailViewModel) {
    nameLabel.text = viewModel.name
    stateLabel.text = viewModel.state
    countryLabel.text = viewModel.country
    codeLabel.text = viewModel.code
    webpageLabel.text = viewModel.webpage
  }
  
  @IBAction func refresh(_ sender: UIButton) {
    presenter?.dismiss()
  }
}
