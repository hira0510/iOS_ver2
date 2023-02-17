//
//  HomeFavorItemCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

enum HomeFavorType: String {
    
    case mobile = "Home_icon_scroll_mobile"
    case tree = "Home_icon_scroll_tree"
    case creditCard = "Home_icon_scroll_creditCard"
    case building = "Home_icon_scroll_building"
    
    static func getType(model: FavoriteListData) -> HomeFavorType {
        switch model.transType {
        case "CUBC": return .tree
        case "Mobile": return .mobile
        case "PMF": return .building
        case "CreditCard": return .creditCard
        default: return .mobile
        }
    }
}

class HomeFavorItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "HomeFavorItemCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configCell(model: FavoriteListData) {
        let type: HomeFavorType = HomeFavorType.getType(model: model)
        itemImageView.image = UIImage(named: type.rawValue)
        itemTitleLabel.text = model.nickname
    }
}
