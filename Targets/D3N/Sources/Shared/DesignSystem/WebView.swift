//
//  WebView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/18.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    let webView: WKWebView = .init()
    let url: String
    
    public init(url: String) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }
    
    public func update(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    public func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
}
