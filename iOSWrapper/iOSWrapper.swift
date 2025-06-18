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
    
    private let engine: FlutterEngine
    private let cardService: CardService
    
    private init() {
        engine = FlutterEngine(name: "clevercards_engine")

        let success = engine.run()
        print("Flutter engine started: \(success)")
        
        if success {
            GeneratedPluginRegistrant.register(with: engine)
        }
        
        cardService = CardService(flutterEngine: engine)
    }
    
    public func openFlutterModule(from viewController: UIViewController, message: String? = nil) {
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
        return try await cardService.getCardDetail(giftCode: giftCode)
    }
    
    /// Retrieves card tokens from the service
    /// - Returns: String containing the card token
    /// - Throws: Error if the operation fails
    public func getCardTokens() async throws -> String {
        return try await cardService.getCardToken()
    }
    
    /// Decrypts an encrypted card piece
    /// - Parameter encryptedPiece: The encrypted piece to decrypt
    /// - Returns: String containing the decrypted piece
    /// - Throws: Error if the operation fails
    public func decryptCardPiece(encryptedPiece: String) async throws -> String {
        return try await cardService.decryptCardPiece(encryptedPiece: encryptedPiece)
    }
}


