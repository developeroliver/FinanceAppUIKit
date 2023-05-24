//
//  AccountType.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 24/05/2023.
//

import Foundation

final class AccountType {
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    enum AccountType: String {
        case Banque
        case MasterCard
        case Internet
    }
}
