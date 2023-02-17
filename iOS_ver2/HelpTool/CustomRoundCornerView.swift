//
//  NGSCustomizableRoundCornerView.swift
//  WebPTest
//
//  Created by Hira on 2022/11/25.
//

import UIKit

class CustomRoundCornerView: CustomView {
    /// 圓角數值
    @IBInspectable var RoundLeftB: Int = 0
    /// 圓角數值
    @IBInspectable var RoundRightT: Int = 0
    /// 圓角數值
    @IBInspectable var RoundRightB: Int = 0
    
    override func addCornerRatioMask() {
        let roundRatios: CGFloat = RoundRatio / 2.0
        let cornerRadii = RoundValue == 0 ? self.bounds.height * roundRatios: CGFloat(RoundValue)
        
        var leftTopRadius: CGSize = CGSize.zero
        var leftBottomRadius: CGSize = CGSize.zero
        var rightTopRadius: CGSize = CGSize.zero
        var rightBottomRadius: CGSize = CGSize.zero
        

        if LeftTop {
            leftTopRadius = CGSize(width: cornerRadii, height: cornerRadii)
        }

        if LeftBotton {
            let cornerRadiii = RoundLeftB == 0 ? cornerRadii: CGFloat(RoundLeftB)
            leftBottomRadius = CGSize(width: cornerRadiii, height: cornerRadiii)
        }

        if RightTop {
            let cornerRadiii = RoundRightT == 0 ? cornerRadii: CGFloat(RoundRightT)
            rightTopRadius = CGSize(width: cornerRadiii, height: cornerRadiii)
        }

        if RightBottom {
            let cornerRadiii = RoundRightB == 0 ? cornerRadii: CGFloat(RoundRightB)
            rightBottomRadius = CGSize(width: cornerRadiii, height: cornerRadiii)
        }
        
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: leftTopRadius, topRightRadius: rightTopRadius, bottomLeftRadius: leftBottomRadius, bottomRightRadius: rightBottomRadius)
        roundCornersMask.path = maskPath.cgPath
    }
}
