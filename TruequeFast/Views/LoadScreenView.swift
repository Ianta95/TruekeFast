//
//  LoadScreenView.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 21/01/21.
//

import UIKit
import Lottie

class LoadScreenView: UIView {
    // Label de descripcion
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.text = "Cargando"
        return label
    }()
    // Imagen con efecto visual
    let visualEffectView = UIView()
    
    init(){
        super.init(frame: .zero)
        configureBlurView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Preparativos App
    // Configurar UI
    private func configureUI(){
        let animView = AnimationView(name: "carga")
        animView.setDimensions(height: 260, width: 260)
        animView.contentMode = .scaleAspectFit
        animView.loopMode = .loop
        //Animacion
        addSubview(animView)
        animView.centerYWithMultiplier(parent_view: self, attribute: .bottom, multiplier: 0.4)
        animView.centerX(inView: self)
        animView.play()
        //Texto info
        addSubview(infoLabel)
        infoLabel.centerX(inView: self)
        infoLabel.anchor(top: animView.bottomAnchor, paddingTop: 10)
    }
    
    // Configurar efecto borroso
    func configureBlurView(){
        print("Inicia configure blur view")
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        visualEffectView.backgroundColor = .black
        visualEffectView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 0.7
        }, completion: nil)
    }
    
    func dismissal(){
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}


