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
    private var collectionDataSource: [String] = ["M", "I", "N", "D", "I", "N", "V", "E", "N", "T", "O", "R", "Y"]

    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItem()
        configurePageViewController()
    }
    
    private func configureTabBarItem() {
        
        topTabBarView.dataSource = collectionDataSource
        topTabBarView.dotColor = .white
        topTabBarView.waveHeight = 16
        topTabBarView.leftPadding = 10
        topTabBarView.rightPadding = 10
        topTabBarView.tabBarColor = .red
        view.backgroundColor = .red
        topTabBarView.onItemSelected = {[weak self] (index) in
            self?.selectedIndex = index
            self?.pageViewController.setViewControllers([(self?.viewControllers[index] ?? UIViewController())], direction: .forward, animated: false, completion: nil)
        }
        topTabBarView.isScaleItem = true
        topTabBarView.tabBarItemStyle = .setStyle(font: UIFont.boldSystemFont(ofSize: 18),
                                                  foregroundColor: .white)
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

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red:   .random(),
            green: .random(),
            blue:  .random(),
            alpha: 1.0
        )
    }
}
