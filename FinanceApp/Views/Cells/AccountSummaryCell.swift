//
//  AccountSummaryCell.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 24/05/2023.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    let viewModel: AccountType? = nil
    
    let typeLabel           = UILabel()
    let underlineView       = UIView()
    let nameLabel           = UILabel()
    let stackView           = UIStackView()
    let balanceLabel        = UILabel()
    let balanceAmountLabel  = UILabel()
    let chevronImageView    = UIImageView()
    
    static let reuseID              = "AccountSummaryCell"
    static let rowHeight: CGFloat   = 112
    
    
    // MARK: - LIFECYCLE
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: HELPERS
    
    // MARK: - FUNCTIONS
    private func makeFormattedBalance(euro: String, cents: String) -> NSMutableAttributedString {
        let euroSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let euroAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: euro, attributes: euroSignAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        let euroString = NSAttributedString(string: "€", attributes: euroAttributes)
        
        rootString.append(centString)
        rootString.append(euroString)
        
        return rootString
    }
    
    
    // MARK: - LAYOUT FUNCTIONS
    private func configure() {
        configureTypeLabel()
        configureUnderlineView()
        configureNameLabel()
        configureStackView()
        configureBalanceLabel()
        configureBalanceAmountLabel()
        configureChevronImageView()
    }
    
    
    // MARK: typeLabel
    private func configureTypeLabel() {
        typeLabel.text = "Account Type"
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    // MARK: underlineView
    private func configureUnderlineView() {
        underlineView.backgroundColor = appColor
        
        contentView.addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
    
    // MARK: nameLabel
    private func configureNameLabel() {
        nameLabel.text  = "Account name"
        nameLabel.font  = UIFont.preferredFont(forTextStyle: .body)
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
    }
    
    // MARK: stackView
    private func configureStackView() {
        stackView.axis      = .vertical
        stackView.spacing   = 0
        
        stackView.addArrangedSubview(balanceLabel)
        stackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    // MARK: balanceLabel
    private func configureBalanceLabel() {
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        balanceLabel.text           = "Some balance"
        balanceLabel.font           = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment  = .right
    }
    
    // MARK: - AmountLabel
    private func configureBalanceAmountLabel() {
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        balanceAmountLabel.attributedText = makeFormattedBalance(euro: "XXX,XXX", cents: "XX")
        balanceAmountLabel.textAlignment  = .right
    }
    
    // MARK: - Chevron
    private func configureChevronImageView() {
        chevronImageView.image = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
        
        contentView.addSubview(chevronImageView)
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 12),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
}


extension AccountSummaryCell {
    func configureVM(with vm: AccountType.ViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .Banque:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Solde actuel"
        case .MasterCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Solde actuel"
        case .Internet:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Valeur"
        }
    }
}
