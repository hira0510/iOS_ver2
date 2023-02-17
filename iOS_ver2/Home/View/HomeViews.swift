//
//  HomeViews.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeViews: NSObject {
    var vc: HomeViewController = HomeViewController()
    
    @IBOutlet weak var mCollectionView: UICollectionView! {
        didSet {
            mCollectionView.register(HomeMemberCell.nib, forCellWithReuseIdentifier: "HomeMemberCell")
            mCollectionView.register(HomeAccountBalanceCell.nib, forCellWithReuseIdentifier: "HomeAccountBalanceCell")
            mCollectionView.register(HomeMenuCell.nib, forCellWithReuseIdentifier: "HomeMenuCell")
            mCollectionView.register(HomeFavorCell.nib, forCellWithReuseIdentifier: "HomeFavorCell")
            mCollectionView.register(HomeADBannerCell.nib, forCellWithReuseIdentifier: "HomeADBannerCell")
            mCollectionView.delegate = vc
            mCollectionView.dataSource = vc
            mCollectionView.addSubview(refreshControl)
        }
    }
    
    var refreshControl: UIRefreshControl = UIRefreshControl()

}
