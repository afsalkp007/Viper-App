//
//  ErrorView.swift
//  ModuleA
//
//  Created by Afsal on 13/07/2024.
//

import UIKit

final class ErrorView: UIView {
  @IBOutlet private var label: UILabel!
  
  var message: String? {
    get { return isVisible ? label.text : nil }
    set { setMessageAnimated(newValue) }
  }
  
  private var isVisible: Bool {
    return alpha > 0
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    label.text = nil
    alpha = 0
  }
  
  private func setMessageAnimated(_ message: String?) {
    if let message {
      showMessageAnimated(message)
    } else {
      hideMessageAnimated()
    }
  }
  
  private func showMessageAnimated(_ message: String) {
    label.text = message
    
    UIView.animate(withDuration: 0.25) {
      self.alpha = 1
    }
  }
  
  @IBAction private func hideMessageAnimated() {
    UIView.animate(withDuration: 0.25,
                   animations: { self.alpha = 0 },
                   completion: { completed in
      if completed { self.label.text = nil }
    })
  }
}
