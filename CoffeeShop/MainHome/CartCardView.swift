//
//  CartCardView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-20.
//

import SwiftUI

struct CartCardView: View {
    
    var item: CartItem
    
    var body: some View {
        ZStack{
            Color(hex: "F3CDA4")
                .cornerRadius(16)
                .shadow(color: Color(hex: "3E3232"), radius: 5, x:5, y:5)
                
            VStack{
                HStack{
    //                AsyncImage(url: URL(string: item.imageURL)) { image in
    //                    image
    //                        .image?.resizable()
    //                        .resizable()
    //                        .scaledToFill()
    //                        .frame(width: 118,height: 118)
    //                        .background(Color(hex: "f6c28b"))
    //                        .cornerRadius(16)
    //                        .padding(.leading,16)
    //                }
                    
                    Image("cup_placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 118,height: 118)
                        .background(Color(hex: "f6c28b"))
                        .cornerRadius(16)
                        .padding(.leading,16)
                        
                        
                    Spacer().frame(width: 16)
                    
                    VStack(alignment: .leading){
                        Text(item.item)
                            .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                            .font(.custom(CustomFonts.RubikSemiBold, size: 26))
                            .minimumScaleFactor(0.8)
                            .lineLimit(nil)
                            .foregroundColor(Color(hex: "3E3232"))
                        
                        
                        Text("With steamed milk")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom(CustomFonts.RubikRegular, size: 20))
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color(hex: "3E3232"))
                        
                       
                        
                       
                        Text("Medium Roasted")
                            .frame(alignment: .center)
                            .font(.custom(CustomFonts.RubikRegular, size: 20))
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color.white)
                            .padding(8)
                            .background(Color(hex: "3E3232"))
                            .cornerRadius(8)
                            
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding(.top, 16)
                
                listItemView
                    
                
            }
        
            
        }
        .frame(minHeight: 150,maxHeight: .infinity)
        .frame(width: .infinity)
        .padding()
    }
    
    var listItemView: some View {
        VStack(spacing: 12){
            ForEach(0..<3){index in
                HStack{
                    //-Size label
                    Text("S")
                        .frame(height: 32)
                        .padding(.horizontal,16)
                        .background(Color.black)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    //-Price label
                    Text("$ 4.20")
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "minus.square.fill")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .foregroundColor(Color(hex: "D17842"))
                    })
                    .padding(.trailing,8)
                    
                    Text("1")
                        .frame(height: 32)
                        .padding(.horizontal,16)
                        .background(Color.black)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "D17842"), lineWidth: 2)
                            )
                        .foregroundColor(Color.white)
                        
                    
                    Button(action: {}, label: {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .frame(width: 32,height: 32)
                            .foregroundColor(Color(hex: "D17842"))
                    })
                    .padding(.leading,8)
                }
            }
        }
        .padding(.horizontal,16)
        .padding(.bottom, 16)
        .font(.custom(CustomFonts.RubikRegular, size: 20))
    }
    
    //Support functions
    func getRoastType(index: Int){
//        if index == CoffeeRoastOption.RawValue{
//            
//        }
    }
}

#Preview {
    CartCardView(item: CartItem(item: "", size_and_Count: [1:1], roastOption: 2))
}

#Preview {
    MainEntryView()
}
