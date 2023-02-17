//
//  UIImageViewExtension.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import Foundation
import UIKit

extension UIImageView {
    
    @IBInspectable var OriginalImg: Bool {
        get {
            return self.image?.renderingMode == .alwaysOriginal
        }
        set {
            let renderingMode: UIImage.RenderingMode = newValue ? .alwaysOriginal: .alwaysTemplate
            self.image = self.image?.withRenderingMode(renderingMode)
        }
    }
    
    /// 下載圖片
    func loadImage(url: String, placeholder: UIImage? = nil) {
        
        guard let urls = URL(string: url) else {
            DispatchQueue.main.async {
                self.image = placeholder
            }
            return
        }
        
        URLSession.shared.dataTask(with: urls) { data, response, error in
            if let _ = error {
                DispatchQueue.main.async {
                    self.image = placeholder
                }
            } else if let data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
