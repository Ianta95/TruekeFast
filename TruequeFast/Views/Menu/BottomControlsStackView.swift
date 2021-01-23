//
//  BottomControlsStackView.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 13/01/21.
//

import UIKit
import Lottie
import SVGKit

// MARK: - Delegate
protocol BottomControlsStackViewDelegate: class {
    func handleProfile()
    func handleBoxMenu()
    func handleTruekes()
}
// MARK: - Clase
class BottomControlsStackView: UIStackView {
    // MARK: - Componentes
    let profileButton = UIButton(type: .system)
    let menuBoxButton = UIButton(type: .system)
    let truekesButton = UIButton(type: .system)
    // MARK: - Variables
    weak var delegate: BottomControlsStackViewDelegate?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        //clipsToBounds = true
        distribution = .fillEqually
        profileButton.setImage(#imageLiteral(resourceName: "buttons/ic_user").withRenderingMode(.alwaysOriginal), for: .normal)
        truekesButton.setImage(#imageLiteral(resourceName: "buttons/ic_replace").withRenderingMode(.alwaysOriginal), for: .normal)
        menuBoxButton.setImage(#imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal), for: .normal)
        profileButton.tintColor = .black
        truekesButton.tintColor = .black
        // Prepara truekeIcon
        let svg = Bundle.main.url(forResource: "logo", withExtension: "svg")
        // configura Botones
        adjustImage(button: profileButton)
        adjustImage(button: truekesButton)
        adjustImage(button: menuBoxButton)
        profileButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: -16, bottom: 4, right: 16)
        truekesButton.imageEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: -16)
        menuBoxButton.imageEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0)
        profileButton.addTarget(self, action: #selector(handleProfile), for: .touchUpInside)
        truekesButton.addTarget(self, action: #selector(handleTruekes), for: .touchUpInside)
        menuBoxButton.addTarget(self, action: #selector(handleBox), for: .touchUpInside)
        var buttons = [profileButton, menuBoxButton, truekesButton].forEach { view in
            addArrangedSubview(view)
        }
        layoutMargins = .init(top: 6, left: 0, bottom: 6, right: 0)
    }
    // required
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Acciones
    // Click en profile
    @objc func handleProfile() {
        delegate?.handleProfile()
    }
    // Click en Box Button
    @objc func handleBox() {
        delegate?.handleBoxMenu()
    }
    // Click en trueke
    @objc func handleTruekes(){
        delegate?.handleTruekes()
    }
    
    // MARK: - Preparativos
    // Ajusta imagen
    private func adjustImage(button: UIButton) {
        button.imageView!.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    }
}
