//
//  ViewController.swift
//  APICrawlerProject
//
//  Created by MAC on 7/16/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet weak var crawlerTableView: UITableView!
  @IBOutlet weak var navBarTitle: UINavigationItem!
  @IBOutlet weak var forwardButton: UIBarButtonItem!
  
  var dictionary: [String: Any] = [:]
  var array: [Any] = []
  var url = URL(string: "https://pokeapi.co/api/v2")
  var titleString = "Pokemon Crawler"
  
  enum APITypes {
    case dictionary
    case array
    case number
    case string
    case boolean
    case null
    
    init?(value: Any) {
      if value is [String: Any] {
        self = .dictionary
      } else if value is Bool {
        self = .boolean
      } else if value is NSNumber {
        self = .number
      } else if value is String {
        self = .string
      } else if value is [Any] {
        self = .array
      } else if value is NSNull {
        self = .null
      } else {
        return nil
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    crawlerTableView.dataSource = self
    crawlerTableView.delegate = self
    crawlerTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
    navBarTitle.title = titleString
    
    if let url = url {
      // received a URL, not an array
      URLSession.shared.dataTask(with: url) { (data, _, _) in
        guard let data = data,
          let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
          let jsonDictionary = jsonObject as? [String: Any] else { return }
        self.dictionary = jsonDictionary
        print(jsonDictionary)
        
        DispatchQueue.main.async {
          self.crawlerTableView.reloadData()
        }
        }.resume()
    } else {
      self.crawlerTableView.reloadData()
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if array.count > 0 {
      return array.count
    } else { return dictionary.count }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")

    if dictionary.count == 0 && array.count > 0 {
      // array
      cell.textLabel?.text = "Array Index \(indexPath.row)"
      
    } else {
      // dictionary
      let keys = Array(dictionary.keys)
      cell.textLabel?.text = keys[indexPath.row]
      
      guard let type = APITypes(value: dictionary[keys[indexPath.row]]) else { return cell }

      switch type {
      case .boolean:
        guard let detailText = dictionary[keys[indexPath.row]] as? Bool else { return cell }
        cell.detailTextLabel?.text = "\(detailText)"
      case .array:
        guard let array = dictionary[keys[indexPath.row]] as? [Any] else { return cell }
        cell.detailTextLabel?.text = "Array of size: \(array.count)"
      case .dictionary:
        guard var dictionary = dictionary[keys[indexPath.row]] as? [String: Any?] else { return cell }
        
        if let urlString = dictionary["url"] as? String {
          guard let url = URL(string: urlString) else { return cell }
          URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data,
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let jsonDictionary = jsonObject as? [String: Any] else { return }
            dictionary = jsonDictionary
            DispatchQueue.main.async {
              cell.detailTextLabel?.text = "Dictionary of size: \(dictionary.keys.count)"
            }
          }.resume()
        }
        else {
          // this dictionary doesnt have a url field
          cell.detailTextLabel?.text = "Dictionary of size: \(dictionary.keys.count)"
        }
      case .null:
        guard let detailText = dictionary[keys[indexPath.row]] as? NSNull else { return cell }
        cell.detailTextLabel?.text = "\(detailText)"
      case .number:
        guard let detailText = dictionary[keys[indexPath.row]] as? Int else { return cell }
        cell.detailTextLabel?.text = "\(detailText)"
      case .string:
        guard let detailText = dictionary[keys[indexPath.row]] as? String else { return cell }
        cell.detailTextLabel?.text = "\(detailText)"
      }
    }
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
    
    if array.count > 0 {
      // is array
      // clicked dictionary
      if let value = array[indexPath.row] as? [String: Any] {
        // there is a url field
        if (value["url"] != nil) {
          guard let urlString = value["url"] as? String else { return }
          let url = URL(string: urlString)
          nextViewController.url = url
          nextViewController.titleString = "Array Index \(indexPath.row)"
          navigationController?.pushViewController(nextViewController, animated: true)
        } else {
          // there is no url field
          nextViewController.dictionary = value
          nextViewController.url = URL(string: "")
          nextViewController.titleString = "Array Index \(indexPath.row)"
          navigationController?.pushViewController(nextViewController, animated: true)
        }
      } else { return }
    } else {
      // is dictionary
      // is url field, and only a url field
      let keys = Array(dictionary.keys)
      if let value = dictionary[keys[indexPath.row]] as? String {
        // only take urls
        if value.hasPrefix("https://pokeapi.co/") {
          let url = URL(string: value)
          nextViewController.url = url
          nextViewController.titleString = keys[indexPath.row]
          navigationController?.pushViewController(nextViewController, animated: true)
        } else { return }
      } // is nested dictionary with a url field
      else if let value = dictionary[keys[indexPath.row]] as? [String: Any] {
        // is nested dictionary with a url field
        if let urlString = value["url"] as? String {
        // url is a string
        let url = URL(string: urlString)
          
        nextViewController.url = url
        nextViewController.titleString = keys[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
      } else {
        // dictionary with no url
        nextViewController.dictionary = value
        nextViewController.titleString = keys[indexPath.row]
        navigationController?.pushViewController(nextViewController, animated: true)
      }
    } else if let value = dictionary[keys[indexPath.row]] as? [Any] {
      // clicked array in dictionary
      nextViewController.array = value
      nextViewController.url = URL(string: "")
      nextViewController.titleString = keys[indexPath.row]
      navigationController?.pushViewController(nextViewController, animated: true)
    }
  }
}
  
  @IBAction func forwardButton(_ sender: Any) {
    navigationController?.popToRootViewController( animated: true )
  }
}
