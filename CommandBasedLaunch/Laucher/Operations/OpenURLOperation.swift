//
//  OpenURLOperation.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

class OpenURLOperation: AsynchronousOperation {

    let sceneDelegate: SceneDelegate
    let url: URL

    init(sceneDelegate: SceneDelegate, url: URL) {
        self.sceneDelegate = sceneDelegate
        self.url = url
    }

    override func main() {
        super.main()
        guard !isCancelled else {
            self.finish()
            return
        }
        self.syncOnMain {
            self.sceneDelegate.openURLInApplication(self.url)
            self.finish()
        }
    }
}
