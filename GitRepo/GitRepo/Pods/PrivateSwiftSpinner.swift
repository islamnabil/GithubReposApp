//
//  SwiftSpinner.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import Foundation
import SwiftSpinner

class PrivateSwiftSpinner {
    private init(){}
    static var shared = PrivateSwiftSpinner()
    
    func show(title:String = "Github Repo") {
        SwiftSpinner.show(title)
    }
    
    func hide() {
        SwiftSpinner.hide()
    }
}
