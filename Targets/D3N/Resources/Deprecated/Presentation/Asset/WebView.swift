//
//  WebView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/18.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let webView: WKWebView = .init()
    let url: String
    
    init(url: String) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }
    
    func update(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
}
