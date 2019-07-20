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
  
  
  var episode: Episode?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    episodeTitleLabel.text = "Episode Title: \(episode!.name)"
    airDateLabel.text = "Premier Date: \(episode!.airdate)"
    airTimeLabel.text = "Airtime: \(episode!.airtime)"
    seasonLabel.text = "Season: \(episode!.season)"
    episodeNumberLabel.text = "Episode Number: \(episode!.number)"
    summaryTextView.text = "Summary: \(String((episode?.summary.dropLast(4).dropFirst(3))!))"
  
  }
  
}
