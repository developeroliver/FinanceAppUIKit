//
//  DummyVC.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 20/05/2023.
//

import Foundation
import UIKit

class DummyVC: UIViewController {
    
    // MARK: - PROPERTIES
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButton = UIButton(type: .system)
    
    weak var delegate: DummyVCDelegate?
    
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    
    // MARK: HELPERS
    @objc func logoutButtonTapped() {
        delegate?.didLogout()
    }
    
    
    // MARK: - LAYOUT FUNCTIONS
    func configure() {
        configureStackView()
        configureLabelView()
        configureLogoutButton()
    }
    
    
    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    private func configureLabelView() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Déconnexion"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    
    private func configureLogoutButton() {
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.configuration = .filled()
        logoutButton.setTitle("déconnexion", for: [])
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
    }
}


