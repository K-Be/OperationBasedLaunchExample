//
//  ViewController.swift
//  CommandBasedLaunch
//
//  Created by Andrew Romanov on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {

    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 14.0)
        label.text = "View controller"
        return label
    }()

    lazy var logoutItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "Logout",
                                   style: .plain,
                                   target: self,
                                   action: #selector(logoutAction(_:)))
        return item
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "View Controller"
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [self.logoutItem]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let sceneDelegate = self.sceneDelegate else {
            assert(false)
            return
        }
        let userName = sceneDelegate.loginManager.userName()
        self.label.text = userName
    }

    @objc private func logoutAction(_ sender: Any?) {
        guard let sceneDelegate = self.sceneDelegate else {
            assert(false)
            return
        }
        sceneDelegate.loginManager.logout()
    }
}

