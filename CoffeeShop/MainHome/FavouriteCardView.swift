//
//  FavouriteCardView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-18.
//

import SwiftUI

struct FavouriteCardView: View {
    
    var item: CoffeeItem
    
    var body: some View {
        ZStack{
            Color(hex: "F3CDA4")
                .cornerRadius(16)
                .shadow(color: Color(hex: "3E3232"), radius: 5, x:5, y:5)
        
            HStack{
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .image?.resizable()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 118,height: 118)
                        .background(Color(hex: "f6c28b"))
                        .cornerRadius(16)
                        .padding(.leading,16)
                }
                
//                Image("cup_placeholder")
                    
                    
                Spacer().frame(width: 16)
                
                VStack(alignment: .leading){
                    Text(item.name)
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                        .font(.custom(CustomFonts.RubikSemiBold, size: 26))
                        .minimumScaleFactor(0.8)
                        .lineLimit(nil)
                        .foregroundColor(Color(hex: "3E3232"))
                    
                    
                    Text(String(item.price) + " $")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(CustomFonts.RubikRegular, size: 20))
                        .minimumScaleFactor(0.7)
                        .foregroundColor(Color(hex: "3E3232"))
                    
                   
                    
                    Text("Brewing time - 10 min")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom(CustomFonts.RubikRegular, size: 16))
                        .minimumScaleFactor(0.7)
                        .foregroundColor(Color(hex: "3E3232").opacity(0.6))
                    
                   Spacer()
                    HStack{
                        Text("Ordered 2 times")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CustomFonts.RubikMedium, size: 20))
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color(hex: "3E3232").opacity(0.6))
                        
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .padding(.trailing, 16)
                            .foregroundColor(Color(hex: "3E3232"))
                            
                    }
                    
                        
                }
                .frame(maxWidth: .infinity, maxHeight: 128)
                
            }
        }
        .frame(width: .infinity, height: 150)
        .padding()
        
        
    }
}

#Preview {
    FavouriteCardView(item: CoffeeItem(name: "", description: "", price: 0, type: "", imageURL: ""))
}

