//
//  ViewController+SceneDelegate.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation
import UIKit

extension UIViewController {

    var sceneDelegate: SceneDelegate? {
        let delegate = self.view.window?.windowScene?.delegate as? SceneDelegate
        return delegate
    }

}

