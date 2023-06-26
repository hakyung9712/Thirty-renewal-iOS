//
//  UIApplication+Extension.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/27.
//

import UIKit

extension UIApplication {
    func getCurrentViewController() -> UIViewController? {
        let keywindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var viewController = keyWindow?.rootViewController {
            while let presentedViewController = viewController.presentedViewController {
                viewController = presentedViewController
            }
            return viewController
        }
        return nil
    }
}
