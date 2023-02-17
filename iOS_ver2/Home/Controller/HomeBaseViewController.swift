//
//  HomeBaseViewController.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/17.
//

import UIKit

class HomeBaseViewController: BaseUIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    private func setupNavigation() {
        let backItem = UIBarButtonItem(title: "", image: UIImage(named: "Basic_icon_arrow_left"), target: self, action: #selector(previousBack))
        backItem.tintColor = UIColor(0x333333)
        self.navigationItem.leftBarButtonItem = backItem
    }
    
//    private func setupNavigation(_ animated: Bool) {
//        let tintColor: UIColor = .clear
//        let titleColor: UIColor = UIColor(0x1a1a1a)
//
//        if #available(iOS 15.0, *) {
//            let backItem = UIBarButtonItem(title: "", image: UIImage(named: "Basic_icon_arrow_left"), target: self, action: #selector(previousBack))
//            backItem.tintColor = UIColor(0x333333)
//            self.navigationItem.leftBarButtonItem = backItem
//            let appearance = UINavigationBarAppearance()
//            appearance.backgroundColor = tintColor
//            appearance.shadowColor = .clear
//            appearance.configureWithOpaqueBackground()
//            appearance.titleTextAttributes = [
//                NSAttributedString.Key.foregroundColor: titleColor,
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
//            ]
//            self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//            self.navigationController?.navigationBar.shadowImage = nil
//            self.navigationController?.navigationBar.standardAppearance = appearance
//            self.navigationController?.navigationBar.scrollEdgeAppearance =  self.navigationController?.navigationBar.standardAppearance
//        } else {
//            let backItem = UIBarButtonItem(image: UIImage(named: "Basic_icon_arrow_left"), style: .done, target: self, action: #selector(previousBack))
//            self.navigationController?.navigationItem.leftBarButtonItem = backItem
//            self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
//            self.navigationController?.navigationBar.barTintColor = tintColor
//            self.navigationController?.navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.foregroundColor: titleColor,
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
//            ]
//        }
//    }
}
