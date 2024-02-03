//
//  UserProfileView.swift
//  CoffeeShop
//
//  Created by Kusal Rajapaksha on 2023-12-07.
//

import SwiftUI

@MainActor
final class UserProfileViewModel: ObservableObject{
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct UserProfileView: View {
    
    @StateObject private var viewModel = UserProfileViewModel()
    @State var isUserLoggedIn: Bool = false
    
    var body: some View {
        ZStack{
            
            VStack{
                Text(isUserLoggedIn ? "Hello this is your profile" : "Please log in to your account")
                
                if isUserLoggedIn{
                    Button(action: {
                        Task{
                            do {
                                try viewModel.signOut()
                            } catch {
                                print(error)
                            }
                        }
                    }, label: {
                        Text("Log out")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    })
                }else{
                    NavigationLink(destination: SigInView( isUserLoggedIn: $isUserLoggedIn)){
                        Text("Sign in")
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                
                }
            }
            
        }
        .navigationTitle("Profile")
        .task {
            let currentUser = AuthenticationManager.shared.getCurrentUser()
            print("KKK current user: \(String(describing: currentUser))")
            isUserLoggedIn = currentUser != nil
        }
    }
}

#Preview {
    NavigationStack{
        UserProfileView()
    }
}
