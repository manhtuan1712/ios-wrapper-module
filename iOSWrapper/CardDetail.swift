//
//  CardDetail.swift
//  iOSWrapper
//
//  Created by Mập on 18/6/25.
//

public struct CardDetail {
    public let cardId: String?
    public let giftCode: String?
    public let name: String?
    public let currency: String?
    public let originalBalance: Double?
    public let remainingBalance: Double?
    public let expiryDate: String?
    public let formattedPan: String?
    public let maskedPan: String?
    public let encryptedCvv: String?
    public let encryptedPan: String?
    
    public init(from data: [String: Any]) {
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
