//
//  ViewController.swift
//  Week3Test1
//
//  Created by MCS on 7/25/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

final class TableViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  let carViewModel = CarViewModel()
  let birdViewModel = BirdViewModel()
  let machineViewModel = MachineViewModel()
  let strangerViewModel = StrangerViewModel()
  let eyeViewModel = EyeViewModel()
  let favoriteViewModel = FavoriteViewModel()
  var carImages: [Image] = []
  var birdImages: [Image] = []
  var machineImages: [Image] = []
  var strangerImages: [Image] = []
  var eyeImages: [Image] = []
  var favoriteImages: [Image] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title  = "Week 3 Test 1"

    carViewModel.loadCars { (images) in
      self.carImages = images
      self.tableView.reloadData()
    }
    birdViewModel.loadBirds { (images) -> Void in
      self.birdImages = images
      self.tableView.reloadData()
    }
    machineViewModel.loadMachines { (images) -> Void in
      self.machineImages = images
      self.tableView.reloadData()
    }
    strangerViewModel.loadStrangers { (images) -> Void in
      self.strangerImages = images
      self.tableView.reloadData()
    }
    eyeViewModel.loadEyes { (images) -> Void in
      self.eyeImages = images
      self.tableView.reloadData()
    }
    
    let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
    
    tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "TableHeaderView")
    tableView.dataSource = self
    tableView.delegate = self
    
  }
  
//  override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//
//    tableView.reloadData()
//  }
}

extension TableViewController: CustomCollectionCellDelegate {
  func collectionView(collectionCell: CustomCollectionViewCell?, didTappedInTableView tableCell: CustomTableViewCell) {
        if let cell = collectionCell {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as! DetailViewController
        detailController.image = cell.image
        detailController.delegate = self
          
        navigationController?.pushViewController(detailController, animated: true)
    }
  }
}


extension TableViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 6
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 160
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
    
    if cell == nil {
      cell = CustomTableViewCell.customCell
    }
    
    cell.cellDelegate = self
    cell.delegate = self
    
    switch indexPath.section {
    case 0:
      cell.updateCellWith(images: self.carImages)
      break
    case 1:
      cell.updateCellWith(images: self.birdImages)
      break
    case 2:
      cell.updateCellWith(images: self.machineImages)
      break
    case 3:
      cell.updateCellWith(images: self.strangerImages)
      break
    case 4:
      cell.updateCellWith(images: self.eyeImages)
      break
    default:
      cell.updateCellWith(images: self.favoriteImages)
      
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderView") as? CustomHeaderView
    if view == nil {
      view = CustomHeaderView.customView
    }
    
    switch section {
    case 0:
      view?.headerLabel.text = "Car"
    case 1:
      view?.headerLabel.text = "Bird"
    case 2:
      view?.headerLabel.text = "Machine"
    case 3:
      view?.headerLabel.text = "Stranger"
    case 4:
      view?.headerLabel.text = "Eye"
    default:
      view?.headerLabel.text = "Favorites"
    }
    
    return view
  }
}


extension TableViewController: FavoritesUpdaterDelegate {
  func updateFavorites() {
    favoriteImages = favoriteViewModel.getFavorites()
    tableView.reloadData()
  }
}
