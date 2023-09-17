//
//  NewsResponseDTO.swift
//  D3N
//
//  Created by 송영모 on 2023/09/15.
//  Copyright © 2023 sju. All rights reserved.
//

import Foundation

public struct NewsResponseDTO {
    public var title: String
    public var content: String
    
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
