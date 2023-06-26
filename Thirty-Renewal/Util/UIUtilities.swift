//
//  UIUtilities.swift
//  Thirty-Renewal
//
//  Created by hakyung on 2023/06/27.
//

import Foundation
import UIKit

public enum PresentStyle {
    case push
    case modal
}

public func showStoryboard(storyboardId: String, viewControllerId: String, sender: UIViewController /*? = nil*/ , presentStyle: PresentStyle = .push) {
    let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
    var viewController: UIViewController?
    viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId)
    
    guard let vc = viewController else { return }
    switch presentStyle {
    case .modal:
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        sender.present(vc, animated: true)
    case .push:
        sender.navigationController?.pushViewController(vc, animated: true)
    }
    
}
