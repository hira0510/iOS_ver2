//
//  HomeViewModel.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

extension Notification.Name {
    static let homeGetAmount = Notification.Name("getAmount")
    static let homeGetFavorite = Notification.Name("getFavorite")
    static let homeGetADBanner = Notification.Name("getADBanner")
}

public enum HomeSection: Int, CaseIterable {
    case member = 0
    case accountBalance
    case menu
    case favor
    case adBanner
}

public enum AmountType: Int, CaseIterable {
    case saving = 0
    case fixedDeposited
    case digital
    
    static func fromRawValue(_ rawValue: Int) -> AmountType {
        switch rawValue {
        case 1: return .fixedDeposited
        case 2: return .digital
        default: return .saving
        }
    }
}


class HomeViewModel {

    var isAddNotificationCenter: Bool = false
    var moneyAccountModel: [String] = []
    var moneyModel: [AmountListData] = []
    var favorModel: [FavoriteListData] = []
    var adBannerModel: [String] = []
    var notificationModel: [NotificationListData] = []
    let reloadGroup: DispatchGroup = DispatchGroup()
    
    var amountType = AmountType.fromRawValue(Defaults[.amountTypeHash]) {
        didSet {
            DispatchQueue.main.async {
                Defaults[.amountTypeHash] = self.amountType.rawValue
            }
        }
    }

    var collectionSection: [HomeSection] = [
            .member,
            .accountBalance,
            .menu,
            .favor,
            .adBanner
    ]

    /// 請求$$資料
    func getAmountListData(apiType: HomeApiType, refresh: Bool) {
        let sectionType: HomeSection = .accountBalance
        var userInfo: [String: Any] = ["sectionType": sectionType, "isRefresh": refresh, "isSuccess": false]
        HttpRequst.urlRequest(apiType.rawValue, AmountModel.self) { [weak self] model in
            guard let `self` = self else { return }
            var data: [AmountListData]?
            if let model = model, let result = model.result {
                switch self.amountType {
                case .saving:
                    data = result.savingsList
                case .fixedDeposited:
                    data = result.fixedDepositList
                case .digital:
                    data = result.digitalList
                }
            }
            if let list = data {
                self.moneyModel = list
                userInfo["isSuccess"] = true
            }
            NotificationCenter.default.post(name: .homeGetAmount, object: nil, userInfo: userInfo)
        }
    }

    /// 請求收藏資料
    func getFavoriteListData(refresh: Bool) {
        let apiType: HomeApiType = .favorite
        let sectionType: HomeSection = .favor
        var userInfo: [String: Any] = ["sectionType": sectionType, "isRefresh": refresh, "isSuccess": false]
        HttpRequst.urlRequest(apiType.rawValue, FavoriteModel.self) { [weak self] model in
            guard let `self` = self else { return }
            if let model = model, let result = model.result {
                self.favorModel = result.favoriteList
                userInfo["isSuccess"] = true
            }
            NotificationCenter.default.post(name: .homeGetFavorite, object: nil, userInfo: userInfo)
        }
    }

    /// 請求輪播廣告資料
    func getADBannerListData(refresh: Bool) {
        let apiType: HomeApiType = .ADBanner
        let sectionType: HomeSection = .adBanner
        var userInfo: [String: Any] = ["sectionType": sectionType, "isRefresh": refresh, "isSuccess": false]
        HttpRequst.urlRequest(apiType.rawValue, ADBannerModel.self) { [weak self] model in
            guard let `self` = self else { return }
            if let model = model, let result = model.result {
                self.adBannerModel = result.bannerList.map { $0.linkUrl }
                userInfo["isSuccess"] = true
            }
            NotificationCenter.default.post(name: .homeGetADBanner, object: nil, userInfo: userInfo)
        }
    }
    
    /// 請求通知資料
    func getNotificationListData(apiType: HomeApiType, refresh: Bool) {
        let sectionType: HomeSection = .member
        var userInfo: [String: Any] = ["sectionType": sectionType, "isRefresh": refresh, "isSuccess": false]
        HttpRequst.urlRequest(apiType.rawValue, NotificationModel.self) { [weak self] model in
            guard let `self` = self else { return }
            if let model = model, let result = model.result {
                self.notificationModel = result.messages
                userInfo["isSuccess"] = true
            }
            NotificationCenter.default.post(name: .homeGetADBanner, object: nil, userInfo: userInfo)
        }
    }
}
