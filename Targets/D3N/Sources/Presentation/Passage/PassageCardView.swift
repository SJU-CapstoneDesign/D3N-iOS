//
//  PassageCardView.swift
//  D3N
//
//  Created by 송영모 on 2023/09/18.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

public struct PassageCardView: View {
    public var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Text("철도파업 사흘째 열차 감축 운행 지속‥이용객 불편 이어져")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding()
            
            Text("전국철도노동조합 파업 사흘째인 오늘도 열차 감축 운행이 이어지는 가운데 운행률은 평소의 70% 수준에 머물고 있습니다.")
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
