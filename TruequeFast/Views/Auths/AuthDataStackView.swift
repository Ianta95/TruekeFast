//
//  AuthDataStackView.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 18/01/21.
//

import UIKit

// MARK: - Delegate
protocol AuthDataStackViewDelegate: class {
    func authFillData(loginWithData user: String, password: String)
    func authFillData(registerWithData user: AuthCredentials)
}
// MARK: - Clase
class AuthDataStackView: UIStackView {
    // MARK: - Componentes
    
    // MARK: - Variables
    let delegate: UITextFieldDelegate
    let idStackView: String
    var collection: [AuthDataItemsView] = []
    var placeholders: [String] = []
    
    // MARK: - App cicle
    init(dataViewModels: [AuthDataStackViewModel], width: CGFloat = 300, delegate: UITextFieldDelegate, idStackView: String) {
        self.delegate = delegate
        self.idStackView = idStackView
        super.init(frame: .zero)
        distribution = .fillEqually
        axis = .vertical
        setDimensions(height: CGFloat(dataViewModels.count * 50), width: width)
        spacing = 8
        for viewModel in dataViewModels {
            let authData = AuthDataItemsView(image: viewModel.image, placeholder: viewModel.placeholder, type: viewModel.type, secureEntry: viewModel.secureEntry, delegate: delegate, idStackView: idStackView)
            collection.append(authData)
            placeholders.append(viewModel.placeholder)
            addArrangedSubview(authData)
        }
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) fallo al implementarse en AuthDataStackView")
    }
    
    
    // MARK: - Helpers
    func resignResponder(){
        for item in collection {
            item.resignResponder()
        }
    }
    
    func getData() -> [String: String]{
        var dict: [String:String] = [:]
        for i in 0...(placeholders.count - 1) {
            dict.updateValue(collection[i].txtfield.text!, forKey: placeholders[i])
        }
        return dict
    }
    
    func setNextBecomerResponder(id: String) {
        var becomeF = false
        for item in collection {
            if (becomeF) {
                item.txtfield.becomeFirstResponder()
                becomeF = false
            }else if(id == item.txtfield.accessibilityIdentifier) {
                becomeF = true
            }
        }
    }
    
}
