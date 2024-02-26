//
//  CoffeeDetailView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-21.
//

import SwiftUI

struct CoffeeDetailView: View {
    
    @State var bgColor = Color.black
    @State var isPresented: Bool = false
    @State var sizeDic: [String: Int] = ["S":0,"M":0,"L":0]
    @State var sizeList: [String] = ["S", "M", "L"]
    
    var item: CoffeeItem
    
    var body: some View {
        GeometryReader{geo in
            ZStack{
                VStack(alignment: .center){
                    Image("coffee-1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height * 0.65)
                        .overlay {
                            LinearGradient(colors: [bgColor.opacity(0),bgColor.opacity(0.1),bgColor.opacity(0.8)], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                        }
                    Spacer()
                }
                
                VStack{
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray.opacity(0.7))
                        .frame(width: geo.size.width, height: geo.size.height * 0.6)
                        .overlay {
                            ZStack{
                                VStack{
                                    Group{
                                        itemNameBar
                                        ratingBar
                                    }.padding(.horizontal)
                                    
                                    
                                    ScrollView{
                                        VStack{
                                            descriptionBar
                                            sizeBar
                                        }
                                        .padding()
                                       
                                    }
                                    .padding(.bottom, 50)
                                    .background(.black)
                                    .frame(maxHeight: .infinity)
                                    
                                    Spacer()
                                }
                                    
                                VStack{
                                    Spacer()
                                    priceBar
                                        .frame(height: 50)
                                        .padding()
                                        .background(Color.gray)
                                }
                                
                            }
                            .padding(.vertical)
                            
                        }
                }
            }
        }
        .ignoresSafeArea()
        .background(bgColor)
        
    }
    
    var itemNameBar: some View{
        HStack{
            VStack{
                Text(item.name)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .font(.custom(CustomFonts.RubikSemiBold, size: 26))
                    .minimumScaleFactor(0.8)
                    .lineLimit(nil)
                    .foregroundColor(Color.white)
                    
                
                Text("With " + item.extra)
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                    .font(.custom(CustomFonts.RubikRegular, size: 16))
                    .minimumScaleFactor(0.8)
                    .lineLimit(nil)
                    .foregroundColor(Color.white.opacity(0.8))
                   
            }
            
            HStack{
                VStack{
                    Image("coffee-beans")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20,height: 20)
                        
                    Text("Coffee")
                        .font(.custom(CustomFonts.RubikRegular, size: 10))
                        .minimumScaleFactor(0.8)
                        
                }
                .foregroundColor(Color.orange)
                .frame(width: 44,height: 44)
                .background(Color.init(hex: "141921"))
                .cornerRadius(8)
                
                Spacer()
                
                VStack{
                    Image("milk-bottle")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20,height: 20)
                        
                    Text("Milk")
                        .font(.custom(CustomFonts.RubikRegular, size: 10))
                        .minimumScaleFactor(0.8)
                        
                }
                .foregroundColor(Color.orange)
                .frame(width: 44,height: 44)
                .background(Color.init(hex: "141921"))
                .cornerRadius(8)
            }
            .frame(width: 100)
            
            
        }
    }
    
    var ratingBar: some View{
        HStack{
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 20,height: 20)
                .foregroundColor(.orange)
            
            Text("4.5")
                .font(.custom(CustomFonts.RubikRegular, size: 16))
                .foregroundColor(Color.white.opacity(0.7))
            
            Text("(6789)")
                .font(.custom(CustomFonts.RubikRegular, size: 16))
                .foregroundColor(Color.white.opacity(0.5))
            
            Spacer()
            
            Text("Medium Roasted")
                .frame(width: 100,height: 44)
                .font(.custom(CustomFonts.RubikRegular, size: 10))
                .background(Color.init(hex: "141921"))
                .foregroundColor(Color.white.opacity(0.7))
                .cornerRadius(8)
        }
    }
    
    var descriptionBar: some View{
        VStack{
            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CustomFonts.RubikMedium, size: 18))
                .foregroundColor(Color.white.opacity(0.7))
                .padding(.bottom,8)
            
            Text(item.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .font(.custom(CustomFonts.RubikRegular, size: 16))
                .foregroundColor(Color.white.opacity(0.7))
        }
        .padding(.bottom,16)
    }
    
    var sizeBar: some View{
        VStack{
            Text("Size")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(CustomFonts.RubikMedium, size: 18))
                .foregroundColor(Color.white.opacity(0.7))
                .padding(.bottom,8)
            
            ForEach(0..<3){index in
                let key = sizeList[index]
                VStack(spacing: 30) {
                    HStack{
                        //-Size label
                        Text(sizeList[index])
                            .frame(height: 44)
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "D17842"), lineWidth: 2)
                                )
                            .font(.custom(CustomFonts.RubikMedium, size: 20))
                            .foregroundColor(Color.white)
                        
                      
                        Text("$ 4.20 /cup")
                            .font(.custom(CustomFonts.RubikMedium, size: 12))
                            .foregroundColor(Color.white.opacity(0.8))
                        
                        Spacer()
                        
                        Button(action: {
                            decreaseCupCount(index: index)
                        }, label: {
                            Image(systemName: "minus.square.fill")
                                .resizable()
                                .frame(width: 44,height: 44)
                                .foregroundColor(Color(hex: "D17842"))
                        })
                        .padding(.trailing,8)
                        .disabled(sizeDic[sizeList[index]] == 0)
                        
                        Text("\(sizeDic[sizeList[index]] ?? 0)")
                            .frame(width: 44,height: 44)
                            .background(Color.black)
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(hex: "D17842"), lineWidth: 2)
                                )
                            .foregroundColor(Color.white)
                            
                        
                        Button(action: {
                            increaseCupCount(index: index)
                        }, label: {
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .frame(width: 44,height: 44)
                                .foregroundColor(Color(hex: "D17842"))
                        })
                        .padding(.leading,8)
                        .disabled(sizeDic[sizeList[index]] == 5)
                    }
                    .padding(.vertical,8)
                }
            }
            
            
            
        }
        .padding(.bottom,16)
    }
    
    
    
    var priceBar: some View{
        
        HStack(spacing: 24){
            VStack{
                Text("Price")
                    .font(.custom(CustomFonts.RubikMedium, size: 18))
                    .foregroundColor(Color.white.opacity(0.7))
                Text("$ 4.20")
                    .font(.custom(CustomFonts.RubikMedium, size: 18))
                    .foregroundColor(Color.orange)
            }
            
            Button(action: {}, label: {
                Text("Add to Cart")
                    .font(.custom(CustomFonts.RubikMedium, size: 20))
                    .foregroundColor(Color.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5),radius: 5,x: 2,y: 2)
            })
            
            
        }
    }
    
    
    //--Support functions
    func increaseCupCount(index: Int){
        //--this index is the size index of sizeDic
        let key = sizeList[index]
        guard let current = sizeDic[key] else { return  }
        
        if current < 5{
            sizeDic[key] = current + 1
        }else{
            print("Limit exceeded")
        }
    }
    
    func decreaseCupCount(index: Int){
        //--this index is the size index of sizeDic
        let key = sizeList[index]
        guard let current = sizeDic[key] else { return  }
        
        if current > 0{
            sizeDic[key] = current - 1
        }else{
            print("Limit exceeded")
        }
    }
    
}

#Preview {
    CoffeeDetailView(item: CoffeeItem(name: "", description: "", price: 34, type: "", imageURL: ""))
}
