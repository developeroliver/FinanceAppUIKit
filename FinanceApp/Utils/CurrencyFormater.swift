//
//  CurrencyFormater.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 24/05/2023.
//

import UIKit

struct CurrencyFormatter {
    
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoEurosAndCents(amount)
        return makeBalanceAttributed(euro: tuple.0, cents: tuple.1)
    }
    
    // Converts 929466.23 > "929,466" "23"
    func breakIntoEurosAndCents(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let euro = convertEuro(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (euro, cents)
    }
    
    // Converts 929466 > 929,466
    private func convertEuro(_ euroPart: Double) -> String {
        let eurosWithDecimal = eurosFormatted(euroPart) // "$929,466.00"
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator! // "."
        let euroComponents = eurosWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        let euros = euroComponents.first!

        return euros
    }
    
    // Convert 0.23 > 23
    private func convertCents(_ centPart: Double) -> String {
        let cents: String
        if centPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centPart * 100)
        }
        return cents
    }
    
    // Converts 929466 > $929,466.00
    func eurosFormatted(_ euros: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: euros as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAttributed(euro: String, cents: String) -> NSMutableAttributedString {
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
}
