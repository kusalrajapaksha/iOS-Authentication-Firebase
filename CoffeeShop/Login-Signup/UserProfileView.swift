//
//  UserProfileView.swift
//  CoffeeShop
//
//  Created by Kusal Rajapaksha on 2023-12-07.
//

import SwiftUI

@MainActor
final class UserProfileViewModel: ObservableObject{
    
    @Published var currentUser: AuthDataResultModel? = nil
    @Published var isUserLogedIn: Bool = false
    
    init() {
        currentUser =  AuthenticationManager.shared.getCurrentUser()
        isUserLogedIn = (currentUser != nil)
    }
    
    
    func signOut() async -> Bool{
        do {
            try AuthenticationManager.shared.signOut()
            return true
        }catch{
            print(error)
            return false
        }
    }
    
    
}

struct UserProfileView: View {
    
    @StateObject private var viewModel = UserProfileViewModel()
    @Environment(\.presentationMode) var showLoginRegisterView
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Text(viewModel.isUserLogedIn ? "Hello this is your profile" : "Please log in to your account")
                    
                    if !viewModel.isUserLogedIn{
                        NavigationLink(destination:                     LoginRegistrationView(isUserLoggedIn: $viewModel.isUserLogedIn)){
                            Text("Login or Register")
                                .foregroundStyle(.white)
                                .padding()
                                .background(.red)
                                .cornerRadius(10)
                        }
              
                    }else{
                        Button("LogOut") {
                            Task{
                                let signOutSuccess = await viewModel.signOut()
                                viewModel.isUserLogedIn = !signOutSuccess
                            }
                        }
                    }
                    
                }
                
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Profile")
        .onChange(of: viewModel.isUserLogedIn) { newValue in
            if newValue == true{
                showLoginRegisterView.wrappedValue.dismiss()
            }
        }
        
    }
}

#Preview {
    UserProfileView()
}
