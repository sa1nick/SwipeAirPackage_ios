//
//  LoginViewController.swift
//  SwipeAirPackage
//
//  Created by apple on 08/07/25.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentVC = LoginContentViewController()
        addChild(contentVC)
        view.addSubview(contentVC.view)
        contentVC.view.frame = view.bounds
        contentVC.didMove(toParent: self)
    }
}
