//
//  DecimalUtils.swift
//  BankeyUIKit
//
//  Created by olivier geiger on 24/05/2023.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
