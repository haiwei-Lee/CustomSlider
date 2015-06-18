//
//  RangeSlider.swift
//  CustomSlider
//
//  Created by Lee on 15/6/17.
//  Copyright (c) 2015年 Havi. All rights reserved.
//

import UIKit
import QuartzCore

class RangeSlider: UIControl {

  var minimumValue: Double = 0.0{
  
    didSet{
    
      updateLayerFrames()
    }
  
  }
  
  var maximumValue: Double = 1.0{
  
    didSet{
    
      updateLayerFrames()
    }
  
  }
  
  var lowerValue: Double = 0.2 {
  
    didSet{
    
      updateLayerFrames()
    }
  
  }
  
  var upperValue: Double = 0.8 {
  
    didSet{
    
      updateLayerFrames()
    }
  
  }
  
  let trackLayer = RangeSliderTrackLayer()
  
  let lowerThumbLayer = RangeSliderThumbLayer()
  
  let upperThumbLayer = RangeSliderThumbLayer()
  
  var previousLocation = CGPoint()
  
  var trackTintColor: UIColor = UIColor(white: 0.9, alpha: 1.0) {
  
    didSet{
    
      trackLayer.setNeedsDisplay()
    }
  
  }
  var trackHeighlightTintColor: UIColor = UIColor(red: 0.0, green: 0.45, blue: 0.94, alpha: 1.0) {
  
    didSet{
    
      trackLayer.setNeedsDisplay()
    }
  
  }
  var thumbTintColor: UIColor = UIColor.whiteColor() {
  
    didSet{
    
      lowerThumbLayer.setNeedsDisplay()
      upperThumbLayer.setNeedsDisplay()
    
    }
  
  }
  var curvaceousness: CGFloat = 1.0 {
  
    didSet{
    
      trackLayer.setNeedsDisplay()
      lowerThumbLayer.setNeedsDisplay()
      upperThumbLayer.setNeedsDisplay()
    }
  
  }
  
  var thumbWidth: CGFloat{
  
      return CGFloat(bounds.height)
  }
  
  override init(frame: CGRect){
  
    super.init(frame: frame)
    
    trackLayer.rangeSlider = self
    trackLayer.contentsScale = UIScreen.mainScreen().scale
    layer.addSublayer(trackLayer)
    
    lowerThumbLayer.rangeSlider = self
    lowerThumbLayer.contentsScale = UIScreen.mainScreen().scale
    layer.addSublayer(lowerThumbLayer)
    
    upperThumbLayer.rangeSlider = self
    upperThumbLayer.contentsScale = UIScreen.mainScreen().scale
    layer.addSublayer(upperThumbLayer)
    
    updateLayerFrames()
  }

  required init(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
//      fatalError("init(coder:) has not been implemented")
  }
  
  func updateLayerFrames(){
    
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    
  
    trackLayer.frame = bounds.rectByInsetting(dx: 0.0, dy: bounds.height/3)
    
    trackLayer.setNeedsDisplay()
    
    let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
    
    lowerThumbLayer.frame = CGRectMake(lowerThumbCenter - thumbWidth/2.0, 0.0, thumbWidth, thumbWidth)
    lowerThumbLayer.setNeedsDisplay()
    
    let upperThumbCenter = CGFloat(positionForValue(upperValue))
    
    upperThumbLayer.frame = CGRectMake(upperThumbCenter - thumbWidth/2.0, 0.0, thumbWidth, thumbWidth)
    upperThumbLayer.setNeedsDisplay()
    
    CATransaction.commit()
  
  }
  
  func positionForValue(value: Double) ->Double{
  
    let widthDouble = Double(thumbWidth)
    
    return Double(bounds.width - thumbWidth) * (value - minimumValue)/(maximumValue - minimumValue) + Double(thumbWidth/2.0)
  
  }
  
  override var frame:CGRect{
  
    didSet{
    
      updateLayerFrames()
    }
  
  }
  
  override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
    previousLocation = touch.locationInView(self)
    
    if lowerThumbLayer.frame.contains(previousLocation){
    
      lowerThumbLayer.highlighted = true
    }else if upperThumbLayer.frame.contains(previousLocation){
      upperThumbLayer.highlighted = true
    
    }
    
    return lowerThumbLayer.highlighted || upperThumbLayer.highlighted
  }
  
  func boundValue(value: Double, toLowerValue lowerValue: Double,upperValue: Double) -> Double{
  
    return min(max(value, lowerValue),upperValue)
  
  }
  
  override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
    let location = touch.locationInView(self)
    
    let deltaLocation = Double(location.x - previousLocation.x)
    let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - bounds.height)
    
    previousLocation = location
    
    if lowerThumbLayer.highlighted {
      
      lowerValue += deltaValue
      
      lowerValue = boundValue(lowerValue, toLowerValue: minimumValue, upperValue: upperValue)
    
    }else if upperThumbLayer.highlighted {
    
      upperValue += deltaValue
      upperValue = boundValue(upperValue, toLowerValue: lowerValue, upperValue: maximumValue)
    
    }
  
    sendActionsForControlEvents(.ValueChanged)
    
    return true
  }
  
  override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
    lowerThumbLayer.highlighted = false
    upperThumbLayer.highlighted = false
  }

}
