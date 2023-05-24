//
//  LoginVC.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 20/05/2023.
//

import UIKit

protocol DummyVCDelegate: AnyObject {
    func didLogout()
}

protocol LoginVCDelegate: AnyObject {
    func didLogin()
}


class LoginVC: UIViewController {
    
    // MARK: - PROPERTIES
    let titleLabel          = UILabel()
    let subtitleLabel       = UILabel()
    let loginView           = LoginView()
    let signInButton        = UIButton(type: .system)
    let errorMessageLabel   = UILabel()
    
    weak var delegate: LoginVCDelegate?
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    // MARK: - animation
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    
    
    // MARK: HELPERS
    @objc func signInTapped() {
        errorMessageLabel.isEnabled = true
        login()
    }
    
    
    // MARK: - FUNCTIONS
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / Password should never be null")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureErrorView(withMessage: "Username / password cannot be blank")
        }
        
        if username == "Olive" && password == "Welcome" {
            delegate?.didLogin()
            signInButton.configuration?.showsActivityIndicator = true
        } else {
            configureErrorView(withMessage: "Incorrect username / password")
        }
        
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
    
    private func configureErrorView(withMessage message: String) {
        errorMessageLabel.isHidden  = false
        errorMessageLabel.text      = message
    }
    
    
    private func createDismissKeyboadTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    // MARK: - LAYOUT FUNCTIONS
    private func configure() {
        configureTitleLabel()
        configureSubTitleLabel()
        configureLoginView()
        configureSignInButton()
        configureErrorMessageLabel()
        createDismissKeyboadTapGesture()
    }
    
    
    // MARK: - titleLabel
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textAlignment                        = .center
        titleLabel.font                                 = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory    = true
        titleLabel.text                                 = "Finance App"
        //        titleLabel.text                                 = "Bankey"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    // MARK: - subtitleLabel
    private func configureSubTitleLabel() {
        view.addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        subtitleLabel.textAlignment                         = .center
        subtitleLabel.font                                  = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory     = true
        subtitleLabel.numberOfLines                         = 0
        subtitleLabel.minimumScaleFactor          = 0.9
        subtitleLabel.text                                  = "the best place to store your finances!"
        //        subtitleLabel.text                                  = "Your premium source for all things banking!"
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    
    // MARK: - LoginView
    private func configureLoginView() {
        view.addSubview(loginView)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
    
    
    // MARK: - SignInButton
    private func configureSignInButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.configuration                  = .filled()
        signInButton.configuration?.imagePadding    = 8
        signInButton.backgroundColor                = .systemBlue
        signInButton.layer.cornerRadius             = 10
        signInButton.layer.shadowColor              = UIColor.systemBlue.cgColor
        signInButton.layer.shadowOffset             = CGSize(width: 5, height: 2)
        signInButton.layer.shadowOpacity            = 0.5
        signInButton.layer.shadowRadius             = 4
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 16),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
    
    
    // MARK: - errorMessageLabel
    private func configureErrorMessageLabel() {
        view.addSubview(errorMessageLabel)
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        errorMessageLabel.textAlignment     = .center
        errorMessageLabel.textColor         = .systemPink
        errorMessageLabel.numberOfLines     = 0
        errorMessageLabel.text              = "Error failure"
        errorMessageLabel.isHidden          = true
        
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
    }
    
}


// MARK: - Animations
extension LoginVC {
    private func animate() {
        let duration = 0.8

        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()

        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.2)

        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.subtitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.2)
    }
}
