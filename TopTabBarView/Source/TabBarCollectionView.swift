//
//  CustomTabBar.swift
//  CustomTopBarDemo
//
//  Created by Parth Gohel on 06/05/22.
//

import Foundation
import UIKit

public class TabBarCollectionView: UICollectionView {

    /// Fill color of back wave layer
    var layerFillColor: UIColor {
        get {
            return UIColor(cgColor: kLayerFillColor)
        }
        set{
            kLayerFillColor = newValue.cgColor
            backgroundColor = newValue
        }
    }

    var numberOfItem: Int = 0

    /// Wave Height
    var waveHeight: CGFloat {
        get{
            return self.minimalHeight
        }
        set{
            self.minimalHeight = newValue
        }
    }
    
    var numberOfTabItem: Int {
        get {
            return numberOfItem
        } set {
            numberOfItem = newValue
        }
    }
    
    var dotColor: UIColor = .red {
        didSet {
            circlePoint.fillColor = dotColor
        }
    }
    internal var minimalHeight: CGFloat = 18
    private var kLayerFillColor: CGColor = UIColor.red.cgColor
    private var displayLink: CADisplayLink!
    private let tabBarShapeLayer = CAShapeLayer()
    private var minimalY: CGFloat {
        get {
            return -minimalHeight
        }
    }
    var animating = false {
        didSet {
            self.isUserInteractionEnabled = !animating
            self.displayLink?.isPaused = !animating
        }
    }
    
    /// Controll point of wave
    
    private var leftPoint4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            leftPoint4.backgroundColor = .clear
        }
    }
    private var leftPoint3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            leftPoint3.backgroundColor = .clear
        }
    }
    private var leftPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            leftPoint2.backgroundColor = .clear
        }
    }
    private var leftPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            leftPoint1.backgroundColor = .clear
        }
    }
    private var centerPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            centerPoint1.backgroundColor = .clear
        }
    }
    private var centerPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            centerPoint2.backgroundColor = .clear
        }
    }
    private var rightPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            rightPoint1.backgroundColor = .clear
        }
    }
    private var rightPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            rightPoint2.backgroundColor = .clear
        }
    }
    private var rightPoint4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            rightPoint4.backgroundColor = .clear
        }
    }
    private var circlePoint = CircleView(frame: CGRect(x: 0.0, y: 0.0, width: 8, height: 8)) {
        didSet {
            circlePoint.backgroundColor = .clear
        }
    }
    
    /// Draws the receiver’s image within the passed-in rectangle.
    ///
    /// - Parameter rect: rect of view
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupTabBar()
    }
}

// MARK: - Setup Tabbar
extension TabBarCollectionView {
    
    func setupTabBar() {

        guard numberOfItem != 0 else { return }
        clipsToBounds = false
        addSubview(leftPoint4)
        addSubview(leftPoint3)
        addSubview(leftPoint2)
        addSubview(leftPoint1)
        addSubview(centerPoint1)
        addSubview(centerPoint2)
        addSubview(rightPoint1)
        addSubview(rightPoint2)
        addSubview(rightPoint4)
        addSubview(circlePoint)
        displayLink = CADisplayLink(target: self, selector: #selector(updateShapeLayer))
        displayLink?.add(to: RunLoop.main, forMode: RunLoop.Mode.default)
        displayLink?.isPaused = true
        tabBarShapeLayer.fillColor = kLayerFillColor
        layer.insertSublayer(tabBarShapeLayer, at: 0)
        update(with: 1)
        updateShapeLayer()
    }

    func update(with index: Int) {
        guard numberOfItem != 0
        else { return }
        let width = (self.bounds.width)/CGFloat(numberOfItem)
        let changeValue = (width*(CGFloat(index)))-(width/2)
        setDefaultlayoutControlPoints(waveHeight: minimalHeight, locationX: changeValue)
    }
}

// MARK: - Set layer path
extension TabBarCollectionView {

    func setDefaultlayoutControlPoints(waveHeight: CGFloat, locationX: CGFloat) {

        let width = (bounds.width/CGFloat(numberOfItem))
        leftPoint4.center = CGPoint(x: 0, y: bounds.maxY)
        rightPoint4.center = CGPoint(x: bounds.width, y: bounds.maxY)

        let imaganaeryFram = CGRect(x: locationX-(width/2), y: self.bounds.maxY + minimalHeight , width: width, height: minimalHeight)
        
        leftPoint3.center = CGPoint(x: imaganaeryFram.minX - width/2, y: self.bounds.maxY)

        let topOffset: CGFloat = imaganaeryFram.width / 4.3
        let bottomOffset: CGFloat = imaganaeryFram.width / 4.5
        
        leftPoint2.center = CGPoint(x: imaganaeryFram.midX, y: imaganaeryFram.minY)
        leftPoint1.center = CGPoint(x: imaganaeryFram.minX + bottomOffset, y: self.bounds.maxY)
        centerPoint1.center = CGPoint(x: imaganaeryFram.midX - topOffset - 8, y: imaganaeryFram.minY)
        centerPoint2.center = CGPoint(x: imaganaeryFram.maxX + width/2, y: self.bounds.maxY)
        rightPoint1.center = CGPoint(x: imaganaeryFram.midX + topOffset + 8, y: imaganaeryFram.minY)
        rightPoint2.center = CGPoint(x: imaganaeryFram.maxX - bottomOffset, y: self.bounds.maxY)
        circlePoint.center = CGPoint(x: leftPoint2.center.x, y: self.bounds.maxY)
    }

    /// updateShapeLayer
    @objc func updateShapeLayer() {
        tabBarShapeLayer.path = getCurrentPath()
    }

    /// Get path
    ///
    /// - Returns: get current index path
    func getCurrentPath() -> CGPath {

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: self.bounds.height))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: leftPoint4.viewCenter(usePresentationLayerIfPossible: animating).y))
        bezierPath.addLine(to: leftPoint3.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addCurve(
            to: leftPoint2.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint1: leftPoint1.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint2: centerPoint1.viewCenter(usePresentationLayerIfPossible: animating)
        )
        bezierPath.addCurve(
            to: centerPoint2.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint1: rightPoint1.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint2: rightPoint2.viewCenter(usePresentationLayerIfPossible: animating)
        )
        bezierPath.addLine(to: leftPoint3.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addLine(to: rightPoint4.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        bezierPath.close()
        return bezierPath.cgPath
        
    }
}
