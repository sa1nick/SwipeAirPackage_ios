//
//  EnterOTPViewController.swift
//  SwipeAirPackage
//
//  Created by Khichad Technologis on 04/07/25.
//

import UIKit

class EnterOTPViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentVC = EnterOTPContentViewController()
        add(contentVC)
    }

    private func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.frame = view.bounds
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        child.didMove(toParent: self)
    }
}
