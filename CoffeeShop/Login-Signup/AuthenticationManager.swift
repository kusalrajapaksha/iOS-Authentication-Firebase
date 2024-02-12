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

struct AuthDataResultModel: Codable{
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
    
    
    func getAuthenticatedUser() throws -> User{
        /* This  being done locally */
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return user
    }
    

    func createUser(email: String, password: String) async throws {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let authDataResultModel = AuthDataResultModel(user: authDataResult.user)
        
        /* Store current user data to user defaults*/
        storeCurrentUser(authdata: authDataResultModel)
        
    }
    
    func signInUser(email: String, password: String) async throws {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let authDataResultModel = AuthDataResultModel(user: authDataResult.user)
        
        /* Store current user data to user defaults*/
        storeCurrentUser(authdata: authDataResultModel)
    }
    
    func signOut() throws{
        try Auth.auth().signOut()
        removeCurrentUser()
    }
    
    func storeCurrentUser(authdata: AuthDataResultModel){
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(authdata)

            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "currentUserData")
            UserDefaults.standard.synchronize()

        } catch {
            print("Unable to Encode Note (\(error))")
        }
    }
    
    func removeCurrentUser(){
        UserDefaults.standard.removeObject(forKey: "currentUserData")
        UserDefaults.standard.synchronize()
    }
    
    func getCurrentUser() -> AuthDataResultModel? {
        if let data = UserDefaults.standard.data(forKey: "currentUserData") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()

                // Decode Note
                let userModel = try decoder.decode(AuthDataResultModel.self, from: data)
                return userModel
            } catch {
                print("Unable to Decode Note (\(error))")
                return nil
            }
        }else{
            return nil
        }
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
