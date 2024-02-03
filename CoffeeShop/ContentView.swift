//
//  ContentView.swift
//  CoffeeShop
//
//  Created by Kusal Rajapaksha on 2023-12-07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                UserProfileView(showSignInView: $showSignInView)
            }
            
        }
        .onAppear(perform: {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        })
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack{
                SigInView()
            }
        })
    }
}

#Preview {
    ContentView()
}
