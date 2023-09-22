//
//  PassageCardView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/18.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct PassageCardView: View {
    //TODO: NewsEntity는 이후에 Passage로 통일 되어야 함.
    public let news: NewsEntity
    
    public init(news: NewsEntity) {
        self.news = news
    }
    
    public var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text(news.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding()
            
            Text(news.summary)
                .padding()
            
            Spacer()
        }
        .background(.pink)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24,
                style: .continuous
            )
        )
    }
}
