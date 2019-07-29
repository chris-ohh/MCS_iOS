//
//  CustomCollectionViewCell.swift
//  Week3Test1
//
//  Created by MCS on 7/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var cellImageView: UIImageView!
  var image: Image?
  
  var delegate: FavoritesUpdaterDelegate?
  let carViewModel = CarViewModel()
  let birdViewModel = BirdViewModel()
  let machineViewModel = MachineViewModel()
  let strangerViewModel = StrangerViewModel()
  let eyeViewModel = EyeViewModel()
  let favoriteViewModel = FavoriteViewModel()
  let imageViewModel = ImageViewModel()
  
  var heartButton = UIButton()
  var favorited: Bool = false
  
  var cellImageName:String?
  
  class var customCell : CustomCollectionViewCell {
    let cell = Bundle.main.loadNibNamed("CustomCollectionViewCell", owner: self, options: nil)?.last
    return cell as! CustomCollectionViewCell
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    if let image = image {
      self.image = image
    }
  }
  

  func initializeCell(image: Image?) {
    if let image = image {
      self.image = image
      
      updateCellWithImage(imageURL: self.image!.previewURL)
      
      let button = UIButton(type: .custom)
      button.setImage(UIImage(named: "Heart.png"), for: .normal)
      button.frame = CGRect(x: self.bounds.maxX-20, y: 0, width: 20, height: 20)
      button.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
      heartButton = button
      self.addSubview(heartButton)
      
      if favoriteViewModel.getFavorite(image: image) != nil {
        self.favorited = true
        self.heartButton.setImage(UIImage(named: "FilledHeart.png"), for: .normal)
      } else {
        self.favorited = false
        self.heartButton.setImage(UIImage(named: "Heart.png"), for: .normal)
      }
    }
  }
  
  func updateCellWithImage(imageURL: String) {
    imageViewModel.getImage(imageURL: imageURL) { (data) -> Void in

      DispatchQueue.main.async {
        self.cellImageView.image = UIImage(data: data)
      }
    }
  }
  
  @objc func heartTapped(sender: UIButton!) {
    
    favorited = !favorited
    
    guard let image = image else { return }
    
    if favorited {
      heartButton.setImage(UIImage(named: "FilledHeart.png"), for: .normal)
      favoriteViewModel.createNewFavorite(image: image)
    } else {
      heartButton.setImage(UIImage(named: "Heart.png"), for: .normal)
      favoriteViewModel.delete(image: image)
    }
    
    favoriteViewModel.save()
    delegate?.updateFavorites()
  }
}
