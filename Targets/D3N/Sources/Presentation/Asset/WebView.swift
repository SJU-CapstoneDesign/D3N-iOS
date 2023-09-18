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
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let request = URLRequest(url: url)
        
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        webView.load(request)

        return webView
    }
    
    func update(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        
    }
}
