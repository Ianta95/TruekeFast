//
//  AuthDataItemsview.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 18/01/21.
//

import UIKit

class AuthDataItemsView: UIView {
    // MARK: - Componentes
    // Image
    let image: UIImage
    // Image View
    lazy var imgView: UIImageView = {
        let imgV = UIImageView(image: self.image)
        // UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        imgV.backgroundColor = .white
        imgV.layer.cornerRadius = 10
        return imgV
    }()
    // Placeholder
    let placeholder: String
    let secureEntry: Bool
    let type: UIKeyboardType
    let delegate: UITextFieldDelegate
    // Textfield
    lazy var txtfield: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = .white
        txt.layer.cornerRadius = 10
        txt.isSecureTextEntry = self.secureEntry
        txt.keyboardType = self.type
        txt.delegate = delegate
        txt.attributedPlaceholder = NSAttributedString(string: "Escribe tu \(self.placeholder)",
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        txt.setLeftPaddingPoints(16)
        txt.textColor = .black
        return txt
    }()
    
    // MARK: - Init
    // Init
    init(image: UIImage, placeholder: String, type: UIKeyboardType = .default, secureEntry: Bool = false, delegate: UITextFieldDelegate) {
        self.image = image
        self.placeholder = placeholder
        self.secureEntry = secureEntry
        self.type = type
        self.delegate = delegate
        super.init(frame: .zero)
        clipsToBounds = true
        // Agrega image view
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        addSubview(imgView)
        imgView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingLeft: 0)
        // Agrega textfield
        addSubview(txtfield)
        txtfield.anchor(top: topAnchor, left: imgView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10)
    }
    // Required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) no se pudo implementar en AuthDataItemsView")
    }
    
    override func layoutSubviews() {
        imgView.setDimensions(height: self.frame.height, width: self.frame.height)
        
    }
    
    func resignResponder(){
        self.txtfield.resignFirstResponder()
    }
    
    
    
}
