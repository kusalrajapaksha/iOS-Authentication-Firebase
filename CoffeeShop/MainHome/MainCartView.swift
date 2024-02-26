//
//  MainCartView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-12.
//

import SwiftUI

struct MainCartView: View {
    
    @StateObject var viewModel = MainHomeViewModel()
    
    var body: some View {
        ZStack{
            
            LinearGradient(colors: [Color(hex: "3E3232"),Color(hex: "503C3C"),Color(hex: "7E6363"),Color(hex: "3E3232")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack{
                Text("Cart")
                    .foregroundStyle(.white)
                    .font(.custom(CustomFonts.RubikBold, size: 25))
                Spacer().frame(height: 20)
                
                cartItemsContainer
            }
            
            
        }
    }
    
    var cartItemsContainer: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(viewModel.cartItems, id: \.self){cartItem in
                    CartCardView(item: cartItem)
                }
            }
           
        }
    }
}

#Preview {
    MainCartView()
}


#Preview {
    MainEntryView()
}
