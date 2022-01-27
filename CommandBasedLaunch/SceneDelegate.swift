//
//  SceneDelegate.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import UIKit

enum SceneState {
    case loading
    case login
    case application
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
    let loginManager = LoginManager()
    let pushCenter = PushNotificationsCenter()
    private var state = SceneState.loading
    lazy var launcher: ApplicationLauncher = {
        let launcher = ApplicationLauncher()
        launcher.sceneDelegate = self
        return launcher
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        let viewController = UIViewController(nibName: nil, bundle: nil)
        let navController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navController
        self.navController = navController
        self.window = window
        window.makeKeyAndVisible()
        self.state = .loading
        navController.present(LoadingViewController(nibName: nil, bundle: nil),
                              animated: false,
                              completion: nil)
        self.launcher.onLaunch()
        self.subscribeOnNotifications()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func showLogin() {
        let viewController = LoginViewController(nibName: nil, bundle: nil)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.hideLoadingScreen()
            self.state = .login
        }
        self.navController?.setViewControllers([viewController], animated: true)
        CATransaction.commit()
    }

    func showApplicationUI() {
        let viewController = ViewController(nibName: nil, bundle: nil)
        viewController.label.text = self.loginManager.userName()
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.hideLoadingScreen()
            self.state = .application
        }
        self.navController?.setViewControllers([viewController], animated: true)
        CATransaction.commit()
    }

    private func hideLoadingScreen() {
        if (self.state == .loading) {
            self.navController?.dismiss(animated: true, completion: nil)
        }
    }

}

extension SceneDelegate {
    func subscribeOnNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logoutNotification(_:)),
                                               name: LoginManager.didLogoutNotificationName,
                                               object: self.loginManager)
    }

    @objc func logoutNotification(_ notification: Notification) {
        self.launcher.onLogout()
    }
}


// push notifications
extension SceneDelegate {

}

