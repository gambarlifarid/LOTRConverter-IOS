//
//  Currency.swift
//  LOTRConverter
//
//  Created by Farid Gambarli on 20.06.25.
//

import SwiftUI

enum Currency: Double, CaseIterable, Identifiable, Codable { // makes it an array
    case copperPenny = 6400
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
            "Copper Penny"
        case .silverPenny:
            "Silver Penny"
        case .silverPiece:
            "Silver Piece"
        case .goldPenny:
            "Gold Penny"
        case .goldPiece:
            "Gold Piece"
        }
    }
    
    func convert(_ amountString: String, to currency: Currency) -> String {
        guard let doubleAmount = Double(amountString) else {
            return ""
        }
        
        let convertedAmount = (doubleAmount / self.rawValue) * currency.rawValue
        
        return String(format: "%.2f", convertedAmount)
    }
    
    static func save(_ currency: Currency, key: String) {
        if let data = try? JSONEncoder().encode(currency) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    static func load(key: String, fallback: Currency) -> Currency {
        if let data = UserDefaults.standard.data(forKey: key),
           let savedCurrency = try? JSONDecoder().decode(Currency.self, from: data) {
            return savedCurrency
        }
        return fallback
    }
}
