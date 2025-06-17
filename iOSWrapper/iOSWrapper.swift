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
    
    private init() {
        engine = FlutterEngine(name: "clevercards_engine")
        let success = engine.run()
        print("✅ Flutter engine started? \(success)")
        if success {
            GeneratedPluginRegistrant.register(with: engine)
        }
    }
    
    public func openFlutterModule(from viewController: UIViewController, message: String? = nil) {
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        viewController.present(flutterViewController, animated: true, completion: nil)
    }
}


