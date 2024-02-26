//
//  CoffeeCardView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-12.
//

import SwiftUI

struct CoffeeCardView: View {
    
    var item: CoffeeItem
    
    @State var isDetailViewPresented: Bool = false
    @State var showDetailView: Bool = false
    
    var body: some View {
        ZStack{
            Color(hex: "f6c28b").opacity(0.4)
            VStack{
                AsyncImage(url: URL(string: item.imageURL)) { image in
                    image
                        .image?.resizable()
                        .scaledToFill()
                        .frame(width: 200,height: 200)
                        .clipped()
                        .padding(0)
                        .cornerRadius(16)
                }
                HStack{
                    VStack{
                        Text(item.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(Color(hex: "F3CDA4"))
                            .bold()
                            .font(.title2)
                            .minimumScaleFactor(0.7)
                        
                        Text(String(item.price) + "$")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(Color(hex: "F3CDA4"))
                            .font(.footnote)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 24,height:24)
                        .padding(.trailing)
                        .foregroundColor(Color.orange)
                        
                }
        
                Spacer()
            }
        }
        .frame(width: 200, height: 260)
        .cornerRadius(16)
        .shadow(radius: 5, x:2, y:2)
        .onTapGesture {
            showDetailView.toggle()
        }
        .fullScreenCover(isPresented: $showDetailView, content: {
            CoffeeDetailView(item: item)
        })

    }
}

#Preview {
    CoffeeCardView(item: CoffeeItem(name: "", description: "", price: 0, type: "", imageURL: ""))
}
