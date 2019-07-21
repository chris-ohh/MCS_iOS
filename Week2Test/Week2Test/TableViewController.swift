//
//  ViewController.swift
//  Week2Test
//
//  Created by MCS on 7/19/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

struct Embedded: Codable {
  let episodes: [Episode]
  
  enum EmbeddedCodingKeys: String, CodingKey {
    case episodes
  }
}

struct Image: Codable {
  let medium: URL
  let original: URL
  
  enum ImageCodingKeys: String, CodingKey {
    case medium
    case original
  }
  
  init(from decoder: Decoder) throws {
    let imageContainer = try decoder.container(keyedBy: ImageCodingKeys.self)
    self.medium = try imageContainer.decode(URL.self, forKey: .medium)
    self.original = try imageContainer.decode(URL.self, forKey: .original)
  }
  
  func encode(to encoder: Encoder) throws {
    var imageContainer = encoder.container(keyedBy: ImageCodingKeys.self)
    try imageContainer.encode(self.medium, forKey: .medium)
    try imageContainer.encode(self.original, forKey: .original)
  }
}

struct Episode: Codable {
  let number: Int
  let name: String
  let airdate: String
  let airtime: String
  let season: Int
  let summary: String
  let image: Image
  
  enum EpisodeCodingKeys: String, CodingKey {
    case number
    case name
    case airdate
    case airtime
    case season
    case summary
    case image
  }
  
  init(from decoder: Decoder) throws {
    let episodeContainer = try decoder.container(keyedBy: EpisodeCodingKeys.self)

    self.number = try episodeContainer.decode(Int.self, forKey: .number)
    self.name = try episodeContainer.decode(String.self, forKey: .name)
    self.airdate = try episodeContainer.decode(String.self, forKey: .airdate)
    self.airtime = try episodeContainer.decode(String.self, forKey: .airtime)
    self.season = try episodeContainer.decode(Int.self, forKey: .season)
    self.summary = try episodeContainer.decode(String.self, forKey: .summary)
    self.image = try episodeContainer.decode(Image.self, forKey: .image)

  }
  
  func encode(to encoder: Encoder) throws {
    var episodeContainer = encoder.container(keyedBy: EpisodeCodingKeys.self)
    
    try episodeContainer.encode(self.number, forKey: .number)
    try episodeContainer.encode(self.name, forKey: .name)
    try episodeContainer.encode(self.airdate, forKey: .airdate)
    try episodeContainer.encode(self.airtime, forKey: .airtime)
    try episodeContainer.encode(self.season, forKey: .season)
    try episodeContainer.encode(self.summary, forKey: .summary)
    try episodeContainer.encode(self.image, forKey: .image)
  }
}

struct GameOfThrones: Codable {
  let embedded: Embedded
  
  enum CodingKeys: String, CodingKey {
    case embedded = "_embedded"
  }
}

class TableViewController: UIViewController, UISearchResultsUpdating {
  
  
  @IBOutlet weak var table: UITableView!
  
  var gameOfThrones: GameOfThrones? = nil
  var searchController: UISearchController!
  var episodes: [Episode]? = nil
  var filteredEpisodes: [Episode]? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    
    table.dataSource = self
    table.delegate = self
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    
    // dim background while displaying results
    searchController.dimsBackgroundDuringPresentation = false
    
    searchController.searchBar.sizeToFit()
    table.tableHeaderView = searchController.searchBar
    
    // set this view controller as presenting view controller for the search interface
    definesPresentationContext = true
    

    let gameOfThronesURLString = "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes"
    guard let url = URL(string: gameOfThronesURLString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      
      if let gameOfThrones = try? JSONDecoder().decode(GameOfThrones.self, from: data!) {
        DispatchQueue.main.async {
          self.gameOfThrones = gameOfThrones
          self.episodes = (self.gameOfThrones?.embedded.episodes)!
          self.filteredEpisodes = self.episodes
          self.table.reloadData()
        }
        
      } else {
        print("I guess I'll fail")
      }
      
      }.resume()
    
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
      filteredEpisodes = searchText.isEmpty ? episodes : episodes?.filter({(episode: Episode?) -> Bool in
        return episode?.name.range(of: searchText, options: .caseInsensitive) != nil
      })
      
      table.reloadData()
    }
  }

}

extension TableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //guard let count = self.gameOfThrones?.embedded.episodes.count else { return 0 }
    //return count
    guard let count = filteredEpisodes?.count else { return 0 }
    return count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    
      guard let url = filteredEpisodes?[indexPath.row].image.medium else { return cell }
      
      URLSession.shared.dataTask(with: url) { data, response, error in
        guard
          let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
          let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
          let data = data, error == nil,
          let image = UIImage(data: data)
          else { return }
        
        DispatchQueue.main.async() {
          cell.imageView?.image = image
          cell.textLabel?.text = self.filteredEpisodes?[indexPath.row].name
          cell.detailTextLabel?.text = "Season \(self.filteredEpisodes![indexPath.row].season) Episode \(self.filteredEpisodes![indexPath.row].number)"
        }
      }.resume()
    
    return cell
  }
}

extension TableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    
    detailViewController.episode = self.gameOfThrones!.embedded.episodes[indexPath.row]
   
    print(detailViewController)
    navigationController?.pushViewController(detailViewController, animated: true)

  }
}
