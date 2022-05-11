//
//  ViewController.swift
//  Example
//
//  Created by Parth Gohel on 10/05/22.
//

import UIKit
import TopTabBarView

class ViewController: UIViewController {

    @IBOutlet private weak var topTabBarView: TopTabbarView!
    @IBOutlet private weak var pageContainerView: UIView!

    private var pageViewController: UIPageViewController!
    private var viewControllers: [UIViewController] = []
    private var collectionDataSource: [String] = ["M", "I", "N", "D", "3", "0", "0"]

    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItem()
        configurePageViewController()
    }
    
    private func configureTabBarItem() {
        
        topTabBarView.dataSource = collectionDataSource
        topTabBarView.dotColor = .white
        topTabBarView.waveHeight = 20
        topTabBarView.leftPadding = 60
        topTabBarView.rightPadding = 60
        topTabBarView.tabBarColor = .red
        view.backgroundColor = .red
        topTabBarView.onItemSelected = {[weak self] (index) in
            self?.selectedIndex = index
            self?.pageViewController.setViewControllers([(self?.viewControllers[index] ?? UIViewController())], direction: .forward, animated: false, completion: nil)
        }
        topTabBarView.isScaleItem = true
        topTabBarView.tabBarItemStyle = .setStyle(font: UIFont.boldSystemFont(ofSize: 18),
                                                  foregroundColor: .white)
        topTabBarView.selectedTab = 1
        applyCorner()
    }

    func applyCorner() {
        DispatchQueue.main.async {
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.topTabBarView.contentView.bounds
            rectShape.position = self.topTabBarView.contentView.center
            rectShape.path = UIBezierPath(roundedRect: self.topTabBarView.contentView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 50, height: 50)).cgPath
            
            self.topTabBarView.contentView.layer.backgroundColor = UIColor.red.cgColor
            self.topTabBarView.contentView.layer.mask = rectShape
        }
    }

    private func configurePageViewController() {

        viewControllers = []

        _ = collectionDataSource.enumerated().map { (index, title) in
            let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ContentViewController") as! ContentViewController
            viewController.view.tag = index
            viewController.update(with: title)
            viewController.view.backgroundColor = .white
            viewControllers.append(viewController)
        }

        self.pageViewController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageViewController.view.frame = CGRect.init(x: 0, y: 0, width: self.pageContainerView.frame.width, height: self.pageContainerView.frame.height)
        addChild(self.pageViewController)
        self.pageViewController.setViewControllers([viewControllers[0]], direction: .forward, animated: true, completion: nil)
        self.pageContainerView.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParent: self)
    }
}
