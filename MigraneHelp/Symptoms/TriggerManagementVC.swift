//
//  TriggerManagementVC.swift
//  MigraneHelp
//
//  Created by Aishwarya on 16/11/21.
//

import Foundation
import UIKit

class TriggerManagementVC : UIViewController {

    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.title = "Prevent your migraine"
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view1.addShadow()
        view3.addShadow()
        view4.addShadow()
        view2.addShadow()

    }

}
