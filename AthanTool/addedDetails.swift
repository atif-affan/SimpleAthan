//
//  addedDetails.swift
//  AthanTool
//
//  Created by Affan on 1/7/22.
//

import Foundation

class addedDetails: ViewController {
    
    override func viewDidLoad() {
        
        print("success")
        view.subviews.forEach({ $0.removeFromSuperview() })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.subviews.forEach({ $0.removeFromSuperview() })
        self.view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

    }
    
    
}
