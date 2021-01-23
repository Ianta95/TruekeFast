//
//  CardView.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 13/01/21.
//

import UIKit
import SDWebImage

// MARK: - Delegate
protocol CardViewDelegate: class {
    func cardView(_ view: CardView, showArticlesDetails article: Article)
    func cardView(_ view: CardView, didLikeArticle: Bool)
}
// MARK: - Clase
class CardView: UIView {
    // MARK: - Componentes
    // Fotos de articulo
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = #imageLiteral(resourceName: "default_profile")
        return img
    }()
    // Info Articulo
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.attributedText = viewModel.articleInfoText
        return label
    }()
    // Info Button
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "info_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleArtProfile), for: .touchUpInside)
        return button
    }()
    // Bar Stack View
    private lazy var barStackView = SegmentedBarView(numberOfSegments: viewModel.imageURLS.count)
    // Gradient background
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Variables
    // View model
    let viewModel: CardViewModel
    // Delegate
    weak var delegate: CardViewDelegate?
    
    // MARK: - Life Cycle
    // init
    init(viewModel: CardViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .white
        configureGestureRecognizers()
        imageView.sd_setImage(with: viewModel.imageUrl)
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(imageView)
        imageView.fillSuperview()
        configureBarStackView()
        configureGradientLayer()
        addSubview(infoLabel)
        infoLabel.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        addSubview(infoButton)
        infoButton.setDimensions(height: 40, width: 40)
        infoButton.centerY(inView: infoLabel)
        infoButton.anchor(right: rightAnchor, paddingRight: 16)
    }
    // required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) en CardView no pudo implementarse")
    }
    //layout Subviews
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    // MARK: - Acciones
    // Click Info
    @objc func handleArtProfile(){
        delegate?.cardView(self, showArticlesDetails: viewModel.article)
    }
    
    
    // MARK: - Preparativos
    // Configura gradient layer
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        layer.addSublayer(gradientLayer)
    }
    // Configura barstackView
    func configureBarStackView() {
        addSubview(barStackView)
        barStackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8, height: 4)
    }
}
// MARK: - Gestures
extension CardView {
    private func configureGestureRecognizers(){
        print("Inicia configure Gesture Recognizers")
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleChangePhoto))
        addGestureRecognizer(tap)
    }
    /*------> Actions <------*/
    // Pan gesture
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            superview?.subviews.forEach({ $0.layer.removeAllAnimations() })
            break
        case .changed:
            swipeCard(sender: sender)
            break
        case .ended:
            resetCardPosition(sender: sender)
        default:
            break
        }
    }
    // Cambiar foto
    @objc func handleChangePhoto(sender: UIPanGestureRecognizer) {
        let location = sender.location(in: nil).x
        let shouldShowNextPhoto = location > self.frame.width / 2
        if shouldShowNextPhoto {
            viewModel.showNextPhoto()
        } else {
            viewModel.showPreviousPhoto()
        }
        imageView.sd_setImage(with: viewModel.imageUrl)
        barStackView.setHighlighted(index: viewModel.index)
    }
    // MARK: - Otras funciones
    /*------> Otras funciones <------*/
    func swipeCard(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        let rotationTransform = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationTransform.translatedBy(x: translation.x, y: translation.y)
    }
    
    func resetCardPosition(sender: UIPanGestureRecognizer){
        let direction: SwipeDirection = sender.translation(in: nil).x > 100 ? .right : .left
        let shouldDismissCard = abs(sender.translation(in: nil).x) > 100
        UIView.animate(withDuration: 0.80, delay: 0,usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if shouldDismissCard {
                let xTranslation = CGFloat(direction.rawValue) * 1000
                let offScreenTransform = self.transform.translatedBy(x: xTranslation, y: 0)
                self.transform = offScreenTransform
                self.alpha = 0.3
            } else {
                self.transform = .identity
            }
        } completion: { complete in
            if shouldDismissCard {
                let didLike = direction == .right
                self.delegate?.cardView(self, didLikeArticle: didLike)
            }
        }

    }
    
}
