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
                UserProfileView()
            }
            
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack{
//                SigInView()
            }
        })
    }
}

#Preview {
    ContentView()
}
