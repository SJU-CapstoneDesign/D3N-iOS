//
//  OnboardingSignUpView.swift
//  D3N
//
//  Created by 송영모 on 10/26/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI
import AuthenticationServices

import ComposableArchitecture

public struct OnboardingSignUpView: View {
    let store: StoreOf<OnboardingSignUpStore>
    
    
    public init(store: StoreOf<OnboardingSignUpStore>) {
        self.store = store
    }
    
    @State private var rotateIn3D = false
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                
                VStack {
                    Text("""
                        권리와 의무의 주체가 될 수 있는 자격을 권리 능력이라 합니다. 사람은 태어나면서 저절로 권리 능력을 갖게 되고 생존하는 내내 보유합니다. 그리하여 사람은 재산에 대한 소유권의 주체가 되며 다른 사람에 대하여 채권을 누리기도 하고 채무를 지기도 합니다. 사람들의 결합체인 단체도 일정한 요건을 갖추면 법으로써 부여되는 권리 능력인 법인격을 취득할 수 있습니다. 단체 중에는 사람들이 일정한 목적을 갖고 결합한 조직체로서 구성원과 구별되어 독자적 실체로서 존재하며 운영기구를 두어 구성원의 가입과 탈퇴에 관계없이 존속하는 단체가 있습니다. 이를 사단이라 하며 사단이 갖춘 이러한 성질을 사단성이라 합니다.
                        사단의 구성원은 사원이라 하며 사단은 법인으로 등기되어야 법인격이 생기는데 법인격을 가진 사단을 사단 법인이라 부릅니다. 반면에 사단성을 갖추고도 법인으로 등기하지 않은 사단은 법인이 아닌 사단이라 합니다. 사람과 법인만이 권리 능력을 가지며 사람의 권리 능력과 법인격은 엄격히 구별됩니다. 그리하여 사단 법인이 자기 이름으로 진 빚은 사단이 가진 재산으로 갚아야 하는 것이지 사원 개인에게까지 책임이 미치지 않습니다.
                        회사도 사단의 성격을 갖는 법인이며 주식회사는 주주들로 구성되며 주주들은 보유한 주식의 비율만큼 회사에 대한 지분을 갖습니다. 그런데 2001년에 개정된 상법은 한 사람이 전액을 출자하여 일인 주주로 회사를 설립할 수 있도록 하였습니다. 사단성을 갖추지 못했다고 할 만한 형태의 법인을 인정한 것이며 여러 주주가 있던 회사가 주식의 상속, 매매, 양도 등으로 모든 주식이 한 사람의 소유로 되는 경우가 있습니다. 이런 일인 주식회사에서는 일인 주주가 회사의 대표 이사가 되는 사례가 많으며 이처럼 일인 주주가 회사를 대표하는 기관이 되면 경영의 주체가 개인인지 회사인지 모호해집니다.
                        구성원인 사람의 인격과 법인으로서의 법인격이 잘 분간되지 않는 경우에는 간혹 문제가 발생할 수 있습니다. 상법상 회사는 이사들로 이루어진 이사회만을 업무 집행의 의결 기관으로 두며 대표 이사는 이사 중 한 명으로 이사회에 서 선출되는 기관입니다. 이사의 선임과 이사의 보수는 주주 총회에서 결정하도록 되어 있습니다. 그러나 주주가 한 사람뿐이면 사실상 그의 뜻대로 될 뿐 이사회나 주주 총회의 기능은 퇴색하기 쉽습니다. 심한 경우에는 회사에서 발생한 이익이 대표 이사인 주주에게 귀속되고 회사 자체는 허울만 남는 일도 발생할 수 있습니다. 이처럼 회사의 운영이 주주 한 사람의 개인 사업과 다름없이 이루어지고 회사라는 이름과 형식은 장식에 지나지지 않는 경우에는 회사와 거래 관계에 있는 사람들이 재산상 피해를 입는 문제가 발생할 수 있습니다. 이때 특정한 거래 관계에 관련하여서만 예외적으로 회사의 법인격을 일시적으로 부인하고 회사와 주주를 동일시해야 한다는 법인격 부인론이 제기됩니다. 법률은 이에 대하여 명시적으로 규정하고 있지 않지만 법원은 권리 남용의 조항을 끌어들여 이를 받아들인다 회사가 일인 주주에게 완전히 지배되어 회사의 회계 주주 총회나 이사회 운영이 적법하게 작동하지 못하는데도 회사에만 책임을 묻는 것은 법인 제도가 남용되는 사례라고 보는 것이다.
                        """)
                        .font(.caption2)
                    
                    Text(
                        """
                        
                            윗글에서 설명한 주식회사에 대한 이해로 가장 적절한 것은 ?

                            ① 대표 이사는 주식회사를 대표하는 기관이다.
                            ② 일인 주식회사는 대표 이사가 법인격을 갖는다.
                            ③ 주식회사의 이사회에서 이사의 보수를 결정한다.
                            ④ 주식회사에서는 주주 총회가 업무 집행의 의결 기관이다.
                            ⑤ 여러 주주들이 모여 설립된 주식회사가 일인 주식회사로 바뀔 수 없다.
                        """
                    )
                    .font(.caption2)
                }
                .padding(.horizontal, 10)
                .foregroundStyle(Color(uiColor: .systemGray))
                
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(22)
                    .foregroundColor(.white)
                    .shadow(color: Color(uiColor: .systemGray5), radius: 20)
                    .rotation3DEffect(
                        .degrees(rotateIn3D ? 12 : -12),
                        axis: (x: rotateIn3D ? 90 : -45, y: rotateIn3D ? -45 : -90, z: 0)
                    )
                    .task {
                        withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                            rotateIn3D.toggle()
                        }
                    }
                
                Spacer()
                
                Text("매일 3개의 뉴스를 읽고 독해력을 기르세요.")
                    .font(.caption2)
                
                SignInWithAppleButton(onRequest: {_ in }, onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        print("Apple Login Successful")
                        switch authResults.credential{
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
                            // 계정 정보 가져오기
                            let UserIdentifier = appleIDCredential.user
                            let fullName = appleIDCredential.fullName
                            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
                            let email = appleIDCredential.email
                            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
                            let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
                            print("=======IdentityToken======")
                            print(IdentityToken!)
                            print("=======AuthorizationCode======")
                            print(AuthorizationCode!)
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        print("error")
                    }
                })
                .frame(height: 50, alignment: .center)
                .padding()
                .onTapGesture {
                    viewStore.send(.signInWithAppleButtonTapped)
                }
            }
        }
    }
}
