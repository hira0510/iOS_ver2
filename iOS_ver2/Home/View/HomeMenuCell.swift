//
//  HomeMenuCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeMenuCell: UICollectionViewCell {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    private var collectionItem: [HomeMenuType] = [
        .transfer,
        .payment,
        .utility,
        .QRPayScan,
        .myQRcode,
        .topUp
    ]
    
    static var nib: UINib {
        return UINib(nibName: "HomeMenuCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(HomeMenuItemCell.nib, forCellWithReuseIdentifier: "HomeMenuItemCell")
        mCollectionView.reloadData()
    }
    
    func configCell() {
        mCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension HomeMenuCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeMenuItemCell", for: indexPath) as! HomeMenuItemCell
        guard collectionItem.count > indexPath.item else { return cell }
        cell.configCell(type: collectionItem[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GlobalUtil.calculateWidthScaleWithSize(width: 125), height: GlobalUtil.calculateWidthScaleWithSize(width: 96))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

