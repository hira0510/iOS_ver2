//
//  CustomTabbar.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class CustomTabbar: UITabBar {
    private var color: UIColor?
    private var radii: CGFloat = 25
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()

        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 4);
        shapeLayer.shadowOpacity = 0.12
        shapeLayer.shadowRadius = 4
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radii, height: radii))
        return path.cgPath
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        self.frame = CGRect(x: 0, y: 0, width: GlobalUtil.calculateWidthScaleWithSize(width: 327).toInt(), height: 50)
        self.layer.cornerRadius = self.frame.height / 2
        let centerY = GlobalUtil.getScreenHeight() - GlobalUtil.getBtmSafeAreaHeight() - (self.frame.height / 2) - 22
        self.center = CGPoint(x: GlobalUtil.getScreenWidth() / 2, y: centerY)
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
}
