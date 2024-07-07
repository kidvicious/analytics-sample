//
//  ViewController.swift
//  Analytics-App-UserDefaults
//
//  Created by Asmin Ghale on 7/7/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Analytics.shared.logAllData())
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        Analytics.shared.trackEvent(event: UIElementEvent.buttonTap("tapped."))
    }

}

