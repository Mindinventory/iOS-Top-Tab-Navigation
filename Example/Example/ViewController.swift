//
//  ViewController.swift
//  Example
//
//  Created by mac-0009 on 10/05/22.
//

import UIKit
import TopTabBarView

class ViewController: UIViewController {

    @IBOutlet weak var topTabBarView: TopTabbarView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItem()
        // Do any additional setup after loading the view.
    }
    
    private func configureTabBarItem() {
        
        topTabBarView.dataSource = ["C", "O", "N", "C", "E", "P", "T"]
        topTabBarView.dotColor = .orange
        topTabBarView.waveHeight = 20
        topTabBarView.leftPadding = 60
        topTabBarView.rightPadding = 60
        topTabBarView.tabBarColor = .systemBlue
        topTabBarView.onItemSelected = { (index) in
            debugPrint("Index: \(index)")
        }
        topTabBarView.isScaleItem = true
        topTabBarView.tabBarItemStyle = .setStyle(font: UIFont.boldSystemFont(ofSize: 18),
                                                  foregroundColor: .white)
    }

}

