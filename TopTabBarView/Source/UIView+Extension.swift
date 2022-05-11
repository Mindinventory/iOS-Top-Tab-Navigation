//
//  UIView+Extension.swift
//  TopTabbarView
//
//  Created by Parth Gohel on 06/05/22.
//

import UIKit

extension UIView {

    func viewCenter(usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
            return presentationLayer.position
        }
        return center
    }
}
