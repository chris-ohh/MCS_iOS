//
//  DetailViewController.swift
//  Week3Test1
//
//  Created by MCS on 7/26/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
  
  var delegate: FavoritesUpdaterDelegate?
  var indexPath: IndexPath?
  var imageName: String?
  var image: Image?
  var filledHeartButton = UIBarButtonItem()
  var heartButton = UIBarButtonItem()
  var favorited = false
  let favoriteViewModel = FavoriteViewModel()
  let imageViewModel = ImageViewModel()
  
  
  @IBOutlet weak var detailsTextView: UITextView!
  @IBOutlet weak var detailImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Detail View"
    
    let heartButton = UIButton(type: .custom)
    heartButton.setImage(UIImage(named: "Heart.png"), for: .normal)
    heartButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    heartButton.imageView?.clipsToBounds = true
    heartButton.adjustsImageSizeForAccessibilityContentSizeCategory = false
    heartButton.addTarget(self, action: #selector(self.heartTapped), for: .touchUpInside)
    self.heartButton = UIBarButtonItem(customView: heartButton)
    
    let filledHeartButton = UIButton(type: .custom)
    filledHeartButton.setImage(UIImage(named: "FilledHeart.png"), for: .normal)
    filledHeartButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    filledHeartButton.imageView?.clipsToBounds = true
    filledHeartButton.adjustsImageSizeForAccessibilityContentSizeCategory = false
    filledHeartButton.addTarget(self, action: #selector(self.heartTapped), for: .touchUpInside)
    self.filledHeartButton = UIBarButtonItem(customView: filledHeartButton)
    
    self.updateViewControllerWithDetails()
    
  }
  
  func updateViewControllerWithDetails() {

    guard let image = image else { return }

    imageViewModel.getImageDetails (image: image) { (data, image) -> Void in
      
      DispatchQueue.main.async {
        self.detailImageView.image = UIImage(data: data)
        self.detailsTextView.text = """
        User: \(image.user)
        Likes: \(image.likes)
        Views: \(image.views)
        Comments: \(image.comments)
        """
        
        if self.favoriteViewModel.getFavorite(image: image) != nil {
          self.favorited = true
          self.navigationItem.rightBarButtonItem = self.filledHeartButton
        } else {
          self.favorited = false
          self.navigationItem.rightBarButtonItem = self.heartButton
        }
      }
    }
  }
  
  @objc func heartTapped(sender: UIButton!) {
    
    favorited = !favorited
    
    guard let image = image else { return }
    
    if favorited {
      favoriteViewModel.createNewFavorite(image: image)
    } else {
      favoriteViewModel.delete(image: image)
    }
    
    self.navigationItem.rightBarButtonItem = favorited ? filledHeartButton : heartButton
    
    favoriteViewModel.save()
    delegate?.updateFavorites()
  }
}
