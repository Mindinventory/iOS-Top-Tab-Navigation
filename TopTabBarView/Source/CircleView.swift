//
//  CircleView.swift
//  CustomTopBarDemo
//
//  Created by Parth Gohel on 06/05/22.
//

import Foundation
import UIKit

final class CircleView: UIView {
    
    private let circleShapeLayer = CAShapeLayer()
    
    var fillColor: UIColor = .red
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCircle()
    }
    
    func drawCircle() {
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2), radius: self.frame.size.height/2, startAngle: 0, endAngle: 360, clockwise: true)
        circleShapeLayer.path = bezierPath.cgPath
        circleShapeLayer.fillColor = fillColor.cgColor
        self.layer.insertSublayer(circleShapeLayer, at: 0)
    }
}
