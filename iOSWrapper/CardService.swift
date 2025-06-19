//
//  CardService.swift
//  iOSWrapper
//
//  Created by Mập on 18/6/25.
//

import Flutter
import Foundation

class CardService {
    private let channel: FlutterMethodChannel
    
    init(flutterEngine: FlutterEngine) {
        self.channel = FlutterMethodChannel(
            name: "clevercard_module/card_service",
            binaryMessenger: flutterEngine.binaryMessenger
        )
    }
    
    // MARK: - Method Channel Interface
    
    func initializeCardModule(environment: String = "staging") async throws -> String {
        let arguments = ["environment": environment]
        
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("initializeCardModule", arguments: arguments) { result in
                // Handle FlutterMethodChannel result (Any?)
                if let error = result as? FlutterError {
                    continuation.resume(throwing: NSError(domain: "CardService", code: Int(error.code) ?? -1, userInfo: [NSLocalizedDescriptionKey: error.message ?? "Flutter method error"]))
                    return
                }
                
                // Check for method not implemented (typically nil or specific error)
                if result == nil {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                    return
                }
                
                // Handle successful response
                if let responseDict = result as? [String: Any] {
                    if let success = responseDict["success"] as? Bool, success {
                        if let message = responseDict["message"] as? String {
                            continuation.resume(returning: message)
                        } else {
                            continuation.resume(throwing: NSError(domain: "CardService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid message format in response"]))
                        }
                    } else {
                        let errorMessage = responseDict["error"] as? String ?? "Unknown error occurred"
                        continuation.resume(throwing: NSError(domain: "CardService", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                } else if let message = result as? String {
                    // Direct string response
                    continuation.resume(returning: message)
                } else if result == nil {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                } else {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format: \(type(of: result))"]))
                }
            }
        }
    }
    
    func getCardDetail(giftCode: String) async throws -> CardDetail {
        let arguments = ["giftCode": giftCode]
        
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("getCardDetail", arguments: arguments) { result in
                // Handle FlutterMethodChannel result (Any?)
                if let error = result as? FlutterError {
                    continuation.resume(throwing: NSError(domain: "CardService", code: Int(error.code) ?? -1, userInfo: [NSLocalizedDescriptionKey: error.message ?? "Flutter method error"]))
                    return
                }
                
                // Handle successful response
                if let responseDict = result as? [String: Any] {
                    if let success = responseDict["success"] as? Bool, success {
                        if let cardData = responseDict["data"] as? [String: Any] {
                            let cardDetail = CardDetail(from: cardData)
                            continuation.resume(returning: cardDetail)
                        } else {
                            continuation.resume(throwing: NSError(domain: "CardService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid card data format in response"]))
                        }
                    } else {
                        let errorMessage = responseDict["error"] as? String ?? "Unknown error occurred"
                        continuation.resume(throwing: NSError(domain: "CardService", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                } else if result == nil {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                } else {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format: \(type(of: result))"]))
                }
            }
        }
    }
    
    func getCardToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("getCardToken", arguments: nil) { result in
                // Handle FlutterMethodChannel result (Any?)
                if let error = result as? FlutterError {
                    // Flutter returned an error
                    continuation.resume(throwing: NSError(domain: "CardService", code: Int(error.code) ?? -1, userInfo: [NSLocalizedDescriptionKey: error.message ?? "Flutter method error"]))
                    return
                }
                
                // Handle successful response
                if let responseDict = result as? [String: Any] {
                    if let success = responseDict["success"] as? Bool, success {
                        if let resultData = responseDict["data"] as? [String: Any],
                           let token = resultData["token"] as? String {
                            continuation.resume(returning: token)
                        } else if let token = responseDict["token"] as? String {
                            // Alternative response format
                            continuation.resume(returning: token)
                        } else {
                            continuation.resume(throwing: NSError(domain: "CardService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid token format in response"]))
                        }
                    } else {
                        let errorMessage = responseDict["error"] as? String ?? "Unknown error occurred"
                        continuation.resume(throwing: NSError(domain: "CardService", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                } else if let token = result as? String {
                    // Direct string response
                    continuation.resume(returning: token)
                } else if result == nil {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                } else {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format: \(type(of: result))"]))
                }
            }
        }
    }
    
    func decryptCardPiece(encryptedPiece: String) async throws -> String {
        let arguments = ["encryptedPiece": encryptedPiece]
        
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("decryptCardPiece", arguments: arguments) { result in
                // Handle FlutterMethodChannel result (Any?)
                if let error = result as? FlutterError {
                    continuation.resume(throwing: NSError(domain: "CardService", code: Int(error.code) ?? -1, userInfo: [NSLocalizedDescriptionKey: error.message ?? "Flutter method error"]))
                    return
                }
                
                // Handle successful response
                if let responseDict = result as? [String: Any] {
                    if let success = responseDict["success"] as? Bool, success {
                        if let resultData = responseDict["data"] as? [String: Any],
                           let decryptedPiece = resultData["decryptedPiece"] as? String {
                            continuation.resume(returning: decryptedPiece)
                        } else if let decryptedPiece = responseDict["decryptedPiece"] as? String {
                            // Alternative response format
                            continuation.resume(returning: decryptedPiece)
                        } else {
                            continuation.resume(throwing: NSError(domain: "CardService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid decrypted piece format in response"]))
                        }
                    } else {
                        let errorMessage = responseDict["error"] as? String ?? "Unknown error occurred"
                        continuation.resume(throwing: NSError(domain: "CardService", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                } else if let decryptedPiece = result as? String {
                    // Direct string response
                    continuation.resume(returning: decryptedPiece)
                } else if result == nil {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                } else {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format: \(type(of: result))"]))
                }
            }
        }
    }
    
    func decryptCardDetails(giftCardData: [String: Any]) async throws -> CardDetail {
        let arguments = ["giftCardData": giftCardData]
        
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("decryptCardDetails", arguments: arguments) { result in
                // Handle FlutterMethodChannel result (Any?)
                if let error = result as? FlutterError {
                    continuation.resume(throwing: NSError(domain: "CardService", code: Int(error.code) ?? -1, userInfo: [NSLocalizedDescriptionKey: error.message ?? "Flutter method error"]))
                    return
                }
                
                // Handle successful response
                if let responseDict = result as? [String: Any] {
                    if let success = responseDict["success"] as? Bool, success {
                        if let cardData = responseDict["data"] as? [String: Any] {
                            let cardDetail = CardDetail(from: cardData)
                            continuation.resume(returning: cardDetail)
                        } else {
                            continuation.resume(throwing: NSError(domain: "CardService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid card data format in response"]))
                        }
                    } else {
                        let errorMessage = responseDict["error"] as? String ?? "Unknown error occurred"
                        continuation.resume(throwing: NSError(domain: "CardService", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage]))
                    }
                } else if result == nil {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                } else {
                    continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format: \(type(of: result))"]))
                }
            }
        }
    }
}
