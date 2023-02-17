//
//  NotificationViews.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/17.
//

import UIKit

class NotificationViews: NSObject {
    
    var vc: NotificationViewController = NotificationViewController()
    
    @IBOutlet weak var mCollectionView: UICollectionView! {
        didSet {
            mCollectionView.register(NotificationCell.nib, forCellWithReuseIdentifier: "NotificationCell")
            mCollectionView.delegate = vc
            mCollectionView.dataSource = vc
        }
    }
}
