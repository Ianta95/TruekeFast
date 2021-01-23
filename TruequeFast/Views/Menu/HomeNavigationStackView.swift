//
//  HomeNavigationStackView.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 12/01/21.
//

import UIKit
import Lottie

// MARK: - Procolo del HomeNavigationStackView
protocol HomeNavigationStackViewDelegate: class {
    func showSettings()
    func searchArticle()
}
// MARK: - HomeNavigationStackView
class HomeNavigationStackView: UIStackView {
    // MARK: - Componentes
    let settingsButton = UIButton(type: .system)
    let searchButton = UIButton(type: .system)
    let labelTitle: UILabel = {
        let label = UILabel()
        label.text = "Trueke Fast"
        label.textColor = .white
        return label
    }()
    
    // MARK: - Variables
    weak var delegate: HomeNavigationStackViewDelegate?
    
    // MARK: - Life Cycle
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.setImage(#imageLiteral(resourceName: "buttons/ic_search").withRenderingMode(.alwaysOriginal), for: .normal)
        settingsButton.setImage(#imageLiteral(resourceName: "buttons/ic_settings").withRenderingMode(.alwaysOriginal), for: .normal)
        adjustImage(button: searchButton)
        adjustImage(button: settingsButton)
        searchButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 20, bottom: 6, right: -20)
        settingsButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: -20, bottom: 6, right: 20)
        // Crea stack buttons
        [settingsButton, UIView(), labelTitle, UIView(), searchButton].forEach { view in
            addArrangedSubview(view)
        }
        distribution = .equalSpacing
        isLayoutMarginsRelativeArrangement = true
        // Prepara truekeIcon
        /*truekeIcon.animation = Animation.named("logo")
        truekeIcon.loopMode = .playOnce
        truekeIcon.play()*/
        // Activar Acciones
        settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
    }
    // Required
    required init(coder: NSCoder) {
        fatalError("init(coder:) no fue implementado en HomeNavigationStackView")
    }
    
    // MARK: - Acciones
    // Click settings
    @objc func handleSettings(){
        delegate?.showSettings()
    }
    // Click Search
    @objc func handleSearch(){
        delegate?.searchArticle()
    }
    
    // MARK: - Preparativos
    // Ajusta imagen
    private func adjustImage(button: UIButton) {
        button.imageView!.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    }
}
