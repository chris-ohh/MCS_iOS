//
//  CustomTableViewCell.swift
//  Week3Test1
//
//  Created by MCS on 7/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCollectionCellDelegate {
  
  func collectionView(collectionCell: CustomCollectionViewCell?, didTappedInTableView tableCell: CustomTableViewCell)
}

final class CustomTableViewCell: UITableViewCell  {
  
  var cellDelegate: CustomCollectionCellDelegate?
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  
  var images: [Image] = []
  var delegate: FavoritesUpdaterDelegate?
  
  class var customCell : CustomTableViewCell {
    let cell = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.last
    return cell as! CustomTableViewCell
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()

    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.itemSize = CGSize(width: 100, height: 140)
    flowLayout.minimumLineSpacing = 2.0
    flowLayout.minimumInteritemSpacing = 5.0
    self.collectionView.collectionViewLayout = flowLayout

    self.collectionView.dataSource = self
    self.collectionView.delegate = self

    let cellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
    self.collectionView.register(cellNib, forCellWithReuseIdentifier: "CollectionViewCell")
  }
  

  func updateCellWith(images: [Image]) {
    self.images = images

    self.collectionView.reloadData()
  }
  
}

extension CustomTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
    
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CustomCollectionViewCell
    
    if cell == nil {
      cell = CustomCollectionViewCell.customCell
    }
    
    let image = self.images[indexPath.row]
    
    if let cell = cell {
      cell.initializeCell(image: image)
      
      cell.delegate = self.delegate
      
    }
    
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
    self.cellDelegate?.collectionView(collectionCell: cell, didTappedInTableView: self)
  }
  
}
