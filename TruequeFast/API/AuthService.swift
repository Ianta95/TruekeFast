//
//  AuthCredentials.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 12/01/21.
//

import Foundation
import UIKit
import Firebase


struct AuthCredentials {
    let email: String
    let password: String
    let name: String
    let surname: String
    let phone: String

}

// MARK: - Servicios de Authenticación
struct AuthService {
    // MARK: - Servicio de Login (Email, contraseña)
    static func loginUser(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    // MARK: - Servicio Registro Usuarios
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping((Error?) -> Void)) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                print("Error al registrar usuario")
            }
            guard let uid = result?.user.uid else { return }
            let user = User(name: credentials.name, surname: credentials.surname, email: credentials.email, phone: credentials.phone, uid: uid)
            Service.saveUserData(user: user, completion: completion)
        }
    }
    
    
}
