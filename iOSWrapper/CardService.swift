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
    
    // MARK: - Callback-based methods (for easier integration)
    
    /// Get card token with completion handler
    /// - Parameter completion: Callback with Result<String, Error>
    func getCardToken(completion: @escaping (Result<String, Error>) -> Void) {
        channel.invokeMethod("getCardToken", arguments: nil) { result in
            switch result {
            case let .success(data):
                if let responseDict = data as? [String: Any] {
                    if let success = responseDict["success"] as? Bool, success {
                        if let resultData = responseDict["data"] as? [String: Any],
                           let token = resultData["token"] as? String {
                            completion(.success(token))
                        } else if let token = responseDict["token"] as? String {
                            completion(.success(token))
                        } else {
                            completion(.failure(NSError(domain: "CardService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid token format in response"])))
                        }
                    } else {
                        let errorMessage = responseDict["error"] as? String ?? "Unknown error occurred"
                        completion(.failure(NSError(domain: "CardService", code: -1, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                } else if let token = data as? String {
                    completion(.success(token))
                } else {
                    completion(.failure(NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"])))
                }
                
            case let .failure(error):
                completion(.failure(error))
                
            case .none:
                completion(.failure(NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"])))
            }
        }
    }
    
    // MARK: - Async/await methods
    
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
        
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("getCardDetail", arguments: arguments) { result in
                switch result {
                case let .success(data):
                    if let responseDict = data as? [String: Any] {
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
                    } else {
                        continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"]))
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                    
                case .none:
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                }
            }
        }
    }
    
    func getCardToken() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("getCardToken", arguments: nil) { result in
                switch result {
                case let .success(data):
                    // Handle successful response
                    if let responseDict = data as? [String: Any] {
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
                    } else if let token = data as? String {
                        // Direct string response
                        continuation.resume(returning: token)
                    } else {
                        continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"]))
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                    
                case .none:
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                }
            }
        }
    }
    
    func decryptCardPiece(encryptedPiece: String) async throws -> String {
        let arguments = ["encryptedPiece": encryptedPiece]
        
        return try await withCheckedThrowingContinuation { continuation in
            channel.invokeMethod("decryptCardPiece", arguments: arguments) { result in
                switch result {
                case let .success(data):
                    if let responseDict = data as? [String: Any] {
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
                    } else if let decryptedPiece = data as? String {
                        // Direct string response
                        continuation.resume(returning: decryptedPiece)
                    } else {
                        continuation.resume(throwing: NSError(domain: "CardService", code: -3, userInfo: [NSLocalizedDescriptionKey: "Unexpected response format"]))
                    }
                    
                case let .failure(error):
                    continuation.resume(throwing: error)
                    
                case .none:
                    continuation.resume(throwing: NSError(domain: "CardService", code: -4, userInfo: [NSLocalizedDescriptionKey: "No response received from Flutter method channel"]))
                }
            }
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
