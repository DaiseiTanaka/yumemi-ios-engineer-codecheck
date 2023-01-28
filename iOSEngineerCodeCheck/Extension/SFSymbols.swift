//
//  SFSymbols.swift
//  iOSEngineerCodeCheck
//
//  Created by 田中大誓 on 2023/01/28.
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(systemName: String, tintColor: UIColor) {
        self.image = UIImage(systemName: systemName)
        self.tintColor = tintColor
    }
}
