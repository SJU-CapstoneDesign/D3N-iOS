//
//  Opening.swift
//  D3N
//
//  Created by 송영모 on 12/5/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI
import GoogleMobileAds
import UIKit

public final class AppOpenAds: NSObject {
    let id: String
    var ad: GADAppOpenAd?
    
    var completion: (() -> Void)?
    
    public init(id: String) {
        self.id = id
        super.init()
        load()
    }
    
    private func load(){
        let request = GADRequest()
        
        GADAppOpenAd.load(
            withAdUnitID: id,
            request: request,
            completionHandler: { [self] ad, error in
                if let error = error {
                    print("Failed to load rewarded ad with error: \(error.localizedDescription)")
                    return
                }
                print("Rewarded ad loaded.")
                self.ad = ad
                self.show { }
            }
        )
    }
    
    public func show(completion: @escaping () -> Void){
        self.completion = completion
        
        if let ad = ad,
           let root = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController {
            ad.present(fromRootViewController: root)
            self.completion?()
        } else {
            print("Ad wasn't ready")
        }
    }
}

