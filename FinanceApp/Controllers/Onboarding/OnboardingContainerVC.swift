//
//  OnboardingContainerVC.swift
//  Bankey
//
//  Created by olivier geiger on 19/05/2023.
//

import UIKit

protocol OnboardingContainerVCDelegate: AnyObject {
    func didFinishOnBoarding()
}


class OnboardingContainerVC: UIViewController {
    // MARK: - PROPERTIES
    let pageControl     = UIPageControl()
    var pages           = [UIViewController]()
    let pageVC: UIPageViewController
    
    var currentVC: UIViewController {
            didSet {
                guard let index = pages.firstIndex(of: currentVC) else { return }
                closeBottomButton.isHidden = !(index == pages.count - 1)
            }
        }
    
    let closeTopButton      = UIButton(type: .system)
    let closeBottomButton    = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerVCDelegate?
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        configure()
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingVC(onboardingImageName: "onboarding1", titleText: "Finance App est l'application idéale pour gérer vos comptes avec facilité.")
        let page2 = OnboardingVC(onboardingImageName: "onboarding2", titleText: "Gérez votre argent facilement avec simplicité.")
        let page3 = OnboardingVC(onboardingImageName: "onboarding3", titleText: "Votre argent est en sécurité, avec une protection robuste.")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
 
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: HELPERS
    @objc func closeButtonTapped() {
        delegate?.didFinishOnBoarding()
    }
    
    
    // MARK: - LAYOUT FUNCTIONS
    private func configure() {
        configureLayout()
        configureCloseTopButton()
//        configureCloseBottomButton()
    }
    
    
    private func configureLayout() {
        addChild(pageVC)
        view.addSubview(pageVC.view)
        pageVC.didMove(toParent: self)
        
        pageVC.dataSource = self
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageVC.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageVC.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageVC.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageVC.view.bottomAnchor),
        ])
        
        pageVC.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    
    func configureCloseTopButton() {
        view.addSubview(closeTopButton)
        closeTopButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeTopButton.setTitle("Fermer", for: [])
        closeTopButton.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            closeTopButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeTopButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
    
    
    func configureCloseBottomButton() {
        view.addSubview(closeBottomButton)
        closeBottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeBottomButton.setTitle("Fermer", for: [])
        closeTopButton.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            closeBottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            closeBottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}


// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    
    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    
    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
        
}
