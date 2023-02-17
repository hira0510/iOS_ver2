//
//  GlobalUtil.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import Foundation
import UIKit

class GlobalUtil {
    
    static func getBtmSafeAreaHeight() -> CGFloat {
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
    
    static func getScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static func getScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }

    /// 計算高等比放大縮小
    ///
    /// - Parameter width: 被計算的高
    /// - Returns: 回傳CGFloat
    static func calculateHeightScaleWithSize(height: CGFloat) -> CGFloat {
        let scale = height / CGFloat(667)
        let result = UIScreen.main.bounds.height * scale
        return result
    }

    /// 計算寬等比放大縮小
    ///
    /// - Parameter width: 被計算的寬
    /// - Returns: 回傳CGFloat
    static func calculateWidthScaleWithSize(width: CGFloat) -> CGFloat {
        let scale = width / CGFloat(375)
        let result = UIScreen.main.bounds.width * scale
        return result
    }

    /// 計算高等比放大縮小
    /// 667:375
    /// - Parameters:
    ///   - width: 物件寬
    ///   - height: 物件高
    /// - Returns: 回傳CGFloat(等比放大後的高)
    static func calculateHeightScaleWithSize(width: CGFloat, height: CGFloat) -> CGFloat {
        let scale = width / CGFloat(375)
        let itemScale = height / width
        let result = UIScreen.main.bounds.width * scale * itemScale
        return result
    }

    /// 計算螢幕打橫時寬等比放大縮小
    ///
    /// - Parameter width: 被計算的寬
    /// - Returns: 回傳CGFloat
    static func calculateWidthHorizontalScaleWithSize(width: CGFloat) -> CGFloat {
        let scale = width / CGFloat(667)
        let result = UIScreen.main.bounds.width * scale
        return result
    }

    /// 計算高等比放大縮小
    /// 667:375
    /// - Parameters:
    ///   - width: 物件寬
    ///   - height: 物件高
    /// - Returns: 回傳CGFloat(等比放大後的寬)
    static func calculateHeightＨorizontalScaleWithSize(width: CGFloat, height: CGFloat) -> CGFloat {
        let scale = width / CGFloat(667)
        let itemScale = height / width
        let result = UIScreen.main.bounds.width * scale * itemScale
        return result
    }

    /// 計算高等比放大縮小
    ///
    /// - Parameters:
    ///   - height: 要被等比放大的高
    ///   - standardHeight: 設計稿的範例高
    /// - Returns: Returns: 回傳CGFloat（高）
    static func calculateHeightScaleWithSize(height: CGFloat, standardHeight: CGFloat) -> CGFloat {
        let scale = height / CGFloat(standardHeight)
        let result = UIScreen.main.bounds.height * scale
        return result
    }
}
