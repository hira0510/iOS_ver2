//
//  HomeModel.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import Foundation

// MARK: - $$資料
struct AmountModel: Codable {
    var result: AmountListModel?
}

struct AmountListModel: Codable {
    var savingsList: [AmountListData]?
    var fixedDepositList: [AmountListData]?
    var digitalList: [AmountListData]?
}

struct AmountListData: Codable {
    var account: String = ""
    var curr: String = ""
    var balance: Double = 0.0
}

// MARK: - 收藏資料
struct FavoriteModel: Codable {
    var result: FavoriteListModel?
}

struct FavoriteListModel: Codable {
    var favoriteList: [FavoriteListData] = []
}

struct FavoriteListData: Codable {
    var nickname: String = ""
    var transType: String = ""
}

// MARK: - ADBanner
struct ADBannerModel: Codable {
    var result: ADBannerListModel?
}

struct ADBannerListModel: Codable {
    var bannerList: [ADBannerListData] = []
}

struct ADBannerListData: Codable {
    var linkUrl: String = ""
}

// MARK: - 通知
struct NotificationModel: Codable {
    var result: NotificationListModel?
}

struct NotificationListModel: Codable {
    var messages: [NotificationListData] = []
}

struct NotificationListData: Codable {
    var status: Bool = false
    var updateDateTime: String = ""
    var title: String = ""
    var message: String = ""
}
