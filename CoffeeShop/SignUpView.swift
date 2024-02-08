//
//  SignUpView.swift
//  CoffeeShop
//
//  Created by Kusal Rajapaksha on 2023-12-07.
//

import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var passwordConfirmation = ""

    
    func signUpWithEmail() async -> Bool {
        guard !email.isEmpty, !password.isEmpty, password.elementsEqual(passwordConfirmation) else {
            print("No email or password found")
            return false
        }
        
        do {
            try await AuthenticationManager.shared.createUser(email: email, password: password)
            print("KKK Sign up new user is success")
            return true
           
        } catch {
            print("KKK Sign up new user is failed error  \(error)")
            return false
        }
        
    }
}

struct SignUpView: View {
   
    @StateObject private var viewModel = SignUpViewModel()
    @Binding var isUserLoggedIn: Bool
    @Environment(\.presentationMode) var presentSignInView
    @Binding var showLoader: Bool
    
    var body: some View {
        ScrollView{
            VStack {
                Spacer().frame(height: 40)

                TextField("Email", text: $viewModel.email)
                    .padding(10)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                Spacer().frame(height: 20)

                SecureField("Password", text: $viewModel.password)
                    .padding(10)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(20)
                    .padding(.horizontal)
                
                Spacer().frame(height: 20)

                SecureField("Confirm Password", text: $viewModel.passwordConfirmation)
                    .padding(10)
                    .background(Color(hex: "#D9D9D9"))
                    .cornerRadius(20)
                    .padding(.horizontal)

                Button(action: {
                    // Handle sign-up logic
                    Task{
                        showLoader = true
                        let success = await viewModel.signUpWithEmail()
                        if success{
                            print("KKK sign up success")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                isUserLoggedIn = AuthenticationManager.shared.getCurrentUser() != nil
                                showLoader = false
                            })
                        }
                        showLoader = false
                    }
                    
                }) {
                    Text("Sign Up")
                        .foregroundColor(Color(hex: "#3F3D3D"))
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#FFB800"))
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                Divider().background(.white).padding()
                
                Text("or")
                    .foregroundColor(Color(hex: "#D9D9D9"))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Button(action: {
                    // Handle sign-in logic
                    print("Sign In button tapped")
                }) {
                    HStack{
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("Register with Google")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.9))
                    .cornerRadius(30)
                    .padding(.horizontal)
                    
                }
                .padding(.top)
                

                Spacer()

            }
            .padding()
        }
        
    }
}

#Preview {
    SignUpView(isUserLoggedIn: .constant(false), showLoader: .constant(false))
}

//#Preview {
//    LoginRegistrationView()
//}
