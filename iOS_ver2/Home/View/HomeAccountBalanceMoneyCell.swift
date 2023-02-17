//
//  HomeAccountBalanceMoneyCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeAccountBalanceMoneyCell: UICollectionViewCell {
    
    @IBOutlet weak var moneyTypeView: ShimmerView!
    @IBOutlet weak var moneyTypeLabel: UILabel!
    @IBOutlet weak var balanceView: ShimmerView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    static var nib: UINib {
        return UINib(nibName: "HomeAccountBalanceMoneyCell", bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configCell(model: AmountListData?, isHiddenMoney: Bool) {
        if let model = model {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 10
            let money = unwrap(formatter.string(from: NSNumber(value: model.balance)), model.balance.toString())
            
            moneyTypeView.stopAnimating()
            balanceView.stopAnimating()
            moneyTypeLabel.text = model.curr
            balanceLabel.text = isHiddenMoney ? "********": money
        } else {
            moneyTypeView.startAnimating()
            balanceView.startAnimating()
        }
    }
}
