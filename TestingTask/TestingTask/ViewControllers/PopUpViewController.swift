//
//  PopUpViewController.swift
//  TestingTask
//
//  Created by Evgeniy Lemish on 26.09.2022.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var popUpMessageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.popUpMessageView.roundFrame(10)
    }
    // MARK: - Action Close POP-up window
    
    @IBAction func closePopUpVC(_ sender:  Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}

// MARK: - Extension for UIView

extension UIView {

    func roundFrame(_ rounding: CGFloat) {
        self.layer.cornerRadius = rounding
        self.clipsToBounds = true
    }
}
