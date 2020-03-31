//
//  ViewController.swift
//  CustomAlert2
//
//  Created by Deftsoft on 07/08/19.
//  Copyright © 2019 Deftsoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showAlertButton(_ sender: UIBarButtonItem) {
        self.showAlert(title: "Alert", message: "Do you want to Logout from application", cancelButtonTitle: "Cancel", okButtonTitle: "Okay")
    }
    
}
extension ViewController {
    func showAlert(title:String?,message:String,cancelButtonTitle:String?,cancelAction:ButtonAction? = nil,okButtonTitle:String?,okAction:ButtonAction? = nil){
        let alert = CustomAlert(title: title, message: message, cancelButtonTitle: cancelButtonTitle, doneButtonTitle: okButtonTitle)
        alert.doneButton.addTarget {
            okAction?()
        }
        alert.cancelButton.addTarget {
            cancelAction?()
        }
        alert.show()
    }
}

