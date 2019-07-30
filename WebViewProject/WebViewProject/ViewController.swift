//
//  ViewController.swift
//  WebViewProject
//
//  Created by MCS on 7/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  @IBOutlet weak var webView: WKWebView!
  
  @IBOutlet weak var urlBar: UITextField!
  
  @IBOutlet weak var goButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let urlString = urlBar.text else { return }
    
    let url = URL(string: urlString)
    let request = URLRequest(url: url!)
    
    webView.navigationDelegate = self
    webView.load(request)
  }

  
  @IBAction func goButtonTapped(_ sender: Any) {
    guard let urlString = urlBar.text else { return }

    let url = URL(string: urlString)
    let request = URLRequest(url: url!)
    
    webView.load(request)
    
  }
  
}

extension ViewController: WKNavigationDelegate {
  
  func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
    print(error.localizedDescription)
  }
  
  func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    print("Started loading")
  }
  
  func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
    print("Finished loading")
  }
  
}
