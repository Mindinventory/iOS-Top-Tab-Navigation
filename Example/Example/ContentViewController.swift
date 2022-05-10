//
//  ContentViewController.swift
//  Example
//
//  Created by Parth Gohel on 10/05/22.
//

import Foundation
import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func update(with title: String) {
        titleLabel.text = title
    }
}

