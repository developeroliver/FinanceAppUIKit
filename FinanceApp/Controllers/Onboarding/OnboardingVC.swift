//
//  OnboardingVC.swift
//  Bankey
//
//  Created by olivier geiger on 19/05/2023.
//

import UIKit

class OnboardingVC: UIViewController {
    
    // MARK: - PROPERTIES
    let stackView   = UIStackView()
    let imageView   = UIImageView()
    let labelView   = UILabel()
    
    var onboardingImageName: String?
    var titleText: String?
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    
    init(onboardingImageName: String, titleText: String) {
        super.init(nibName: nil, bundle: nil)
        self.onboardingImageName   = onboardingImageName
        self.titleText             = titleText
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - LAYOUT FUNCTIONS
    func configure() {
        configureStackView()
        configureImageView()
        configureLabelView()
    }
    
    
    func configureStackView() {
        stackView.axis      = .vertical
        stackView.spacing   = 4
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelView)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),        ])
    }
    
    
    func configureImageView() {
        imageView.image         = UIImage(named: onboardingImageName ?? "onboarding1")
        imageView.contentMode   = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureLabelView() {
        labelView.text                                  = titleText
        labelView.font                                  = UIFont.preferredFont(forTextStyle: .title3)
        labelView.textAlignment                         = .center
        labelView.adjustsFontForContentSizeCategory     = true
        labelView.numberOfLines                         = 0
        
        labelView.translatesAutoresizingMaskIntoConstraints = false

    }
}
