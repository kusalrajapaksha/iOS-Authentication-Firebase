//
//  MainHomeViewModel.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-12.
//

import Foundation

enum CoffeeType: String, CaseIterable{
    case all = "All"
    case americano = "Americano" //AMRC
    case cappuccino = "Cappuccino" //CAPU
    case espresso = "Espresso" //ESPR
    case latte = "Latte" //LATTE
    case mocha = "Mocha" //MOCA
    case flatwhite = "Flat White" //FLWT
}

enum CoffeeRoastOption: Int, CaseIterable{
    case light = 1
    case medium = 2
    case dark = 3
    
    var roastOptionName: String {
        switch self {
        case .light:
            return "Light Rosted"
        case .medium:
            return "Medium Roasted"
        case .dark:
            return "Dark Roasted"
        }
    }
}



struct CoffeeItem: Identifiable, Hashable{
    let id = UUID().uuidString
    let name: String
    let description: String
    let price: Double
    let type: String
    let imageURL: String
    var extra: String = ""
}

struct CartItem:Identifiable, Hashable{
    let id = UUID().uuidString
    let item: String
    var size_and_Count: Dictionary<Int, Int> //1-small, 2-medium, 3-large
    var roastOption: Int
}

class MainHomeViewModel: ObservableObject {
    
    
    @Published var popularCoffeItems = [CoffeeItem(name: "Americano", description: "Lorem ipsum", price: 23, type: "CAPU", imageURL: "https://images.unsplash.com/photo-1587985782608-20062892559d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGFtZXJpY2Fub3xlbnwwfHwwfHx8MA%3D%3D"),
                                        CoffeeItem(name: "Cappuccino", description: "Lorem ipsum", price: 32, type: "AMRC", imageURL: "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Q2FwcHVjY2lub3xlbnwwfHwwfHx8MA%3D%3D", extra: "Steamed Milk"),
                             CoffeeItem(name: "Espresso", description: "Lorem ipsum", price: 15, type: "ESPR", imageURL: "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fEVzcHJlc3NvfGVufDB8fDB8fHww"),
                             CoffeeItem(name: "Latte", description: "Lorem ipsum", price: 12, type: "LATT", imageURL: "https://images.unsplash.com/photo-1593443320739-77f74939d0da?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8TGF0dGV8ZW58MHx8MHx8fDA%3D",extra: "Steamed Milk")]
    
    @Published var newCoffeItems = [CoffeeItem(name: "Cream Latte", description: "Lorem ipsum", price: 23, type: "LATT", imageURL: "https://images.unsplash.com/photo-1587985782608-20062892559d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGFtZXJpY2Fub3xlbnwwfHwwfHx8MA%3D%3D",extra: "Steamed Milk"),
                             CoffeeItem(name: "Cappuccino", description: "Lorem ipsum", price: 32, type: "AMRC", imageURL: "https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Q2FwcHVjY2lub3xlbnwwfHwwfHx8MA%3D%3D",extra: "Steamed Milk"),
                             CoffeeItem(name: "Espresso", description: "Lorem ipsum", price: 15, type: "ESPR", imageURL: "https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fEVzcHJlc3NvfGVufDB8fDB8fHww"),
                             CoffeeItem(name: "Latte", description: "Lorem ipsum", price: 12, type: "LATT", imageURL: "https://images.unsplash.com/photo-1593443320739-77f74939d0da?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8TGF0dGV8ZW58MHx8MHx8fDA%3D",extra: "Steamed Milk")]
    
    
    @Published var cartItems: [CartItem] = [
        CartItem(item: "Cappucinno", size_and_Count: [1:1, 2:2], roastOption: 2),
        CartItem(item: "Americano", size_and_Count: [2:2], roastOption: 2),
        CartItem(item: "Espresso", size_and_Count: [1:1, 3:2], roastOption: 2),
        CartItem(item: "Latte", size_and_Count: [1:1, 2:1, 3:3], roastOption: 2),
    ]
}

