//
//  HomeAccountBalanceCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeAccountBalanceCell: UICollectionViewCell {
    
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    var moneyModel: [AmountListData] = []
    
    private var isHiddenMoney = Defaults[.isHiddenMoney] {
        didSet {
            DispatchQueue.main.async {
                Defaults[.isHiddenMoney] = self.isHiddenMoney
            }
        }
    }
    
    static var nib: UINib {
        return UINib(nibName: "HomeAccountBalanceCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.register(HomeAccountBalanceMoneyCell.nib, forCellWithReuseIdentifier: "HomeAccountBalanceMoneyCell")
    }
    
    public func configCell(model: [AmountListData]) {
        moneyModel = model
        eyeButton.isSelected = isHiddenMoney
        mCollectionView.reloadData()
    }
    
    @IBAction func didClickEyeBtn(_ sender: UIButton) {
        sender.isSelected.toggle()
        isHiddenMoney.toggle()
        mCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension HomeAccountBalanceCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moneyModel.isEmpty ? 2: moneyModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAccountBalanceMoneyCell", for: indexPath) as! HomeAccountBalanceMoneyCell
        guard moneyModel.count > indexPath.item else {
            cell.configCell(model: nil, isHiddenMoney: isHiddenMoney)
            return cell
        }
        cell.configCell(model: moneyModel[indexPath.item], isHiddenMoney: isHiddenMoney)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: GlobalUtil.calculateWidthScaleWithSize(width: 64))
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

