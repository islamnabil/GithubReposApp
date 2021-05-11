//
//  SwiftSpinner.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 10/05/2021.
//

import Foundation
import SwiftSpinner

class PrivateSwiftSpinner {
    // MARK: - Singleton
    private init(){}
    
    // Access the singleton instance
    static var shared = PrivateSwiftSpinner()
    
    /// Show the loading spinner
    ///
    /// - Parameters:
    ///   - title: The title shown under the spinner (by default = "Loading")
    func show(title:String = "Loading") {
        SwiftSpinner.show(title)
    }

    
    /// Hide the spinner
    func hide() {
        SwiftSpinner.hide()
    }
}
