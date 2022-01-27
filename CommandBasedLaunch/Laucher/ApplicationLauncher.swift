//
//  ApplicationLauncher.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

class ApplicationLauncher {
    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInitiated
        return queue
    }()
    weak var sceneDelegate: SceneDelegate?

    func onLaunch() {
        guard let sceneDelegate = sceneDelegate else {
            fatalError()
        }

        let loginOperation = LoginOperation(sceneDelegate: sceneDelegate)
        let showAppUIOperation = ShowApplicationUIOperation(sceneDelegate: sceneDelegate)

        showAppUIOperation.addDependency(loginOperation)

        [loginOperation, showAppUIOperation].forEach {
            self.queue.addOperation($0)
        }
    }

    func handlePush() {

    }

    func onLogout() {
        guard let sceneDelegate = sceneDelegate else {
            fatalError()
        }

        let loginOperation = LoginOperation(sceneDelegate: sceneDelegate)
        let showAppUIOperation = ShowApplicationUIOperation(sceneDelegate: sceneDelegate)

        showAppUIOperation.addDependency(loginOperation)

        [loginOperation, showAppUIOperation].forEach {
            self.queue.addOperation($0)
        }
    }
}
