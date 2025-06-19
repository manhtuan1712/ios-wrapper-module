//
//  iOSWrapper.swift
//  iOSWrapper
//
//  Created by Mập on 17/6/25.
//

import UIKit
import Flutter
import FlutterPluginRegistrant

public class FlutterModuleWrapper {
    public static let shared = FlutterModuleWrapper()
    
    private var engine: FlutterEngine?
    private var cardService: CardService?
    
    private init() {
        // Don't create engine immediately - will be lazy loaded when needed
    }
    
    private func getOrCreateEngine() -> FlutterEngine {
        if let existingEngine = engine {
            return existingEngine
        }
        
        // Try to find existing Flutter engine first
        if let existingEngine = findExistingFlutterEngine() {
            engine = existingEngine
            cardService = CardService(flutterEngine: existingEngine)
            return existingEngine
        }
        
        // Create new engine only if none exists
        let newEngine = FlutterEngine(name: "clevercards_engine")
        let success = newEngine.run()
        print("Flutter engine started: \(success)")
        
        if success {
            GeneratedPluginRegistrant.register(with: newEngine)
        }
        
        engine = newEngine
        cardService = CardService(flutterEngine: newEngine)
        return newEngine
    }
    
    private func findExistingFlutterEngine() -> FlutterEngine? {
        // Look for existing Flutter engines in the app
        // This prevents duplicate engine creation when Flutter is already integrated
        return nil // For now, always create new - can be enhanced later
    }
    
    public func openFlutterModule(from viewController: UIViewController, message: String? = nil) {
        let engine = getOrCreateEngine()
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        
        if let message = message {
            let channel = FlutterMethodChannel(name: "clevercards/message", binaryMessenger: engine.binaryMessenger)
            channel.invokeMethod("setMessage", arguments: message)
        }
        
        viewController.present(flutterViewController, animated: true, completion: nil)
    }
    
    // MARK: - Card Service Methods
    
    /// Retrieves card details for a given gift code
    /// - Parameter giftCode: The gift code for the card
    /// - Returns: CardDetail object containing card information
    /// - Throws: Error if the operation fails
    public func getCardDetail(giftCode: String) async throws -> CardDetail {
        let _ = getOrCreateEngine() // Ensure engine is ready
        guard let service = cardService else {
            throw NSError(domain: "FlutterModuleWrapper", code: -1, userInfo: [NSLocalizedDescriptionKey: "Card service not initialized"])
        }
        return try await service.getCardDetail(giftCode: giftCode)
    }
    
    /// Retrieves card tokens from the service
    /// - Returns: String containing the card token
    /// - Throws: Error if the operation fails
    public func getCardTokens() async throws -> String {
        let _ = getOrCreateEngine() // Ensure engine is ready
        guard let service = cardService else {
            throw NSError(domain: "FlutterModuleWrapper", code: -1, userInfo: [NSLocalizedDescriptionKey: "Card service not initialized"])
        }
        return try await service.getCardToken()
    }
    
    /// Decrypts an encrypted card piece
    /// - Parameter encryptedPiece: The encrypted piece to decrypt
    /// - Returns: String containing the decrypted piece
    /// - Throws: Error if the operation fails
    public func decryptCardPiece(encryptedPiece: String) async throws -> String {
        let _ = getOrCreateEngine() // Ensure engine is ready
        guard let service = cardService else {
            throw NSError(domain: "FlutterModuleWrapper", code: -1, userInfo: [NSLocalizedDescriptionKey: "Card service not initialized"])
        }
        return try await service.decryptCardPiece(encryptedPiece: encryptedPiece)
    }
}


