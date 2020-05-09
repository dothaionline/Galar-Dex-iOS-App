//
//  AngledColorView.swift
//  CompetitiveDex
//
//  Created by Thai Do on 4/29/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

@IBDesignable
public class AngledColorView: UIView {
  
  @IBInspectable public var fillColor: UIColor = .clear { didSet { setNeedsLayout() } }
  
  var points: [CGPoint] = [CGPoint(x: 0, y: 1), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 0), CGPoint(x: 0, y: 1) ] {
    didSet {
      setNeedsLayout()
    }
  }
  
  private lazy var shapeLayer: CAShapeLayer = {
    let _shapeLayer = CAShapeLayer()
    self.layer.insertSublayer(_shapeLayer, at: 0)
    return _shapeLayer
  }()
  
  override public func layoutSubviews() {
    shapeLayer.fillColor = fillColor.cgColor
    
    guard points.count > 2 else {
      shapeLayer.path = nil
      return
    }
    
    let path = UIBezierPath()
    
    path.move(to: convert(relativePoint: points[0]))
    for point in points.dropFirst() {
      path.addLine(to: convert(relativePoint: point))
    }
    path.close()
    
    shapeLayer.path = path.cgPath
  }
  
  private func convert(relativePoint point: CGPoint) -> CGPoint {
    return CGPoint(x: point.x * bounds.width + bounds.origin.x, y: point.y * bounds.height + bounds.origin.y)
  }
}
