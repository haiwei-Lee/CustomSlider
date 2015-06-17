//
//  RangeSliderTrackLayer.swift
//  CustomSlider
//
//  Created by Lee on 15/6/17.
//  Copyright (c) 2015年 Havi. All rights reserved.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
  
  weak var rangeSlider: RangeSlider?
  
  override func drawInContext(ctx: CGContext!) {
    if let slider = rangeSlider {
    
      let cornerRadius = bounds.height * slider.curvaceousness / 2.0
      
      let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
      
      CGContextAddPath(ctx, path.CGPath)
      
      CGContextSetFillColorWithColor(ctx, slider.trackTintColor.CGColor)
      CGContextAddPath(ctx, path.CGPath)
      CGContextFillPath(ctx)
      
      CGContextSetFillColorWithColor(ctx, slider.trackHeighlightTintColor.CGColor)
      let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
      let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
      
      let rect = CGRectMake(lowerValuePosition, 0.0, upperValuePosition - lowerValuePosition, bounds.height)
      CGContextFillRect(ctx, rect)
      
    
    }
  }
   
}
