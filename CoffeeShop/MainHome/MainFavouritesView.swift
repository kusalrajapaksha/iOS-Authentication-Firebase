//
//  MainFavouritesView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-12.
//

import SwiftUI

struct MainFavouritesView: View {
    
    @State var showFavourites: Bool = true
    @StateObject var viewModel = MainHomeViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(hex: "3E3232"),Color(hex: "503C3C"),Color(hex: "7E6363"),Color(hex: "3E3232")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            if showFavourites{
                VStack{
                    Text("Favourites")
                        .foregroundStyle(.white)
                        .font(.custom(CustomFonts.RubikBold, size: 25))
                    Spacer().frame(height: 20)
                    
                    favouritesContainer
                }
            }else{
                VStack{
                    Image("sad-face")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color(hex:"F3CDA4"))
                        
                    Text("Oops, no favourites items to show")
                        .font(.custom(CustomFonts.RubikRegular, size: 20))
                        .foregroundStyle(Color(hex:"F3CDA4"))
                }
                
            }
            
        }
    }
    
    
    var favouritesContainer: some View {
        ScrollView(.vertical){
            VStack{
                ForEach(viewModel.popularCoffeItems, id: \.self){item in
                    FavouriteCardView(item: item)
                }
            }
           
        }
    }
}

#Preview {
    MainFavouritesView()
}
