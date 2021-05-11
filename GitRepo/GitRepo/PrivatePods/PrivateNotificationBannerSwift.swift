//
//  PrivateNotificationBannerSwift.swift
//  GitRepo
//
//  Created by Islam Elgaafary on 11/05/2021.
//

import Foundation
import NotificationBannerSwift

class PrivateNotificationBannerSwift {
    // MARK: - Singleton
    private init(){}
    
    // Access the singleton instance
    static var shared = PrivateNotificationBannerSwift()
    
    /// Show the loading spinner
    ///
    /// - Parameters:
    ///   - title: The title shown under the spinner
    ///   - subtitle: The title shown under the spinner
    ///   - style: The style of notification
    func show(title:String, subtitle:String, style:BannerStyle) {
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.show()
    }
    
}
