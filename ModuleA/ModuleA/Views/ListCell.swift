//
//  ListCell.swift
//  EssentialFeediOS
//
//  Created by Afsal on 03/04/2024.
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
