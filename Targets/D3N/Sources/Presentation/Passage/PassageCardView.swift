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
        VStack (alignment: .trailing){
            Button(action: {}
                   , label:{
                Text("#\(news.field)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.systemIndigo))
            })
            .padding()
            //TODO: 카테고리별 모든 뉴스 화면과 연결하기
            VStack{
                Text(news.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.trailing, 30)
                    .padding(.bottom, 50)
                    .padding(.leading,10)
                Text(news.summary)
                    .padding(.trailing, 30)
                    .padding(.leading, 10)
                Spacer()
                //TODO: 아래에 넣을 추가 정보 혹은 디테일 구상
            }.padding(.top, 30)
        }
        .padding()
        .background(RoundedRectangle(
            cornerRadius: 25, style: .continuous
        )
            .fill(Color(.systemIndigo))
            .shadow(radius: 5, x: 5, y: 5)
            .opacity(0.2)
        )
    }
}
