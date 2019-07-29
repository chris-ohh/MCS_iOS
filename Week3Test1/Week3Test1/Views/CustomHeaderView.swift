//
//  CustomHeaderView.swift
//  Week3Test1
//
//  Created by MCS on 7/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

final class CustomHeaderView: UITableViewHeaderFooterView {
  
  @IBOutlet weak var headerLabel: UILabel!
  
  class var customView : CustomHeaderView {
    let cell = Bundle.main.loadNibNamed("CustomHeaderView", owner: self, options: nil)?.last
    return cell as! CustomHeaderView
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}
