//
//  HomeADBannerCell.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeADBannerCell: UICollectionViewCell {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var controlView: UIView!

    private var mBannerUrlStr: [String] = []
    private var timer: Timer?
    /// 選擇的cell
    private var currentIndex: Int = 0

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor(0x000000)
        pageControl.pageIndicatorTintColor = UIColor(0x000000).withAlphaComponent(0.3)
        return pageControl
    }()
    
    /// cell的寬度含間距
    private lazy var pageWidth: Int = {
        var calculateWidth: CGFloat = GlobalUtil.calculateWidthScaleWithSize(width: 327)
        return lround(Double(calculateWidth))
    }()

    static var nib: UINib {
        return UINib(nibName: "HomeADBannerCell", bundle: Bundle(for: self))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionViewAndRegisterXib()
        addTimer()
    }
    
    public func cellConfig(bannerData: [String]) {
        guard mBannerUrlStr.isEmpty else { return }
        mBannerUrlStr = bannerData
        addPageControl()
        bannerCollectionView.reloadData()
    }
    
    private func addTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScrollBanner), userInfo: nil, repeats: true)
    }

    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }

    /// 設定UI
    private func setupCollectionViewAndRegisterXib() {
        bannerCollectionView.decelerationRate = .init(rawValue: 0.1)
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.register(HomeADBannerItemCell.nib, forCellWithReuseIdentifier: "HomeADBannerItemCell")
    }

    private func addPageControl() {
        pageControl.numberOfPages = mBannerUrlStr.count
        pageControl.frame = CGRect(x: 0, y: 0, width: GlobalUtil.getScreenWidth(), height: GlobalUtil.calculateWidthScaleWithSize(width: 28))
        controlView.addSubview(pageControl)
    }

    @objc private func autoScrollBanner() {
        guard !mBannerUrlStr.isEmpty else { return }
        
        currentIndex += 1
        if currentIndex < mBannerUrlStr.count {
            bannerCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentIndex
        } else if currentIndex == mBannerUrlStr.count {
            bannerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at:.centeredHorizontally, animated: false)
            pageControl.currentPage = 0
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeADBannerCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mBannerUrlStr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: HomeADBannerItemCell.self, for: indexPath)
        cell.configCell(url: mBannerUrlStr[indexPath.item])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bannerCollectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// 偏移cell
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // 按照偏移量計算是第幾個cell
        let offSetX = targetContentOffset.pointee.x
        // 根據偏移量算是第幾個cell
        let pageCell = Int((offSetX + CGFloat(pageWidth / 2)) / CGFloat(pageWidth))
        let pageCellFloat: CGFloat = pageCell.toCGFloat()
        let pageW: CGFloat = pageWidth.toCGFloat()
        // 根據顯示第幾個cell來偏移
        if Int(offSetX) > ((mBannerUrlStr.count - (mBannerUrlStr.count - pageCell)) * pageWidth + pageWidth / 2) {
            targetContentOffset.pointee.x = (pageCellFloat + 1) * pageW
        } else {
            targetContentOffset.pointee.x = pageCellFloat * pageW
        }
        pageControl.currentPage = currentIndex
        removeTimer()
    }

    /// 减速停止的時候開始執行
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addTimer()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = scrollView.contentOffset
        visibleRect.size = scrollView.bounds.size
        // 拿取每次scroll後scrollView總偏移X的中間值
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        // 用偏移的point來計算當前cell是哪個indexPath
        currentIndex = unwrap(bannerCollectionView.indexPathForItem(at: visiblePoint)?.item, 0)
    }
}
