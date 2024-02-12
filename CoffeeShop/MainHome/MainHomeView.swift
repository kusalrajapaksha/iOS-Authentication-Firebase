//
//  MainHomeView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-12.
//

import SwiftUI

struct MainHomeView: View {
    
    @State var searchText = ""
    @State var selectedType: CoffeeType = .all
    
    @StateObject var viewModel = MainHomeViewModel()
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color(hex: "3E3232"),Color(hex: "503C3C"),Color(hex: "7E6363"),Color(hex: "3E3232")], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                    Spacer()
                }.padding()
                
                Text("Explore the best coffee around you")
                    .padding(.horizontal)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                searchBar
                
                
                ScrollView{
                    VStack(alignment: .leading, content: {
                        coffeTypesBar
                        
                        Text("Popular")
                            .padding(.horizontal)
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        popularCoffeeCards

                        Text("New")
                            .padding(.horizontal)
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        newCoffeeCards
                    })
                    .padding(.bottom, 40)
                }
                
                Spacer()
            }
        }
    }
    
    var searchBar: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.5))
            HStack{
                Image(systemName: "magnifyingglass")
                    .padding(.horizontal)
                    .foregroundColor(.white)
                TextField("Find your coffee", text: $searchText)
                    .padding(.leading,0)
                    .padding(.trailing)
                    .foregroundColor(.white)
            }
            
        }.frame(height: 40)
        .padding(.horizontal)
    }
    
    var coffeTypesBar: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(CoffeeType.allCases, id: \.self){item in
                    Text(item.rawValue)
                        .font(.title3)
                        .foregroundStyle(selectedType == item ? Color.init(hex: "442400") : Color(hex: "#f6c28b"))
                        .padding(.horizontal)
                        .background(selectedType == item ? Color.init(hex: "FFE7CB") : Color.clear)
                        .cornerRadius(16)
                        .onTapGesture {
                            selectedType = item
                        }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
    
    var popularCoffeeCards: some View {
        
        ScrollView(.horizontal){
            HStack(spacing: 20){
                ForEach(viewModel.popularCoffeItems, id: \.self){item in
                    CoffeeCardView(item: item)                }
            }.padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
    
    var newCoffeeCards: some View {
        
        ScrollView(.horizontal){
            HStack(spacing: 20){
                ForEach(viewModel.newCoffeItems, id: \.self){item in
                    CoffeeCardView(item: item)            
                }
            }.padding(.horizontal)
        }
        .scrollIndicators(.hidden)
    }
    
}

#Preview {
    MainHomeView()
}
