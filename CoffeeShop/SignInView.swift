//
//  SignInView.swift
//  CoffeeShop
//
//  Created by Kusal on 2024-02-06.
//

import SwiftUI

enum SignInError{
    case emailEmpty
    case emailIncorrect
    case passwordEmpty
    case passwordIncorrect
    case networkError
    case noError
}

@MainActor
final class SignInViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    @discardableResult
    func signInWithEmail() async -> (Bool, SignInError){
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return (false, .emailEmpty)
        }
        
        do {
            try await AuthenticationManager.shared.signInUser(email: email, password: password)
            print("KKK Success")
            return (true, .noError)
           
        } catch {
            print("KKK Error  \(error)")
            return (false, .networkError)
        }
    }
}

struct SigInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    @Environment(\.presentationMode) var presentSignInView
    @Binding var isUserLoggedIn: Bool
    @Binding var showSignInView: Bool
    @Binding var showLoader: Bool
    
    var body: some View {
        ZStack{
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
                    
                    Button(action: {
                        // Handle sign-in logic
                        Task{
                            showLoader = true
                            let (success,error) = await viewModel.signInWithEmail()
                            if success{
                                print("KKK sign in success")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                    isUserLoggedIn = AuthenticationManager.shared.getCurrentUser() != nil
                                    showLoader = false
                                })
                            }
                            showLoader = false
                            
                        }
                        
                        print("Sign In button tapped")
                    }) {
                        Text("Sign In")
                            .foregroundColor(Color(hex: "#3F3D3D"))
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#FFB800"))
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }

                    
                    Button(action: {
                        // Handle sign-in logic
                        print("Sign In button tapped")
                    }) {
                        Text("Forgot password?")
                            .foregroundColor(Color(hex: "#D9D9D9"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal)
                    }
                   
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
                            Text("Continue with Google")
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.9))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        
                    }
                    .padding(.top)
                    
                    Spacer().frame(height: 20)
                    
                    HStack{
                        Text("Not registered?")
                            .foregroundStyle(Color(hex: "#D9D9D9"))
                        Button("Sign Up") {
                            showSignInView.toggle()
                        }
                    }
                    
                    Spacer()
                }
                
            }
        }
        .frame(maxHeight: .infinity)
        
        
    }
}

#Preview {
    SigInView(isUserLoggedIn: .constant(false), showSignInView: .constant(false), showLoader: .constant(false))
}

//#Preview {
//    LoginRegistrationView()
//}
