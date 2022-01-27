//
//  LoginManager.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import Foundation

class LoginManager {

    private var login: String?

    static let didLoginNotificationName = Notification.Name("LoginManager_didLoginNotification")
    static let didLogoutNotificationName = Notification.Name("LoginManager_didLogoutNotification")

    private static let key = "LoginManager_authKey"
    init() {
        login = UserDefaults.standard.string(forKey: LoginManager.key)
    }

    func isAuthenticated() -> Bool {
        let authenticated = login != nil
        return authenticated
    }

    func authenticate(withLogin login: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.login = login
            UserDefaults.standard.set(login, forKey: LoginManager.key)
            NotificationCenter.default.post(name: LoginManager.didLoginNotificationName, object: self)
        }
    }

    func logout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.login = nil
            UserDefaults.standard.removeObject(forKey: LoginManager.key)
            NotificationCenter.default.post(name: LoginManager.didLogoutNotificationName, object: self)
        }
    }

    func userName() -> String {
        return self.login ?? ""
    }
}

