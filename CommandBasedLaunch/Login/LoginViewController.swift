//
//  LoginViewController.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    lazy var loginButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Login",
                                     style: .plain,
                                     target: self,
                                     action: #selector(loginAction(_:)))
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItems = [self.loginButton]
    }

    @objc private func loginAction(_ sender: Any?) {
        self.textField.resignFirstResponder()
        self.sceneDelegate?.loginManager.authenticate(withLogin: self.textField.text ?? "")
    }
}
