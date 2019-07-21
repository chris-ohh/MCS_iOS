//
//  DetailViewController.swift
//  Week2Test
//
//  Created by MCS on 7/19/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var episodeTitleLabel: UILabel!
  
  @IBOutlet weak var airDateLabel: UILabel!
  
  @IBOutlet weak var airTimeLabel: UILabel!
  
  @IBOutlet weak var seasonLabel: UILabel!
  
  @IBOutlet weak var episodeNumberLabel: UILabel!
  
  @IBOutlet weak var summaryTextView: UITextView!
  
  @IBOutlet weak var imageView: UIImageView!
  
  var episode: Episode?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let episode = episode else { return }
    let url = episode.image.original
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      
      DispatchQueue.main.async() {
        self.episodeTitleLabel.text = "Episode Title: \(episode.name)"
        self.airDateLabel.text = "Premier Date: \(episode.airdate)"
        self.airTimeLabel.text = "Airtime: \(episode.airtime)"
        self.seasonLabel.text = "Season: \(episode.season)"
        self.episodeNumberLabel.text = "Episode Number: \(episode.number)"
        self.summaryTextView.text = "Summary: \(String((episode.summary.dropLast(4).dropFirst(3))))"
        self.imageView.image = image
      }
      }.resume()
    
    
//    episodeTitleLabel.text = "Episode Title: \(episode!.name)"
//    airDateLabel.text = "Premier Date: \(episode!.airdate)"
//    airTimeLabel.text = "Airtime: \(episode!.airtime)"
//    seasonLabel.text = "Season: \(episode!.season)"
//    episodeNumberLabel.text = "Episode Number: \(episode!.number)"
//    summaryTextView.text = "Summary: \(String((episode?.summary.dropLast(4).dropFirst(3))!))"
//    imageView.image = episode!.image.medium
  
  }
  
}
