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
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack{
            Button(action: {
                Task{
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Log out")
            })
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    NavigationStack{
        UserProfileView(showSignInView: .constant(false))
    }
}
