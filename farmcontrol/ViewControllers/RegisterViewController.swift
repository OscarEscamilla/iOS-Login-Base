//
//  RegisterViewController.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 11/06/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class RegisterViewController: UIViewController {
    
    private let registerViewModel = LoginViewModel()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius =  10
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let textfieldEmail: UITextField = {
        var textfield =  UITextField()
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress // Set keyboard type to ASCII capable
        textfield.autocapitalizationType = .none
        textfield.clearButtonMode = .whileEditing
        textfield.applyStyleDefault()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let textfieldName: UITextField = {
        var textfield =  UITextField()
        textfield.placeholder = "Name"
        textfield.autocapitalizationType = .none
        textfield.clearButtonMode = .whileEditing
        textfield.applyStyleDefault()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let textfieldPassword: UITextField = {
        var textfield =  UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.applyStyleDefault()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        view.backgroundColor = .systemGray5
        view.addSubview(textfieldEmail)
        view.addSubview(textfieldName)
        view.addSubview(textfieldPassword)
        view.addSubview(registerButton)
        view.addSubview(createAccountLabel)
        view.addSubview(activityIndicator)
        
        let widthElements: CGFloat = 350.0
        
        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 30),
            createAccountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            createAccountLabel.widthAnchor.constraint(equalToConstant: widthElements),
            textfieldName.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 30),
            textfieldName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfieldName.widthAnchor.constraint(equalToConstant: widthElements),
            textfieldEmail.topAnchor.constraint(equalTo: textfieldName.bottomAnchor, constant: 20),
            textfieldEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfieldEmail.widthAnchor.constraint(equalToConstant: widthElements),
            textfieldPassword.topAnchor.constraint(equalTo: textfieldEmail.bottomAnchor, constant: 20),
            textfieldPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textfieldPassword.widthAnchor.constraint(equalToConstant: widthElements),
            registerButton.topAnchor.constraint(equalTo: textfieldPassword.bottomAnchor, constant: 30),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: widthElements),
            //activity indicator
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20)
        ])
    }
    
    @objc
    func registerButtonTapped(){
        setLoading(true)
        guard let name = textfieldName.text, !name.isEmpty,
              let email = textfieldEmail.text, !email.isEmpty,
              let password = textfieldPassword.text, !password.isEmpty else {
            // Show error message to user
            return
        }
                
        registerViewModel.registerUser(name: name, email: email, password: password) { error in
            self.setLoading(false)
            if let error = error {
                // Show error message to user
                self.resetTextFields(isSuccess: false)
                self.showAlert(title: "Fail", message: error.localizedDescription)
            } else {
                // Successfully registered, navigate to next screen or show success message
                self.showAlert(title: "Success", message: "User registered successfully")
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func setLoading(_ loading: Bool) {
        if loading {
            registerButton.isEnabled = false
            registerButton.setTitle("Registering...", for: .normal)
            activityIndicator.startAnimating()
        } else {
            registerButton.isEnabled = true
            registerButton.setTitle("Register", for: .normal)
            activityIndicator.stopAnimating()
        }
    }
    
    private func resetTextFields(isSuccess: Bool){
        textfieldPassword.text = ""
    }
    

    
}
