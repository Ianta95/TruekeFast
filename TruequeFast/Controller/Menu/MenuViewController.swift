//
//  MenuViewController.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 12/01/21.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    // MARK: - Componentes
    private let topStack = HomeNavigationStackView()
    private let bottomStack = BottomControlsStackView()
    private let deckView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    
    // MARK: - Variables
    // Usuario
    private var user: User?
    private var topCardView: CardView?
    private var cardViews = [CardView]()
    private var viewModels = [CardViewModel]() {
        didSet {
            configureCards()
        }
    }
    
    
    // MARK: - Life Cycle
    // did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserLoggedIn()
    }
    
    // MARK: - API
    // Checar si esta loggead
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser == nil {
            print("El usuario no existe")
            presentLoginController()
        } else {
            print("Si existe el usuario, es \(Auth.auth().currentUser?.uid)")
            fetchCurrentUserAndCards()
        }
    }
    // Logout
    func logout(){
        do {
            try Auth.auth().signOut()
            presentLoginController()
        } catch {
            print("DEBUG: Error al intentar cerrar sesión")
        }
    }
    // Obten Usuario
    func fetchCurrentUserAndCards(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            if (user != nil) {
                self.user = user
                print("User es \(self.user!.data())")
            } else {
                self.logout()
            }
        }
    }
    // Checar Status
    func checkStatus(){
        switch self.user?.user_status {
        case .REGISTER_DATA:
            
            break
        default:
            break
        }
    }
    // Obten Articulo
    func fetchArticles(forCurrentUser user: User) {
        
    }
    // MARK: - Preparativos App
    // Configura UI
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        let background = UIImageView(image: #imageLiteral(resourceName: "ic_wallpaper").withRenderingMode(.alwaysOriginal))
        background.contentMode = .scaleAspectFill
        view.addSubview(background)
        background.fillSuperview()
        topStack.delegate = self
        bottomStack.delegate = self
        topStack.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        topStack.layer.cornerRadius = 10
        bottomStack.layer.cornerRadius = 10
        let stack = UIStackView(arrangedSubviews: [topStack, deckView, bottomStack])
        stack.axis = .vertical
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor ,right: view.rightAnchor)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stack.bringSubviewToFront(deckView )
    }
    // Configura Tarjetas
    func configureCards(){
        viewModels.forEach { (viewModel) in
            let cardView = CardView(viewModel: viewModel)
            cardView.delegate = self
            //cardViews.append(cardView)
            deckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        cardViews = deckView.subviews.map({ ($0 as? CardView)! })
        topCardView = cardViews.last
    }

}
// MARK: - HomeNavigationStackView Delegate
extension MenuViewController: HomeNavigationStackViewDelegate {
    func showSettings() {
        print("Click en settings")
    }
    
    func searchArticle() {
        print("Click en search")
    }
}
// MARK: - BottomControlsStackView Delegate
extension MenuViewController: BottomControlsStackViewDelegate {
    func handleProfile() {
        print("Click en profile")
    }
    
    func handleBoxMenu() {
        print("Click en Box Menu")
    }
    
    func handleTruekes() {
        print("Click en Truekes")
    }
}
// MARK: - CardViewDelegate
extension MenuViewController :CardViewDelegate {
    func cardView(_ view: CardView, showArticlesDetails article: Article) {
        
    }
    
    func cardView(_ view: CardView, didLikeArticle: Bool) {
        
    }
}
// MARK: - Auth Delegate
extension MenuViewController: AuthViewControllerDelegate {
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
// MARK: - Navegación
extension MenuViewController {
    // Presenta login
    func presentLoginController(){
        DispatchQueue.main.async {
            let controller = AuthViewController()
            controller.delegate = self
            controller.definesPresentationContext = true
            controller.providesPresentationContextTransitionStyle = true
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    // Login Backup
    /*self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
        loginViewController.providesPresentationContextTransitionStyle = true
        loginViewController.definesPresentationContext = true
        loginViewController.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(loginViewController, animated: true)
        UIView.transition(with: self.navigationController!.view, duration: 0.5, options: UIView.AnimationOptions.transitionCurlDown, animations: nil, completion: nil)*/
}

