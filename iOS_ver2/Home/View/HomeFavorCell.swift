//
//  HomeFavorCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeFavorCell: UICollectionViewCell {
    
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    private var favorModel: [FavoriteListData] = []
    
    static var nib: UINib {
        return UINib(nibName: "HomeFavorCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(HomeFavorItemCell.nib, forCellWithReuseIdentifier: "HomeFavorItemCell")
        mCollectionView.reloadData()
    }
    
    func configCell(model: [FavoriteListData]) {
        favorModel = model
        noDataView.isHidden = !model.isEmpty
        mCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension HomeFavorCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeFavorItemCell", for: indexPath) as! HomeFavorItemCell
        guard favorModel.count > indexPath.item else { return cell }
        cell.configCell(model: favorModel[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: GlobalUtil.calculateWidthScaleWithSize(width: 80), height: GlobalUtil.calculateWidthScaleWithSize(width: 80))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 31)
    }
}

