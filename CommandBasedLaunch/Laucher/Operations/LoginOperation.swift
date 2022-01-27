//
//  LoginOperation.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import UIKit

class LoginOperation: AsynchronousOperation {
    let sceneDelegate: SceneDelegate
    var handler: NSObjectProtocol?

    internal init(sceneDelegate: SceneDelegate, handler: NSObjectProtocol? = nil) {
        self.sceneDelegate = sceneDelegate
        self.handler = handler
    }

    override func main() {
        super.main()
        guard !isCancelled else {
            self.finish()
            return
        }
        self.syncOnMain {
            guard !self.sceneDelegate.loginManager.isAuthenticated() else {
                self.finish()
                return
            }
            self.handler = NotificationCenter.default.addObserver(forName: LoginManager.didLoginNotificationName,
                                                                  object: nil,
                                                                  queue: OperationQueue.main,
                                                                  using: { [weak self] (_: Notification) in
                guard let self = self else {
                    return
                }
                self.finish()
                self.handler = nil
            })
            self.sceneDelegate.showLogin()
        }
    }
}
