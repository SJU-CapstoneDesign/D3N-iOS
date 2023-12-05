//
//  AppDelegate.swift
//  D3N
//
//  Created by 송영모 on 10/15/23.
//  Copyright © 2023 sju. All rights reserved.
//

import UIKit
import SwiftUI
import AppTrackingTransparency

import FirebaseCore
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
        
        } else {
            ATTrackingManager.requestTrackingAuthorization { status in
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            }
        }
        
        FirebaseApp.configure()

      return true
    }
}
