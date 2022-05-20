//
//  UIView+extCorner.swift
//  LoveRecoder
//
//  Created by Blacour on 2022/2/12.
//

import UIKit

extension UIView {
    /// 部分圆角
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   UIRectCorner(rawValue: UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue)
    ///   - radii: 圆角半径
    func extCorner(corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
