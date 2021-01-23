//
//  AuthViewController.swift
//  TruequeFast
//
//  Created by Jesus Barragan  on 14/01/21.
//

import UIKit

// MARK: - Delegate
protocol AuthViewControllerDelegate: class {
    func authenticationComplete()
}
// MARK: - Clase
class AuthViewController: UIViewController {
    // MARK: - Componentes
    // Logo
    private let imageLogo: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysOriginal)
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    // Label
    private let lblInfoAuth: UILabel = {
        let lbl = UILabel()
        let attributedText = NSMutableAttributedString(string: "Inicia sesión", attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy), .foregroundColor: UIColor.white])
        lbl.attributedText = attributedText
        return lbl
    }()
    // Login email View
    private var loginView: AuthDataStackView?
    // Register View
    private var registerView: AuthDataStackView?
    // Boton de aceptar
    private var enterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(handleEnter), for: .touchUpInside)
        btn.setTitleColor(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), for: .normal)
        btn.setTitle("Entrar", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return btn
    }()
    // Boton ir a registro
    private var goRegisterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handleTextClick), for: .touchUpInside)
        btn.setTitle("Ya tengo cuenta", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        btn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        return btn
    }()
    // Buttons Stack
    private let btnStacks = AuthButtonsStackView()
    
    // MARK: - Variables
    weak var delegate: AuthViewControllerDelegate?
    private var menuShowed: AuthScreenStatus = .LOGIN_EMAIL
    private var allowAnimate: Bool = true
    private var logoTransform: CGAffineTransform?
    private var viewModel = AuthStructViewModel()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Preparativos APP
    // UI
    private func configureUI(){
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        // Add image Logo
        view.addSubview(imageLogo)
        imageLogo.centerYWithMultiplier(parent_view: view, attribute: .bottom, multiplier: 0.26)
        imageLogo.setDimensions(height: self.view.frame.width * 0.8, width: self.view.frame.width * 0.8)
        imageLogo.centerX(inView: view)
        self.logoTransform = imageLogo.transform.scaledBy(x: 0.6, y: 0.6)
        // Keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Add btn enter
        view.addSubview(enterButton)
        enterButton.centerX(inView: view)
        enterButton.setDimensions(height: 50, width: self.view.frame.width * 0.8)
        enterButton.anchor(bottom: view.bottomAnchor, paddingBottom: 20)
        // Buttons Stack
        view.addSubview(btnStacks)
        btnStacks.anchor(left: enterButton.leftAnchor, bottom: enterButton.topAnchor, paddingLeft: 0, paddingBottom: 6)
        // Add register button
        view.addSubview(goRegisterButton)
        goRegisterButton.centerY(inView: btnStacks)
        goRegisterButton.anchor(left: btnStacks.rightAnchor, paddingLeft: 10)
        // Login view
        loginView = AuthDataStackView(dataViewModels: [
            AuthDataStackViewModel(image: #imageLiteral(resourceName: "auth/ic_white_email").withRenderingMode(.alwaysOriginal), placeholder: "email",
                                   type: .emailAddress, secureEntry: false),
            AuthDataStackViewModel(image:  #imageLiteral(resourceName: "auth/ic_white_password").withRenderingMode(.alwaysOriginal), placeholder: "contraseña",
                                   type: .default, secureEntry: true)
        ], width: view.frame.width * 0.9, delegate: self, idStackView: "login")
        view.addSubview(loginView!)
        loginView!.centerX(inView: view)
        loginView!.anchor(bottom: btnStacks.topAnchor, paddingBottom: 30)
        // Register view
        registerView = AuthDataStackView(dataViewModels: [
            AuthDataStackViewModel(image: #imageLiteral(resourceName: "auth/ic_white_user").withRenderingMode(.alwaysOriginal), placeholder: "nombre", type: .namePhonePad, secureEntry: false),
            AuthDataStackViewModel(image: #imageLiteral(resourceName: "auth/ic_white_user").withRenderingMode(.alwaysOriginal), placeholder: "apellido(s)", type: .namePhonePad, secureEntry: false),
            AuthDataStackViewModel(image: #imageLiteral(resourceName: "auth/ic_white_phone").withRenderingMode(.alwaysOriginal), placeholder: "número de celular", type: .phonePad, secureEntry: false),
            AuthDataStackViewModel(image: #imageLiteral(resourceName: "auth/ic_white_email").withRenderingMode(.alwaysOriginal), placeholder: "email", type: .emailAddress, secureEntry: false),
            AuthDataStackViewModel(image: #imageLiteral(resourceName: "auth/ic_white_password").withRenderingMode(.alwaysOriginal), placeholder: "contraseña", type: .default, secureEntry: true)
        ], width: view.frame.width * 0.9, delegate: self, idStackView: "register")
        view.addSubview(registerView!)
        registerView!.centerX(inView: view)
        registerView!.anchor(bottom: btnStacks.topAnchor, paddingBottom: 10)
        let offScreenregister = registerView!.transform.translatedBy(x: 700, y: 0)
        registerView!.transform = offScreenregister
        registerView!.alpha = 0
        // Add lbl
        view.addSubview(lblInfoAuth)
        lblInfoAuth.centerX(inView: view)
        lblInfoAuth.anchor(bottom: self.loginView!.topAnchor, paddingBottom: 30)
    }
    // MARK: - Animaciones
    // Animacion menus
    func animateButtonStack(viewOut: UIView, outToSide: CGFloat, viewIn: UIView,
                            moveLabel: CGFloat, showBack: Bool, textInfo: String,
                            showEnter: Bool, showTextButton: Bool, textEnter: String,
                            textButton: String, updateEnter: Bool, updateButton: Bool,
                            transformLogo: Bool){
        //let direction: CGFloat = showButtonsStack ? 700 : -700
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseInOut, animations: {
            let xTranslation = outToSide
            let offScreenButtons = viewOut.transform.translatedBy(x: outToSide, y: 0)
            let onScreenView = viewIn.transform.translatedBy(x: outToSide, y: 0)
            let moveLblInScreen = self.lblInfoAuth.transform.translatedBy(x: 0, y: moveLabel)
            viewOut.transform = offScreenButtons
            viewIn.transform = onScreenView
            self.lblInfoAuth.transform = moveLblInScreen
            viewOut.alpha = 0
            viewIn.alpha = 1
            if (showEnter) && (self.enterButton.alpha == 0) {
                let enterAppear = self.enterButton.transform.translatedBy(x: 0, y: -30)
                self.enterButton.transform = enterAppear
                self.enterButton.alpha = 1
            }
            if (showTextButton) && (self.goRegisterButton.alpha == 0) {
                let enterTxt = self.goRegisterButton.transform.translatedBy(x: 0, y: -30)
                self.goRegisterButton.transform = enterTxt
                self.goRegisterButton.alpha = 1
            }
            self.lblInfoAuth.fadeTransition(0.2)
            self.enterButton.fadeTransition(0.2)
            self.goRegisterButton.fadeTransition(0.2)
            self.lblInfoAuth.text = textInfo
            if (updateEnter) {
                self.enterButton.setTitle(textEnter, for: .normal)
            }
            if (updateButton) {
                self.goRegisterButton.setTitle(textButton, for: .normal)
            }
            if (transformLogo) {
                let move = self.imageLogo.transform.translatedBy(x: 0, y: -30)
                self.imageLogo.transform = self.logoTransform!.concatenating(move)
            } else {
                self.imageLogo.transform = .identity
            }
        }) { (true) in
            self.allowAnimate = true
        }
    }
    // Asignar animacion
    func selectAnimation(viewIn: UIView, viewOut: UIView){
        if (viewIn == registerView && viewOut == loginView){
            animateButtonStack(viewOut: loginView!, outToSide: -700, viewIn: registerView!, moveLabel: -110, showBack: true, textInfo: "Registrate", showEnter: true, showTextButton: true, textEnter: "Registrarse", textButton: "Ya tengo cuenta", updateEnter: true, updateButton: true, transformLogo: true)
        } else if (viewIn == loginView && viewOut == registerView){
            animateButtonStack(viewOut: registerView!, outToSide: 700, viewIn: loginView!, moveLabel: 110, showBack: true, textInfo: "Iniciar sesión", showEnter: true, showTextButton: true, textEnter: "Entrar", textButton: "Crear cuenta", updateEnter: true, updateButton: true, transformLogo: false)
        }
    }
    
    // MARK: - Acciones
    // Click enter
    @objc func handleEnter(){
        switch(menuShowed){
        case .LOGIN_EMAIL:
            let data = loginView!.getData()
            print("Data es \(data)")
            viewModel.email = data["email"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.password = data["contraseña"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.process = .LOGIN_EMAIL
            break
        case .REGISTER_USER:
            let data = registerView!.getData()
            print("Data es \(data)")
            viewModel.name = data["nombre"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.surname = data["apellido(s)"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.phone = data["número de celular"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.email = data["email"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.password = data["contraseña"]?.trimmingCharacters(in: .whitespacesAndNewlines)
            viewModel.process = .REGISTER_USER
            break
        }
        setAuth()
    }
    // Click texto inferior
    @objc func handleTextClick(){
        print("Handle text click esta iniciando")
        if(allowAnimate) {
            allowAnimate = false
            switch(menuShowed){
            case .LOGIN_EMAIL:
                print("Este deberia ser en registrarme")
                menuShowed = .REGISTER_USER
                selectAnimation(viewIn: registerView!, viewOut: loginView!)
                break
            case .REGISTER_USER:
                print("Este deberia ser en ya tengo cuenta")
                menuShowed = .LOGIN_EMAIL
                selectAnimation(viewIn: loginView!, viewOut: registerView!)
                break
            }
        }
    }
    // MARK: - Otras funciones
    private func setAuth(){
        if(viewModel.formIsValid) {
            print("viewmodel es \(viewModel)")
            let loadScreen = createLoadScreen()
            if(viewModel.process == .LOGIN_EMAIL){
                AuthService.loginUser(withEmail: viewModel.email!, password: viewModel.password!) { (result, error) in
                    if let error = error {
                        print("Hubo un error, \(error.localizedDescription)")
                        loadScreen.dismissal()
                        return
                    }
                    loadScreen.dismissal()
                    self.delegate?.authenticationComplete()
                }
            } else {
                let credential = AuthCredentials(email: viewModel.email!,
                                                 password: viewModel.password!,
                                                 name: viewModel.name!,
                                                 surname: viewModel.surname!,
                                                 phone: viewModel.phone!)
                AuthService.registerUser(withCredentials: credential) { error in
                    if let error = error {
                        print("Hubo un error, \(error.localizedDescription)")
                        loadScreen.dismissal()
                    } else {
                        print("Registro salio bien")
                        loadScreen.dismissal()
                        self.delegate?.authenticationComplete()
                    }
                }
            }
        } else {
            print("No puede hacer Auth")
        }
    }
}

// MARK: - Text field delegate
extension AuthViewController: UITextFieldDelegate {
    // MARK: - Should Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Le dio done a \(textField.accessibilityIdentifier)")
        loginView!.setNextBecomerResponder(id: textField.accessibilityIdentifier!)
        registerView!.setNextBecomerResponder(id: textField.accessibilityIdentifier!)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.registerView!.resignResponder()
        self.loginView!.resignResponder()
    }
    
    /*------> View Setup delegates <------*/
    // Keyboard Show / hide
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            print("Is Focused, keyboardSize es \(keyboardSize.height)")
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 200
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

