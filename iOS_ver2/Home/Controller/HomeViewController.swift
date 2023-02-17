//
//  HomeViewController.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeViewController: HomeBaseViewController {

    @IBOutlet var views: HomeViews! {
        didSet {
            views.vc = self
        }
    }

    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addNotificationCenter()
        
        let amountType = self.viewModel.amountType
        requsetData(HomeApiType.amountApiType(amountType: amountType, isUSD: false))
        requsetData(.ADBanner)
        requsetData(.notificationListEmpty)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationCenter()
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.isAddNotificationCenter = false
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - private
    
    /// 設定觀察者
    private func addNotificationCenter() {
        guard !viewModel.isAddNotificationCenter else { return }
        viewModel.isAddNotificationCenter.toggle()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection), name: .homeGetAmount, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection), name: .homeGetFavorite, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSection), name: .homeGetADBanner, object: nil)
    }
    
    /// 設定UI
    private func setupUI() {
        //加載更多資料
        views.refreshControl.addTarget(self, action: #selector(reload), for: UIControl.Event.valueChanged)
        views.mCollectionView.reloadData()
    }

    private func requsetData(_ apiType: HomeApiType, refresh: Bool = false) {
        switch apiType {
        case .favorite:
            viewModel.getFavoriteListData(refresh: refresh)
        case .ADBanner:
            viewModel.getADBannerListData(refresh: refresh)
        case .notificationList, .notificationListEmpty:
            viewModel.getNotificationListData(apiType: apiType, refresh: refresh)
        default:
            viewModel.getAmountListData(apiType: apiType, refresh: refresh)
        }
    }

    // MARK: - @objc

    /// 下拉刷新
    @objc private func reload() {
        let amountType = self.viewModel.amountType
//        let queue1 = DispatchQueue(label: "queue1", attributes: .concurrent, target: DispatchQueue.global(qos: .background))
//        viewModel.reloadGroup.enter()
//        queue1.async(group: viewModel.reloadGroup) {
//            let amountType = HomeApiType.amountApiType(amountType: amountType, isUSD: true, refresh: true)
//            self.requsetData(amountType, refresh: true)
//        }
        
        let queue2 = DispatchQueue(label: "queue2", attributes: .concurrent, target: DispatchQueue.global(qos: .background))
        viewModel.reloadGroup.enter()
        queue2.async(group: viewModel.reloadGroup) {
            let amountType = HomeApiType.amountApiType(amountType: amountType, isUSD: false, refresh: true)
            self.requsetData(amountType, refresh: true)
        }
        
        let queue3 = DispatchQueue(label: "queue3", attributes: .concurrent, target: DispatchQueue.global(qos: .background))
        viewModel.reloadGroup.enter()
        queue3.async(group: viewModel.reloadGroup) {
            self.requsetData(.favorite, refresh: true)
        }
        
        let queue4 = DispatchQueue(label: "queue4", attributes: .concurrent, target: DispatchQueue.global(qos: .background))
        viewModel.reloadGroup.enter()
        queue4.async(group: viewModel.reloadGroup) {
            self.requsetData(.notificationList, refresh: true)
        }
    }

    /// 重新載入Section
    @objc func reloadSection(notification: Notification) {
        // 解開 userInfo 的包裝
        guard let sectionType = notification.userInfo?["sectionType"] as? HomeSection, let isSuccess = notification.userInfo?["isSuccess"] as? Bool, let isRefresh = notification.userInfo?["isRefresh"] as? Bool else { return }
        if isSuccess {
            let index = unwrap(self.viewModel.collectionSection.firstIndex(of: sectionType), sectionType.rawValue)
            self.views.mCollectionView.reloadSections(IndexSet(integer: index))
        }
        if isRefresh {
            viewModel.reloadGroup.leave()
            viewModel.reloadGroup.notify(queue: DispatchQueue.main) {
                self.views.refreshControl.endRefreshing()
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.collectionSection.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel.collectionSection[indexPath.section]
        switch section {
        case .member:
            let cell = collectionView.dequeueReusableCell(with: HomeMemberCell.self, for: indexPath)
            cell.configCell(notificationIsEmpty: viewModel.notificationModel.isEmpty, delegate: self)
            return cell
        case .accountBalance:
            let cell = collectionView.dequeueReusableCell(with: HomeAccountBalanceCell.self, for: indexPath)
            cell.configCell(model: viewModel.moneyModel)
            return cell
        case .menu:
            let cell = collectionView.dequeueReusableCell(with: HomeMenuCell.self, for: indexPath)
            cell.configCell()
            return cell
        case .favor:
            let cell = collectionView.dequeueReusableCell(with: HomeFavorCell.self, for: indexPath)
            cell.configCell(model: viewModel.favorModel)
            return cell
        case .adBanner:
            let cell = collectionView.dequeueReusableCell(with: HomeADBannerCell.self, for: indexPath)
            cell.cellConfig(bannerData: viewModel.adBannerModel)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = viewModel.collectionSection[indexPath.section]
        let screenWidth = GlobalUtil.getScreenWidth()
        switch section {
        case .member:
            return CGSize(width: screenWidth, height: GlobalUtil.calculateWidthScaleWithSize(width: 48))
        case .accountBalance:
            let itemCount: Int = viewModel.moneyModel.isEmpty ? 2 : viewModel.moneyModel.count
            let itemCountHeight: CGFloat = itemCount.toCGFloat() * 64
            return CGSize(width: GlobalUtil.getScreenWidth(), height: GlobalUtil.calculateWidthScaleWithSize(width: 48 + itemCountHeight))
        case .menu:
            return CGSize(width: screenWidth, height: GlobalUtil.calculateWidthScaleWithSize(width: 200))
        case .favor:
            return CGSize(width: screenWidth, height: GlobalUtil.calculateWidthScaleWithSize(width: 136))
        case .adBanner:
            return CGSize(width: screenWidth, height: GlobalUtil.calculateWidthScaleWithSize(width: 116))
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sections = viewModel.collectionSection[section]
        switch sections {
        case .accountBalance:
            return UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        case .favor:
            return UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        case .adBanner:
            return UIEdgeInsets(top: 0, left: 0, bottom: 30 + GlobalUtil.getBtmSafeAreaHeight(), right: 0)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - HomeMemberCellProtocol
extension HomeViewController: HomeMemberCellProtocol {
    func didClickNotificationBtn() {
        let vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        vc.notificationModel = viewModel.notificationModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
