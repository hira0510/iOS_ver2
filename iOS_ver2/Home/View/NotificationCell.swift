//
//  NotificationCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/17.
//

import UIKit

class NotificationCell: UICollectionViewCell {
    
    @IBOutlet weak var hintView: CustomView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "NotificationCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configCell(model: NotificationListData) {
        titleLabel.text = model.title
        messageLabel.text = model.message
        dateLabel.text = model.updateDateTime
        hintView.isHidden = model.status
    }
}
