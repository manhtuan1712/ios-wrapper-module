//
//  CardService.swift
//  iOSWrapper
//
//  Created by Mập on 18/6/25.
//

import Flutter

class CardService {
    private let channel: FlutterMethodChannel
    
    init(flutterEngine: FlutterEngine) {
        self.channel = FlutterMethodChannel(
            name: "clevercard_module/card_service",
            binaryMessenger: flutterEngine.binaryMessenger
        )
    }
    
    func initializeCardModule(environment: String = "staging") async throws -> String {
        let arguments = ["environment": environment]
        let result = try await channel.invokeMethod("initializeCardModule", arguments: arguments) as! [String: Any]
        
        if result["success"] as! Bool {
            return result["message"] as! String
        } else {
            throw NSError(domain: "CardService", code: 0, userInfo: [NSLocalizedDescriptionKey: result["error"] as! String])
        }
    }
    
    func getCardDetail(giftCode: String) async throws -> CardDetail {
        let arguments = ["giftCode": giftCode]
        let result = try await channel.invokeMethod("getCardDetail", arguments: arguments) as! [String: Any]
        
        if result["success"] as! Bool {
            let data = result["data"] as! [String: Any]
            return CardDetail(from: data)
        } else {
            throw NSError(domain: "CardService", code: 0, userInfo: [NSLocalizedDescriptionKey: result["error"] as! String])
        }
    }
    
    func getCardToken() async throws -> String {
        let result = try await channel.invokeMethod("getCardToken", arguments: nil) as! [String: Any]
        
        if result["success"] as! Bool {
            let data = result["data"] as! [String: Any]
            return data["token"] as! String
        } else {
            throw NSError(domain: "CardService", code: 0, userInfo: [NSLocalizedDescriptionKey: result["error"] as! String])
        }
    }
    
    func decryptCardPiece(encryptedPiece: String) async throws -> String {
        let arguments = ["encryptedPiece": encryptedPiece]
        let result = try await channel.invokeMethod("decryptCardPiece", arguments: arguments) as! [String: Any]
        
        if result["success"] as! Bool {
            let data = result["data"] as! [String: Any]
            return data["decryptedPiece"] as! String
        } else {
            throw NSError(domain: "CardService", code: 0, userInfo: [NSLocalizedDescriptionKey: result["error"] as! String])
        }
    }
    
    func decryptCardDetails(giftCardData: [String: Any]) async throws -> CardDetail {
        let arguments = ["giftCardData": giftCardData]
        let result = try await channel.invokeMethod("decryptCardDetails", arguments: arguments) as! [String: Any]
        
        if result["success"] as! Bool {
            let data = result["data"] as! [String: Any]
            return CardDetail(from: data)
        } else {
            throw NSError(domain: "CardService", code: 0, userInfo: [NSLocalizedDescriptionKey: result["error"] as! String])
        }
    }
}
