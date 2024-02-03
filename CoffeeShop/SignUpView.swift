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
    
    func signUpWithEmail() {
        guard !email.isEmpty, !password.isEmpty, password.elementsEqual(passwordConfirmation) else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.createUser(email: email, password: password)
                print("KKK Sign up new user is success")
               
            } catch {
                print("KKK Sign up new user is failed error  \(error)")
            }
        }
        
    }
}

struct SignUpView: View {
   
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        NavigationView {
                    VStack {
                        Spacer()

                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.green)

                        Text("Sign Up")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()

                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)

                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)

                        SecureField("Confirm Password", text: $viewModel.passwordConfirmation)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.horizontal)

                        Button(action: {
                            // Handle sign-up logic
                            viewModel.signUpWithEmail()
                            print("Sign Up button tapped")
                        }) {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(8)
                                .padding(.horizontal)
                        }
                        .padding(.top)
                        
                        Divider()
                        
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
                        
                        Button(action: {
                            // Handle sign-in logic
                            print("Sign In button tapped")
                        }) {
                            HStack{
                                Image("apple")
                                    .renderingMode(.template)
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.white)
                                    .frame(width: 30)
                                Text("Continue with Apple")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.9))
                            .cornerRadius(30)
                            .padding(.horizontal)
                            
                        }
                        

                        Spacer()

//                        NavigationLink(destination: SigInView()) {
//                            Text("Already have an account? Sign In")
//                                .foregroundColor(.green)
//                                .padding(.bottom)
//                        }
                    }
                    .padding()
                    .navigationBarTitle("Create Account", displayMode: .inline)
                }
    }
}

#Preview {
    SignUpView()
}
