//
//  CustomAlert.swift
//  CustomAlert2
//
//  Created by Deftsoft on 07/08/19.
//  Copyright © 2019 Deftsoft. All rights reserved.
//

import UIKit
typealias ButtonAction = (()->())

class CustomAlert: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    convenience init (title:String?,message:String?,cancelButtonTitle:String?,doneButtonTitle:String?) {
        self.init(frame: UIScreen.main.bounds)
        self.initialize(title: title, message: message, cancelButtonTitle: cancelButtonTitle , doneButtonTitle: doneButtonTitle )
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNib()
    }
    
    
    private func setupNib(){
     Bundle.main.loadNibNamed("CustomAlert", owner: self, options: nil)
     view.frame = self.bounds
     view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
     addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    private func initialize(title:String?,message:String?,cancelButtonTitle:String?,doneButtonTitle:String?){
        self.titleLabel.text = title
        self.messageLabel.text = message
        self.cancelButton.setTitle(cancelButtonTitle, for:.normal)
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        
    }
    func show(){
        self.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    func remove(){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, animations: {
            self.alpha = 1
        }, completion: { (success) in
            self.removeFromSuperview()
        })
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.remove()
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.remove()
    }
}

//For Handle Action
class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}


//Add Target With Closure
extension UIControl {
    func addTarget (action: @escaping ()->()) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: UIControl.Event.touchUpInside)
        objc_setAssociatedObject(self, String(ObjectIdentifier(self).hashValue) + String(UIControl.Event.touchUpInside.rawValue), sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
