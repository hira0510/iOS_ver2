//
//  NGSCustomizableLabel.swift
//
//  Created by  on 2022/9/16.
//


import UIKit

@IBDesignable
class CustomLabel: UILabel {
    
    /// 可以设置文字上下左右的边距
    var textInsets: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - 陰影(文字)
    /// 陰影顏色
    @IBInspectable var ShadowColors: UIColor = .clear {
        didSet {
            self.layer.shadowColor = ShadowColors.cgColor
        }
    }
    /// 陰影透明度 0~1(通常設1)
    @IBInspectable var ShadowOpacitys: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = ShadowOpacitys
        }
    }
    /// 陰影範圍 數值越高越模糊分散(依設計稿Blur直接填)
    @IBInspectable var ShadowBlurs: Double = 0.0 {
        didSet {
            self.layer.shadowRadius = CGFloat(ShadowBlurs / 2)
        }
    }
    /// 陰影方向 下右為正,上左為負
    @IBInspectable var ShadowOffsets: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = ShadowOffsets
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
    }
}


extension CustomLabel {
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        guard !(text?.isEmpty ?? true) else { return super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines) }
        
        let addInset = bounds.inset(by: textInsets)
        let realRect = super.textRect(forBounds: addInset, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top, left: -textInsets.left, bottom: -textInsets.bottom, right: -textInsets.right)
        return realRect.inset(by: invertedInsets)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
