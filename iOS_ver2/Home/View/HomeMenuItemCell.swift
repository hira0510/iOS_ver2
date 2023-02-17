//
//  HomeMenuItemCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

enum HomeMenuType: Equatable {
    typealias HomeMenuTypeModel = (iconName: String, itemName: String)
    
    case transfer
    case payment
    case utility
    case QRPayScan
    case myQRcode
    case topUp
    
    var rawValue: HomeMenuTypeModel {
        switch self {
        case .transfer: return HomeMenuTypeModel("Home_icon_menu_transfer", "Transfer")
        case .payment: return HomeMenuTypeModel("Home_icon_menu_payment", "Payment")
        case .utility: return HomeMenuTypeModel("Home_icon_menu_utility", "Utility")
        case .QRPayScan: return HomeMenuTypeModel("Home_icon_menu_scan", "QR pay scan")
        case .myQRcode: return HomeMenuTypeModel("Home_icon_menu_QRcode", "My QR code")
        case .topUp: return HomeMenuTypeModel("Home_icon_menu_topUp", "Top up")
        }
    }
}

class HomeMenuItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "HomeMenuItemCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configCell(type: HomeMenuType) {
        itemImageView.image = UIImage(named: type.rawValue.iconName)
        itemTitleLabel.text = type.rawValue.itemName
    }
}
