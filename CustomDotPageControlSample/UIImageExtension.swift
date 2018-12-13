//
//  UIImageExtension.swift
//  CustomDotPageControlSample
//
//  Created by Yuki Sumida on 2018/12/13.
//  Copyright © 2018年 Yuki Sumida. All rights reserved.
//

import UIKit

extension UIImage {
    class func dotImage(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)

        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fillEllipse(in: rect)
        let _image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        guard let image = _image else { return UIImage() }
        return image
    }
}
