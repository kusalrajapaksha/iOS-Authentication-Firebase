//
//  SigInView.swift
//  CoffeeShop
//
//  Created by Kusal Rajapaksha on 2023-12-07.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signInWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.signInUser(email: email, password: password)
                print("KKK Success")
            } catch {
                print("KKK Error  \(error)")
            }
        }
        
    }
}

struct SigInView: View {
    
    @StateObject private var viewModel = SignInViewModel()
    @Environment(\.presentationMode) var presentSignInView
    @Binding var isUserLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                Text("Sign In")
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

                Button(action: {
                    // Handle sign-in logic
                    viewModel.signInWithEmail()
                    isUserLoggedIn = AuthenticationManager.shared.getCurrentUser() != nil
                    presentSignInView.wrappedValue.dismiss()
                    print("Sign In button tapped")
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top)
                
                Button(action: {
                    // Handle sign-in logic
                    print("Sign In button tapped")
                }) {
                    Text("Forgot password?")
                        .foregroundColor(.purple)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
               
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

                NavigationLink(destination: SignUpView()) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                        .padding(.bottom)
                }
            }
            .padding()
        }
    }
}

#Preview {
    SigInView(isUserLoggedIn: .constant(false))
}
