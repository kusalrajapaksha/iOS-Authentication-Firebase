//
//  AuthenticationManager.swift
//  CoffeeShop
//
//  Created by Kusal Rajapaksha on 2023-12-07.
//

import Foundation
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

struct AuthDataResultModel{
    let uid: String
    let email: String?
    let photoURL: String?
    
    init(user: User){
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
    }
}

@MainActor
final class AuthenticationManager{
    
    static let shared = AuthenticationManager()
    
    private init(){}
    
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        /* This  being done locally */
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    
    
}

//
//func signInGoogle() async throws{
//    guard let topVC = UIApplication.topViewController() else{
//        throw URLError(.cannotFindHost)
//    }
//    
//    let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
//
////        gidSignInResult.user
//    
//    guard let idToken: String = gidSignInResult.user.idToken?.tokenString else{
//        throw URLError(.badServerResponse)
//    }
//    
//    let accessToken: String = gidSignInResult.user.accessToken.tokenString
//    
//    let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                     accessToken: accessToken)
//    
//}
