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

struct Episode: Codable {
  let number: Int
  let name: String
  let airdate: String
  let airtime: String
  let season: Int
  let summary: String
  
  enum EpisodeCodingKeys: String, CodingKey {
    case number
    case name
    case airdate
    case airtime
    case season
    case summary
  }
  
  init(from decoder: Decoder) throws {
    let episodeContainer = try decoder.container(keyedBy: EpisodeCodingKeys.self)

    self.number = try episodeContainer.decode(Int.self, forKey: .number)
    self.name = try episodeContainer.decode(String.self, forKey: .name)
    self.airdate = try episodeContainer.decode(String.self, forKey: .airdate)
    self.airtime = try episodeContainer.decode(String.self, forKey: .airtime)
    self.season = try episodeContainer.decode(Int.self, forKey: .season)
    self.summary = try episodeContainer.decode(String.self, forKey: .summary)

  }
  
  func encode(to encoder: Encoder) throws {
    var episodeContainer = encoder.container(keyedBy: EpisodeCodingKeys.self)
    
    try episodeContainer.encode(self.number, forKey: .number)
    try episodeContainer.encode(self.name, forKey: .name)
    try episodeContainer.encode(self.airdate, forKey: .airdate)
    try episodeContainer.encode(self.airtime, forKey: .airtime)
    try episodeContainer.encode(self.season, forKey: .season)
    try episodeContainer.encode(self.summary, forKey: .summary)
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
    
    // If we are using this same view controller to present the results
    // dimming it out wouldn't make sense. Should probably only set
    // this to yes if using another controller to display the search results.
    searchController.dimsBackgroundDuringPresentation = false
    
    searchController.searchBar.sizeToFit()
    table.tableHeaderView = searchController.searchBar
    
    // Sets this view controller as presenting view controller for the search interface
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
    
//    cell.textLabel?.text = self.gameOfThrones?.embedded.episodes[indexPath.row].name
//    cell.detailTextLabel?.text = "Season \(self.gameOfThrones!.embedded.episodes[indexPath.row].season) Episode \(self.gameOfThrones!.embedded.episodes[indexPath.row].number)"
    
    
    cell.textLabel?.text = filteredEpisodes?[indexPath.row].name
    cell.detailTextLabel?.text = "Season \(filteredEpisodes?[indexPath.row].season) Episode \(filteredEpisodes?[indexPath.row].number)"
    
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
