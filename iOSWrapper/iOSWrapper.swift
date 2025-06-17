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
        let dartProject = FlutterDartProject(precompiledDartBundle: Bundle(for: type(of: self)))

        engine = FlutterEngine(name: "clevercards_engine", project: dartProject, allowHeadlessExecution: true)

        let success = engine.run(withEntrypoint: nil)
        print("✅ Flutter engine started? \(success)")
        
        if success {
            GeneratedPluginRegistrant.register(with: engine)
        } else {
            print("❌ Flutter engine failed to start.")
        }
    }
    
    public func openFlutterModule(from viewController: UIViewController, message: String? = nil) {
        let flutterViewController = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        viewController.present(flutterViewController, animated: true, completion: nil)
    }
}


