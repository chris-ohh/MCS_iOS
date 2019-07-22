//
//  ViewController.swift
//  Week2Test
//
//  Created by MCS on 7/19/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
  
  @IBOutlet weak var table: UITableView!
  
  var gameOfThrones: GameOfThrones? = nil
  var searchController: UISearchController!
  var episodes: [Episode]? = nil
  var filteredEpisodes: [Episode]? = nil
  var sectionedEpisodes: [Int: [Episode]] = [:]
  var filteredSectionedEpisodes: [Int: [Episode]] = [:]

  override func viewDidLoad() {
    super.viewDidLoad()
    
    table.dataSource = self
    table.delegate = self
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    searchController.searchBar.sizeToFit()
    table.tableHeaderView = searchController.searchBar
    
    definesPresentationContext = true

    let gameOfThronesURLString = "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes"
    if let url = URL(string: gameOfThronesURLString) {
      URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else {
          print("No network! Here are your defaults: \(UserDefaults.standard.dictionaryRepresentation())")
          return
        }
        
        if let gameOfThrones = try? JSONDecoder().decode(GameOfThrones.self, from: data) {
          DispatchQueue.main.async {
            self.gameOfThrones = gameOfThrones
            if let episodes = (self.gameOfThrones?.embedded.episodes) {
              self.episodes = episodes
              
              self.sectionedEpisodes[1] = episodes.filter{ $0.season == 1 }
              self.sectionedEpisodes[2] = episodes.filter{ $0.season == 2 }
              self.sectionedEpisodes[3] = episodes.filter{ $0.season == 3 }
              self.sectionedEpisodes[4] = episodes.filter{ $0.season == 4 }
              self.sectionedEpisodes[5] = episodes.filter{ $0.season == 5 }
              self.sectionedEpisodes[6] = episodes.filter{ $0.season == 6 }
              self.sectionedEpisodes[7] = episodes.filter{ $0.season == 7 }
              self.sectionedEpisodes[8] = episodes.filter{ $0.season == 8 }
              
              self.filteredSectionedEpisodes[1] = self.sectionedEpisodes[1]
              self.filteredSectionedEpisodes[2] = self.sectionedEpisodes[2]
              self.filteredSectionedEpisodes[3] = self.sectionedEpisodes[3]
              self.filteredSectionedEpisodes[4] = self.sectionedEpisodes[4]
              self.filteredSectionedEpisodes[5] = self.sectionedEpisodes[5]
              self.filteredSectionedEpisodes[6] = self.sectionedEpisodes[6]
              self.filteredSectionedEpisodes[7] = self.sectionedEpisodes[7]
              self.filteredSectionedEpisodes[8] = self.sectionedEpisodes[8]
            }
            self.table.reloadData()
          }
        } else {
          print("I guess I'll fail")
        }
      }.resume()
    }
  }
}

extension TableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    if let searchText = searchController.searchBar.text {
      if searchText.isEmpty {
        filteredSectionedEpisodes = sectionedEpisodes
      } else {
        for key in sectionedEpisodes.keys {
          filteredSectionedEpisodes[key] = sectionedEpisodes[key]?.filter({(episode: Episode?) -> Bool in
            return episode?.name.range(of: searchText, options: .caseInsensitive) != nil
          })
        }
      }
      table.reloadData()
    }
  }
}

extension TableViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return filteredSectionedEpisodes.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    var dicKeys = Array(filteredSectionedEpisodes.keys)
    dicKeys.sort(by: <)
    
    if let count = filteredSectionedEpisodes[dicKeys[section]]?.count {
      if filteredSectionedEpisodes.count > 0 {
        return count
      }
    }
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    
    var dicKeys = Array(filteredSectionedEpisodes.keys)
    dicKeys.sort(by: <)
    
    guard let episodeList = filteredSectionedEpisodes[dicKeys[indexPath.section]] else { return cell }
    
    let url = episodeList[indexPath.row].image.medium
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data) else { return }
        
        DispatchQueue.main.async() {
          cell.imageView?.image = image
          cell.textLabel?.text = episodeList[indexPath.row].name
          cell.detailTextLabel?.text = "Episode \(episodeList[indexPath.row].number)"
        }
      }.resume()
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    var dicKeys = Array(filteredSectionedEpisodes.keys)
    dicKeys.sort(by: <)
    if dicKeys.count != 0 {
      return "Season \(dicKeys[section])"
    } else { return "" }
  }
}

extension TableViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    if let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
      detailViewController.episode = self.gameOfThrones!.embedded.episodes[indexPath.row]
      navigationController?.pushViewController(detailViewController, animated: true)
    }
  }
}
