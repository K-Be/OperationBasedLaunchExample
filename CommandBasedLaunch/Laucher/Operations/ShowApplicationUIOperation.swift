//
//  ShowApplicationUIOperation.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

class ShowApplicationUIOperation: Operation {

    let sceneDelegate: SceneDelegate

    init(sceneDelegate: SceneDelegate) {
        self.sceneDelegate = sceneDelegate
    }

    override func main() {
        super.main()
        self.syncOnMain {
            self.sceneDelegate.showApplicationUI()
        }

    }

}
