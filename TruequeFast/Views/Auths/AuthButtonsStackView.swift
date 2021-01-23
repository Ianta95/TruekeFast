//
//  AuthButtons.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 15/01/21.
//

import UIKit

// MARK: - Delegate
protocol AuthButtonsStackViewDelegate: class {
    func handleEmail()
    func handlePhone()
    func handleGoogle()
    func handleFacebook()
}
// MARK: - Class
class AuthButtonsStackView: UIStackView {
    // MARK: - Componentes
    // Boton Facebook
    private let btnEmail: UIButton = {
        let btn = UIButton()
        //"auth/ic_email
        btn.setImage(#imageLiteral(resourceName: "auth/ic_email").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    // Boton Google
    private let btnPhone: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "auth/ic_phone").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    // Boton Facebook
    private let btnGoogle: UIButton = {
        let btn = UIButton()
        //"auth/ic_email
        btn.setImage(#imageLiteral(resourceName: "auth/ic_google").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    // Boton Google
    private let btnFaceBook: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "auth/ic_facebook").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    // MARK: - Variables
    weak var delegate: AuthButtonsStackViewDelegate?
    
    init(){
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalToConstant: 92).isActive = true
        distribution = .fillProportionally
        // configura Botones
        //adjustImage(button: btnEmail)
        //adjustImage(button: btnPhone)
        adjustImage(button: btnGoogle)
        adjustImage(button: btnFaceBook)
        //btnEmail.addTarget(self, action: #selector(handleEmail), for: .touchUpInside)
        //btnPhone.addTarget(self, action: #selector(handlePhone), for: .touchUpInside)
        btnGoogle.addTarget(self, action: #selector(handleGoogle), for: .touchUpInside)
        btnFaceBook.addTarget(self, action: #selector(handleFacebook), for: .touchUpInside)
        var buttons = [btnGoogle, btnFaceBook].forEach { view in
            addArrangedSubview(view)
        }
        //layoutMargins = .init(top: 6, left: 0, bottom: 6, right: 0)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    // Email
    @objc func handleEmail(){
        delegate?.handleEmail()
    }
    // Phone
    @objc func handlePhone(){
        delegate?.handlePhone()
    }
    // Google
    @objc func handleGoogle(){
        delegate?.handleGoogle()
    }
    // Facebook
    @objc func handleFacebook(){
        delegate?.handleFacebook()
    }
    
    // MARK: - Preparativos
    // Ajusta imagen
    private func adjustImage(button: UIButton) {
        button.imageView!.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    }
    
    
}

