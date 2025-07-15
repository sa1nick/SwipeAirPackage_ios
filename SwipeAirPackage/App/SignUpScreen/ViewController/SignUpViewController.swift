//
//  SignUpViewController.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 03/07/25.
//

import UIKit

class SignUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentVC = SignUpContentViewController()
        addChild(contentVC)
        view.addSubview(contentVC.view)
        contentVC.view.frame = view.bounds
        contentVC.didMove(toParent: self)
    }
}
