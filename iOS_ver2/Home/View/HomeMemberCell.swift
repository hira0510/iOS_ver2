//
//  HomeMemberCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

protocol HomeMemberCellProtocol: AnyObject {
    func didClickNotificationBtn()
}

class HomeMemberCell: UICollectionViewCell {

    @IBOutlet weak var notificationButton: UIButton!
    private weak var delegate: HomeMemberCellProtocol?
    
    static var nib: UINib {
        return UINib(nibName: "HomeMemberCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notificationButton.addTarget(self, action: #selector(didClickNotificationButton), for: .touchUpInside)
    }
    
    public func configCell(notificationIsEmpty: Bool, delegate: HomeMemberCellProtocol) {
        notificationButton.isSelected = !notificationIsEmpty
        self.delegate = delegate
    }
    
    @objc func didClickNotificationButton() {
        delegate?.didClickNotificationBtn()
    }
}
