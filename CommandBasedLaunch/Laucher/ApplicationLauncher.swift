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
        let askPush = SubscribeToPushOperation(sceneDelegate: sceneDelegate)

        showAppUIOperation.addDependency(loginOperation)
        askPush.addDependency(showAppUIOperation)

        [loginOperation, showAppUIOperation, askPush].forEach {
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

    func handleURL(_ url: URL) {
        let operation = OpenURLOperation(sceneDelegate: self.sceneDelegate!, url: url)
        let currentOperations = self.queue.operations
        currentOperations.forEach {
            operation.addDependency($0)
        }
        self.queue.addOperation(operation)
    }
}
