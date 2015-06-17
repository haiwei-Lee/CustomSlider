//
//  ViewController.swift
//  CustomSlider
//
//  Created by Lee on 15/6/17.
//  Copyright (c) 2015年 Havi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let rangeSlider = RangeSlider(frame: CGRectZero)


  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(rangeSlider)
    
    rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
    
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewDidLayoutSubviews() {
    let margin: CGFloat = 2.0
    let width = view.bounds.width - 2 * margin
    rangeSlider.frame = CGRectMake(margin, margin + topLayoutGuide.length, width, 31.0)
  }

  func rangeSliderValueChanged(rangeSlider: RangeSlider){
    
    println("Range slider value changed: (\(rangeSlider.lowerValue) \(rangeSlider.upperValue))")
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

