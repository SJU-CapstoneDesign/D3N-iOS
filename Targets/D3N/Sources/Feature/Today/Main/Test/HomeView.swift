//
//  SwiftUIView.swift
//  D3N
//
//  Created by Younghoon Ahn on 11/10/23.
//  Copyright © 2023 sju. All rights reserved.
//

import SwiftUI

import Foundation

struct TodayModel: Identifiable {
    let id = UUID().uuidString
    let appName: String
    let appDescription: String
    let appLogo: String
    let bannerTitle: String
    let platformTitle: String
    let artwork: String
    let appDetailDescription: String
}

extension View {
    func safeArea() -> UIEdgeInsets {
        guard
            let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
}

struct HomeView: View {
    @State private var currentItem: TodayModel?
    @State private var showDetailPage: Bool = false
    // Matched Geometry Effect
    @Namespace private var animation
    @State private var animateView: Bool = false
    @State private var animateContent: Bool = false
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 30) {
                headerView
                .padding(.horizontal)
                .padding(.bottom)
                .opacity(showDetailPage ? 0 : 1)
                cardListView
            }
            .padding(.vertical)
        }
        .overlay {
            if
                let currentItem = currentItem,
                showDetailPage {
                DetailView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.tertiarySystemBackground))
                .frame(height: animateView ? nil : 350, alignment: .top)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
}

let todayItems: [TodayModel] = [
    TodayModel(appName: "Figma", appDescription: "Design App", appLogo: "logo_1", bannerTitle: "Browse, view, play your designs anywhere", platformTitle: "Utilities", artwork: "post_1", appDetailDescription: """
               Keep your designs mobile with the Figma app.
               
               Bring your creations to life, wherever you are, for convenient and immersive viewing. Share, browse, and view your designs with just a few taps.
               
               With Figma’s mobile app, you can:
               
               - View, browse, and share files and prototypes
               - Navigate team and project folders
               - Favorite files for even faster access
               - Playback prototypes without being tethered to your desktop
               - Turn on hot spots in prototypes for easier navigation
               - Mirror selected frames from desktop onto your mobile device
               
               On iPad, you can also use the Figma app to:
               
               - Sketch with the Apple Pencil to explore and iterate on ideas more fluidly
               - Share and riff on early thinking with your team
               - Annotate designs to share feedback
               - Jot down ideas whenever inspiration strikes
               
               We’re excited to release more features soon!
               
               If you have any feedback you can report issues in-app from your account settings.
               """),
    TodayModel(appName: "Apple Developer", appDescription: "Developer App", appLogo: "logo_2", bannerTitle: "Developer app with Apple tools", platformTitle: "Developer Tools", artwork: "post_2", appDetailDescription: """
Welcome to Apple Developer, your source for developer stories, news, and educational information — and the best place to experience WWDC.
• Stay up to date on the latest technical and community information.
• Browse news, features, developer stories, and informative videos.
• Catch up on videos from past events and download them to watch offline.
Thank you for your feedback. New in this release:

• A new UI designed for macOS.
• Discover, which helps you catch up on the latest stories, news, videos, and more.
• WWDC, where you can find everything you’ll need for the conference.
• A new browse interface, where you can search for existing sessions, videos, articles, and news.
• The option to download and favorite content to read or watch later.
""")
]

extension HomeView {
    private var headerView: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 8) {
                Text("SATURDAY 26 NOVEMBER")
                    .font(.callout)
                    .foregroundColor(.gray)
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button {
                
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
            }
        }
    }
    
    struct ScaledButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label.scaleEffect(configuration.isPressed ? 0.95 : 1)
                .animation(.easeInOut, value: configuration.isPressed)
        }
    }
    
    struct CustomCorner: Shape {
        var corners: UIRectCorner
        var radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
    
    struct OffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    
    
    private var cardListView: some View {
        ForEach(todayItems) { item in
            Button {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7)) {
                    currentItem = item
                    showDetailPage = true
                }
            } label: {
                CardView(item: item)
                    .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
            }
            .buttonStyle(ScaledButtonStyle())
            .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
        }
    }
    
    @ViewBuilder
    private func CardView(item: TodayModel) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topLeading) {
                // Banner Image
                GeometryReader { proxy in
                    let size = proxy.size
                    Image(item.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 15))
                }
                .frame(height: 400)
                
                LinearGradient(colors: [
                    .black.opacity(0.5),
                    .black.opacity(0.2),
                    .clear
                ], startPoint: .top, endPoint: .bottom)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.platformTitle.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                    Text(item.bannerTitle)
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.primary)
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
            }
            HStack(spacing: 12) {
                Image(item.appLogo)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.platformTitle.uppercased())
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(item.appName)
                        .fontWeight(.bold)
                    Text(item.appDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    
                } label: {
                    Text("GET")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Capsule().fill(.ultraThinMaterial))
                }

            }
            .padding([.horizontal, .bottom])
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.tertiarySystemBackground))
        }
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    func DetailView(item: TodayModel) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item)
                    .scaleEffect(animateView ? 1 : 0.93)
                
                VStack(spacing: 15) {
                    Text(item.appDetailDescription)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)
                    Divider()
                    
                    Button {
                        
                    } label: {
                        Label {
                            Text("Share Story")
                        } icon: {
                            Image(systemName: "square.and.arrow.up.fill")
                        }
                        .foregroundColor(.primary)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(.ultraThinMaterial)
                        }
                    }
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0, anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { value in
                    scrollOffset = value
                }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .topTrailing) {
            Button {
                // Closing Views
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7).delay(0.05)) {
                    currentItem = nil
                    showDetailPage = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.primary)
            }
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        }
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7)) {
                animateView = true
            }
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7)) {
                animateContent = true
            }
        }
        .transition(.identity)
    }

}
