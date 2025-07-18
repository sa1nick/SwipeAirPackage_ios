//
//  HomeViewController.swift.swift
//  SwipeAirPackage
//
//  Created by apple on 15/07/25.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentVC = HomeContentViewController()
        addChild(contentVC)
        view.addSubview(contentVC.view)
        contentVC.view.frame = view.bounds
        contentVC.didMove(toParent: self)
    }
}
