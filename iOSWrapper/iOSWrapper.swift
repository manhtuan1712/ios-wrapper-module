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
        let flutterBundle = findFlutterBundle() ?? Bundle.main
        let dartProject = FlutterDartProject(precompiledDartBundle: flutterBundle)
        
        engine = FlutterEngine(name: "clevercards_engine", project: dartProject, allowHeadlessExecution: true)

        let success = engine.run(withEntrypoint: nil)
        print("Flutter engine started: \(success)")
        
        if success {
            GeneratedPluginRegistrant.register(with: engine)
        }
    }
    
    private func findFlutterBundle() -> Bundle? {
        let allBundles = Bundle.allBundles + Bundle.allFrameworks
        for bundle in allBundles {
            if bundle.path(forResource: "flutter_assets", ofType: nil) != nil {
                return bundle
            }
        }
        return nil
    }
    
    public func openFlutterModule(from viewController: UIViewController, message: String? = nil) {
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        
        if let message = message {
            let channel = FlutterMethodChannel(name: "clevercards/message", binaryMessenger: engine.binaryMessenger)
            channel.invokeMethod("setMessage", arguments: message)
        }
        
        viewController.present(flutterViewController, animated: true, completion: nil)
    }
}


