//
//  File.swift
//  AthanTool
//
//  Created by Affan on 1/10/22.
//

import Foundation
import SwiftUI



class settingsViewVHC: UIHostingController<ContentView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
       }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder, rootView: ContentView())
    }
    
    
}
