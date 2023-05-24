//
//  LoginView.swift
//  Bankey
//
//  Created by olivier geiger on 18/05/2023.
//

import UIKit

class LoginView: UIView {
    
    // MARK: - PROPERTIES
    let stackView           = UIStackView()
    let usernameTextField   = UITextField()
    let passwordTextField   = UITextField()
    let dividerView         = UIView()
    let SignInButton        = UIButton()
    

    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - FUNCTIONS
    func configure() {
        configureStack()
    }
    
    
    // MARK: - StackView()
    func configureStack() {
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
       
        addSubview(stackView)
        
        stackView.axis                          = .vertical
        stackView.spacing                       = 8
        
        usernameTextField.placeholder           = "Username"
        usernameTextField.delegate              = self
        
        passwordTextField.placeholder           = "Password"
        passwordTextField.isSecureTextEntry     = true
        passwordTextField.delegate              = self
        
        dividerView.backgroundColor             = .secondarySystemFill
        
        layer.cornerRadius                      = 5
        clipsToBounds                           = true
        
        stackView.translatesAutoresizingMaskIntoConstraints         = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints       = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        
        
        // MARK: - Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 16),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            
            dividerView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}


// MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
