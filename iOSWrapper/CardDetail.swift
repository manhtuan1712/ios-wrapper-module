//
//  CardDetail.swift
//  iOSWrapper
//
//  Created by Mập on 18/6/25.
//

struct CardDetail {
    let cardId: String?
    let giftCode: String?
    let name: String?
    let currency: String?
    let originalBalance: Double?
    let remainingBalance: Double?
    let expiryDate: String?
    let formattedPan: String?
    let maskedPan: String?
    let encryptedCvv: String?
    let encryptedPan: String?
    
    init(from data: [String: Any]) {
        self.cardId = data["cardId"] as? String
        self.giftCode = data["giftCode"] as? String
        self.name = data["name"] as? String
        self.currency = data["currency"] as? String
        self.originalBalance = data["originalBalance"] as? Double
        self.remainingBalance = data["remainingBalance"] as? Double
        self.expiryDate = data["expiryDate"] as? String
        self.formattedPan = data["formattedPan"] as? String
        self.maskedPan = data["maskedPan"] as? String
        self.encryptedCvv = data["encryptedCvv"] as? String
        self.encryptedPan = data["encryptedPan"] as? String
    }
}
