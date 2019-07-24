//
//  ViewController.swift
//  HamburgerAnimation
//
//  Created by MCS on 7/23/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var isArrow : Bool = false
  var topBun: CAShapeLayer = CAShapeLayer()
  var burger: CAShapeLayer = CAShapeLayer()
  var bottomBun: CAShapeLayer = CAShapeLayer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tapGesture = UITapGestureRecognizer()
    tapGesture.addTarget(self, action: #selector(didTapView))
    view.addGestureRecognizer(tapGesture)
    
    topBun.path = UIBezierPath(roundedRect: CGRect(x: -50, y: -40, width: 100, height: 10), cornerRadius: 0).cgPath
    topBun.position = CGPoint(x: 210, y: 306)
    topBun.fillColor = UIColor(red: 1, green: 0.6471, blue: 0.8392, alpha: 1.0).cgColor
    burger.path = UIBezierPath(roundedRect: CGRect(x: -50, y: -5, width: 100, height: 10), cornerRadius: 0).cgPath
    
  
    burger.position = CGPoint(x: 210, y: 306)
    burger.fillColor = UIColor(red: 1, green: 0.6471, blue: 0.8392, alpha: 1.0).cgColor
    bottomBun.path = UIBezierPath(roundedRect: CGRect(x: -50, y: 30, width: 100, height: 10), cornerRadius: 0).cgPath
    bottomBun.position = CGPoint(x: 210, y: 306)
    

    bottomBun.fillColor = UIColor(red: 1, green: 0.6471, blue: 0.8392, alpha: 1.0).cgColor
    view.layer.addSublayer(topBun)
    view.layer.addSublayer(burger)
    view.layer.addSublayer(bottomBun)
    
  }
  
  @objc func didTapView() {
    let middleRotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    middleRotation.fillMode = .forwards
    middleRotation.isRemovedOnCompletion = false
    middleRotation.duration = 0.5
    middleRotation.isCumulative = true
    
    let topRotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    topRotation.fillMode = .forwards
    topRotation.isRemovedOnCompletion = false
    topRotation.duration = 0.5
    //topRotation.isCumulative = true
    
    let bottomRotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    bottomRotation.fillMode = .forwards
    bottomRotation.isRemovedOnCompletion = false
    bottomRotation.duration = 0.5
    //bottomRotation.isCumulative = true
    
    let topTranslationX: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
    topTranslationX.fillMode = .forwards
    topTranslationX.isRemovedOnCompletion = false
    topTranslationX.duration = 0.5
    topTranslationX.isCumulative = true
    
    let bottomTranslationX: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
    bottomTranslationX.fillMode = .forwards
    bottomTranslationX.isRemovedOnCompletion = false
    bottomTranslationX.duration = 0.5
    bottomTranslationX.isCumulative = true
    
    let topTranslationY: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
    topTranslationY.fillMode = .forwards
    topTranslationY.isRemovedOnCompletion = false
    topTranslationY.duration = 0.5
    topTranslationY.isCumulative = true

    let bottomTranslationY: CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.y")
    bottomTranslationY.fillMode = .forwards
    bottomTranslationY.isRemovedOnCompletion = false
    bottomTranslationY.duration = 0.5
    bottomTranslationY.isCumulative = true
    
    if isArrow {
      middleRotation.toValue = NSNumber(value: Double.pi * 2 )
      
      topRotation.toValue = NSNumber(value: 0 )
      
      bottomRotation.toValue = NSNumber(value: Double.pi * 2 )
      
      topTranslationX.toValue = NSNumber(value: 0)
      
      bottomTranslationX.toValue = NSNumber(value: 0)
      
      topTranslationY.toValue = NSNumber(value: 0)
      
      bottomTranslationY.toValue = NSNumber(value: 0)
      
      topBun.add(topRotation, forKey: "hamburgerTopRotation")
      burger.add(middleRotation, forKey: "hamburgerMiddleRotation")
      bottomBun.add(bottomRotation, forKey: "hamburgerBottomRotation")
      topBun.add(topTranslationX, forKey: "hamburgerTranslationX")
      bottomBun.add(bottomTranslationX, forKey: "hamburgerTranslationX")
      topBun.add(topTranslationY, forKey: "hamburgerTranslationY")
      bottomBun.add(bottomTranslationY, forKey: "hamburgerTranslationY")
      
    } else {
      middleRotation.toValue = NSNumber(value: Double.pi )
      
      topRotation.toValue = NSNumber(value: (Double.pi * 5) / 4 )
      
      bottomRotation.toValue = NSNumber(value: (Double.pi * 3) / 4 )
      
      topTranslationX.toValue = NSNumber(value: 5)
      
      bottomTranslationX.toValue = NSNumber(value: 5)
      
      topTranslationY.toValue = NSNumber(value: 7.5)
      
      bottomTranslationY.toValue = NSNumber(value: -7.5)
      
      topBun.add(topRotation, forKey: "arrowTopRotation")
      burger.add(middleRotation, forKey: "arrowMiddleRotation")
      bottomBun.add(bottomRotation, forKey: "arrowBottomRotation")
      topBun.add(topTranslationX, forKey: "arrowTranslationX")
      bottomBun.add(bottomTranslationX, forKey: "arrowTranslationX")
      topBun.add(topTranslationY, forKey: "arrowTranslationY")
      bottomBun.add(bottomTranslationY, forKey: "arrowTranslationY")
    }
    isArrow = !isArrow
  }
}

