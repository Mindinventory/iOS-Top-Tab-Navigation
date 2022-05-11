//
//  CircleView.swift
//  TopTabbarView
//
//  Created by Parth Gohel on 06/05/22.
//

import Foundation
import UIKit

final class CircleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
    }
}
