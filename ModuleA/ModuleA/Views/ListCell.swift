//
//  ListCell.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import UIKit

final class ListCell: UITableViewCell {
  @IBOutlet private(set) var nameLabel: UILabel!
  @IBOutlet private(set) var stateLabel: UILabel!
  
  var onReuse: (() -> Void)?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    onReuse?()
  }
}
