//
//  AccountSummaryVC.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 22/05/2023.
//

import UIKit

class AccountSummaryVC: UIViewController {
    
    // MARK: - PROPERTIES
    let tableView   = UITableView()
    let header      = AccountSummaryHeaderView(frame: .zero)
    
    var accounts: [AccountType.ViewModel] = []

    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
    }
    
    
    // MARK: - LAYOUT FUNCTIONS
    private func configure() {
        configureTableView()
        configureTableHeaderView()
        fetchData()
    }
    
    
    private func configureTableView() {
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight     = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate      = self
        tableView.dataSource    = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    private func configureTableHeaderView() {
        var size                    = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width                  = UIScreen.main.bounds.width
        header.frame.size           = size
        
        tableView.tableHeaderView   = header
    }
}

extension AccountSummaryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard !accounts.isEmpty else { return UITableViewCell()}
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configureVM(with: account)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension AccountSummaryVC {
    private func fetchData() {
        let savings = AccountType.ViewModel(accountType: .Banque,
                                            accountName: "Loyer",
                                            balance: 622.45)
        let visa = AccountType.ViewModel(accountType: .MasterCard,
                                         accountName: "Paiement magasin",
                                         balance: 160.99)
        let internet = AccountType.ViewModel(accountType: .Internet,
                                             accountName: "Achat livres",
                                             balance: 34.99)
        let internet1 = AccountType.ViewModel(accountType: .Internet,
                                             accountName: "Keyboard",
                                             balance: 134.99)
        let visa2 = AccountType.ViewModel(accountType: .Internet,
                                             accountName: "Diablo 4",
                                             balance: 69.99)
        
        accounts.append(savings)
        accounts.append(visa)
        accounts.append(internet)
        accounts.append(internet1)
        accounts.append(visa2)
    }
}
