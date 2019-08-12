//
//  UIImageView.swift
//  iOSSummerExampleProject
//
//  Created by xcode on 12.08.2019.
//  Copyright © 2019 Surf. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(by urlString: String) {
        let url = URL(string: urlString)!
        let data = try! Data(contentsOf: url)
        self.image = UIImage(data: data)
    }
}
