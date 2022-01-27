//
//  ApplicationLauncher.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

class ApplicationLauncher {
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .userInitiated
        return queue
    }()
    weak var sceneDelegate: SceneDelegate?

    func onLaunch() {

    }

    func handlePush() {

    }

    func onLogout() {

    }
}
