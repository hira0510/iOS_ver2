//
//  HomeADBannerItemCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeADBannerItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    static var nib: UINib {
        return UINib(nibName: "HomeADBannerItemCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configCell(url: String) {
        itemImageView.loadImage(url: url)
    }
}
