//
//  LoginRegistrationView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-06.
//

import SwiftUI

struct LoginRegistrationView: View {
    
    @State private var isShowingSignInView = true
    @Binding var isUserLoggedIn: Bool
    @State var showLoader: Bool = false
    
    var body: some View {
        ZStack{
            Color(hex: "#3F3D3D").ignoresSafeArea()
            
            VStack{
                WaveShape(reverse: $isShowingSignInView)
                    .fill(Color(hex: "#D9D9D9"))
                    .frame(height: 300)
                    .overlay {
                        ZStack{
                            Image(isShowingSignInView ? "coffee-1" : "coffee-2")
                                .resizable()
                                //.scaledToFill()
                                .clipShape(WaveShape(reverse: $isShowingSignInView))
                            Button("FirstView") {
                                isShowingSignInView.toggle()
                            }.opacity(isShowingSignInView ? 0 : 1)
                        }
                        
                    }
                    .shadow(color: .black, radius: 5)
                    .animation(.easeInOut, value: isShowingSignInView)
                   
                
                GeometryReader { geometry in
                    ZStack{
                        signInView
                            .frame(width: geometry.size.width)
                            .offset(x: self.isShowingSignInView ? 0 : -geometry.size.width)
                            .animation(.easeInOut, value: isShowingSignInView)
                        
                        
                        signUpView
                            .frame(width: geometry.size.width)
                            .offset(x: self.isShowingSignInView ? geometry.size.width : 0)
                            .animation(.easeInOut, value: isShowingSignInView)
                        
                    }
                }
                
                
            }.ignoresSafeArea()
            
            if showLoader{
                ZStack{
                    ProgressView().tint(.white)
                        
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.black.opacity(0.5))
            }
            
        }
    }
    
    var signInView: some View{
        SigInView(isUserLoggedIn: $isUserLoggedIn, showSignInView: $isShowingSignInView, showLoader: $showLoader)
    }
    
    var signUpView: some View{
        SignUpView(isUserLoggedIn: $isUserLoggedIn, showLoader: $showLoader)
    }
}

#Preview {
    LoginRegistrationView(isUserLoggedIn: .constant(false))
}


struct WaveShape: Shape {
    
    @Binding var reverse: Bool
    
    func path(in rect: CGRect) -> Path {
        
        let start_x = 0
        let start_y = 0
        let radius = rect.width / 2
        let y_0 = reverse ? -rect.width / (4 * sqrt(3)) : rect.width / (4 * sqrt(3))
        let const = abs(y_0)
       
        return Path { path in
            path.move(to: CGPoint(x: start_x, y: start_y))
            path.addLine(to: CGPoint(x: 0, y: rect.height - const))
            path.addArc(tangent1End: CGPoint(x: rect.width/4, y: rect.height + y_0 - const), tangent2End: CGPoint(x: rect.width/2, y: rect.height - const), radius: radius)
            path.addArc(tangent1End: CGPoint(x: 3 * rect.width * 0.25, y: rect.height - y_0 - const), tangent2End: CGPoint(x: rect.width, y: rect.height - const), radius: radius)
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y:0))
            path.closeSubpath()
        }
    }
}
