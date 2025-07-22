//
//  EnterLocationViewController.swift
//  SwipeAirPackage
//
//  Created by apple on 21/07/25.
//

import Foundation
import UIKit

class EnterLocationViewController: UIViewController {
    
    @IBOutlet weak var addressTableView: UITableView!
    
    let addresses: [[String: Any]] = [
        ["id": 0, "title": "Home", "address": "47 W 13th St, New York, NY 10011, USA", "addressType": "home"],
        ["id": 1, "title": "Office", "address": "Tea Villa Café, 27th Main, 4th Cross, Bengaluru", "addressType": "office"],
        ["id": 2, "title": "Faculty of Arts", "address": "223-8 Oaza-Hamatakei, Usa, Oita Prefecture, Japan", "addressType": "none"],
        ["id": 3, "title": "Gym", "address": "Gold's Gym, Andheri West, Mumbai, Maharashtra", "addressType": "none"],
        ["id": 4, "title": "Parents' House", "address": "15 Maple Ave, Springfield, IL 62704, USA", "addressType": "none"]
    ]
   
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var pickupInputView: UIView!
    @IBOutlet weak var pickupTextInput: UITextField!
    @IBOutlet weak var dropoffInputView: UIView!
    @IBOutlet weak var dropoffTextInput: UITextField!
    @IBOutlet weak var dashedLine: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20).isActive = true
        topContainerView.backgroundColor = UIColor.greyF5F5F5
        pickupInputView.layer.cornerRadius = 25
        dropoffInputView.layer.cornerRadius = 25
        pickupTextInput.borderStyle = .none
        pickupTextInput.tintColor = UIColor.purple680172
        dropoffTextInput.borderStyle = .none
        dropoffTextInput.tintColor = UIColor.purple680172

        addVerticalDashedLine()
        
        addressTableView.dataSource = self
        addressTableView.delegate = self
        addressTableView.separatorStyle = .none

        addressTableView.register(AddressTableViewCell.nib(), forCellReuseIdentifier: AddressTableViewCell.identifier)
    }

    func addVerticalDashedLine() {
        let dashedLineView = UIView(frame: CGRect(x: 23.5, y: 153.5, width: 0, height: 54))
        dashedLineView.backgroundColor = .clear
        view.addSubview(dashedLineView)

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.grey707070.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineDashPattern = [4, 4]
        shapeLayer.lineCap = .butt

        let path = CGMutablePath()
        path.move(to: CGPoint(x: dashedLineView.bounds.width / 2, y: 0))
        path.addLine(to: CGPoint(x: dashedLineView.bounds.width / 2, y: dashedLineView.bounds.height))
        shapeLayer.path = path
        shapeLayer.frame = dashedLineView.bounds

        dashedLineView.layer.addSublayer(shapeLayer)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dashedLine.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        addVerticalDashedLine()
    }
}

// MARK: - TableView Delegate & DataSource
extension EnterLocationViewController: UITableViewDelegate, UITableViewDataSource {

    // Each address is now a separate section
    func numberOfSections(in tableView: UITableView) -> Int {
        return addresses.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as! AddressTableViewCell
        let address = addresses[indexPath.section]

        // Set title and subtitle
        cell.cellTitle.text = address["title"] as? String
        cell.cellSubTitle.text = address["address"] as? String

        // Check addressType
        if let type = address["addressType"] as? String {
            switch type.lowercased() {
            case "home":
                cell.cellIcon.image = UIImage(named: "home") // or UIImage.home if you have an extension
                cell.cellIcon.isHidden = false
            case "office":
                cell.cellIcon.image = UIImage(named: "office") // or UIImage.office
                cell.cellIcon.isHidden = false
            default:
                cell.cellIcon.isHidden = true
            }
        } else {
            cell.cellIcon.isHidden = true
        }

        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55 // Adjust if needed
    }

    // Gap of 30 between each section (each cell is in its own section)
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
}
