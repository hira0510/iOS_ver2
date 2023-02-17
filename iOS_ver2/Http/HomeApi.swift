//
//  HomeApi.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/17.
//

import UIKit

public enum HomeApiType: String {
    case USDSaving = "usdSavings1.json"
    case USDFixedDeposited = "usdFixed1.json"
    case USDDigital = "usdDigital1.json"
    case USDSavingRefresh = "usdSavings2.json"
    case USDFixedDepositedRefresh = "usdFixed2.json"
    case USDDigitalRefresh = "usdDigital2.json"
    case KHRSaving = "khrSavings1.json"
    case KHRFixedDeposited = "khrFixed1.json"
    case KHRDigital = "khrDigital1.json"
    case KHRSavingRefresh = "khrSavings2.json"
    case KHRFixedDepositedRefresh = "khrFixed2.json"
    case KHRDigitalRefresh = "khrDigital2.json"
    
    case favorite = "favoriteList.json"
    case ADBanner = "banner.json"
    case notificationListEmpty = "emptyNotificationList.json"
    case notificationList = "notificationList.json"
    
    static func amountApiType(amountType: AmountType, isUSD: Bool, refresh: Bool = false) -> HomeApiType {
        switch amountType {
        case .saving:
            return refresh ? (isUSD ? .USDSavingRefresh: .KHRSavingRefresh): (isUSD ? .USDSaving: .KHRSaving)
        case .fixedDeposited:
            return refresh ? (isUSD ? .USDFixedDepositedRefresh: .KHRFixedDepositedRefresh): (isUSD ? .USDFixedDeposited: .KHRFixedDeposited)
        case .digital:
            return refresh ? (isUSD ? .USDDigitalRefresh: .KHRDigitalRefresh): (isUSD ? .USDDigital: .KHRDigital)
        }
    }
}

class HomeApi: NSObject {

}
