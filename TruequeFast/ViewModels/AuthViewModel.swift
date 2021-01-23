//
//  AuthViewModel.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 21/01/21.
//

import Foundation

protocol AuthViewModel {
    var formIsValid: Bool { get }
}

struct AuthStructViewModel: AuthViewModel {
    var name: String?
    var surname: String?
    var email: String?
    var phone: String?
    var password: String?
    var process: AuthScreenStatus = .LOGIN_EMAIL
    
    var formIsValid: Bool {
        if (process == .LOGIN_EMAIL){
            return email?.isEmpty == false &&
                password?.isEmpty == false
        } else {
            return email?.isEmpty == false &&
                password?.isEmpty == false &&
                name?.isEmpty == false &&
                phone?.isEmpty == false &&
                surname?.isEmpty == false
        }
    }
}
