//
//  HomeNavViewController.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import UIKit

class HomeNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        let tintColor: UIColor = .clear
        let titleColor: UIColor = UIColor(0x1a1a1a)
        
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = tintColor
            
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: titleColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        } else {
            self.navigationController?.navigationBar.barTintColor = tintColor
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: titleColor,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ]
        }
    }
}
