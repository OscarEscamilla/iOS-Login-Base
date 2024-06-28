//
//  ViewController.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 06/06/24.
//
import FirebaseCore
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    
    
    private let loginImage: UIImageView = {
        let imageView = UIImageView() // 1
        imageView.image = UIImage(named: "loginDraw") // 2
        imageView.translatesAutoresizingMaskIntoConstraints = false // 3
        return imageView
    }()
    
    private let textfieldPassword: UITextField = {
        var textfield =  UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.applyStyleDefault()
        return textfield
    }()
    
    private let textfieldEmail: UITextField = {
        var textfield =  UITextField()
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress // Set keyboard type to ASCII capable
        textfield.autocapitalizationType = .none
        textfield.clearButtonMode = .whileEditing
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.applyStyleDefault()
        return textfield
    }()		
    
    private lazy var loginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius =  10
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private lazy var registerButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGreen.cgColor
        button.layer.cornerRadius =  10
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    func setupView(){
        view.addSubview(registerButton)
        view.addSubview(loginButton)
        view.addSubview(textfieldEmail)
        view.addSubview(textfieldPassword)
        view.addSubview(loginImage)
        view.addSubview(activityIndicator)
        
        view.backgroundColor = .systemGray5
        
        let widthElements: CGFloat = 350.0
        
        NSLayoutConstraint.activate([
            
            loginImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            loginImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            loginImage.heightAnchor.constraint(equalToConstant: 300),
            loginImage.widthAnchor.constraint(equalToConstant: 300),
            
            textfieldEmail.topAnchor.constraint(equalTo: loginImage.bottomAnchor),
            textfieldEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfieldEmail.widthAnchor.constraint(equalToConstant: widthElements),
            
            textfieldPassword.topAnchor.constraint(equalTo: textfieldEmail.bottomAnchor, constant: 20),
            textfieldPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfieldPassword.widthAnchor.constraint(equalToConstant: widthElements),
            
            loginButton.topAnchor.constraint(equalTo: textfieldPassword.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: widthElements),
            
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: widthElements),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20)
        ])
        
        // Add tap gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    /* TAPPED LISTENERS */
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func loginButtonTapped(){
        
        guard let email = textfieldEmail.text, !email.isEmpty,
              let password = textfieldPassword.text, !password.isEmpty else {
            // Show error message to user
            return
        }
                
        setLoading(true)
                
        loginViewModel.loginUser(email: email, password: password) { error in
            self.setLoading(false)
            
            if let error = error {
                // Show error message to user
                print("Error logging in: \(error.localizedDescription)")
                self.textfieldPassword.text = ""
                self.showAlert(title: "Login Fail", message: error.localizedDescription)
            } else {
                // Successfully logged in, navigate to next screen or show success message
                print("User logged in successfully")
                let tabBarController = MainTabBarController()
                tabBarController.modalPresentationStyle = .fullScreen
                self.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func registerButtonTapped(){
        let viewControllerToPresent = RegisterViewController()
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.selectedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    private func setLoading(_ loading: Bool) {
        if loading {
            loginButton.isEnabled = false
            loginButton.setTitle("Logging in...", for: .normal)
            activityIndicator.startAnimating()
        } else {
            loginButton.isEnabled = true
            loginButton.setTitle("Login", for: .normal)
            activityIndicator.stopAnimating()
        }
    }
    
}


