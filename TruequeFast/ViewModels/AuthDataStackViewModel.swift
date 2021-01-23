//
//  AuthDataViewStackModel.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 20/01/21.
//

import UIKit

struct AuthDataStackViewModel {
    let image: UIImage
    let placeholder: String
    let type: UIKeyboardType
    let secureEntry: Bool
    
    init(image: UIImage, placeholder: String, type: UIKeyboardType, secureEntry: Bool){
        self.image = image
        self.placeholder = placeholder
        self.type = type
        self.secureEntry = secureEntry
    }
}
