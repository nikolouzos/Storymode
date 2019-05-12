//
//  AppDelegate.swift
//  StorymodeApp
//
//  Created by Nikolaos Rafail Nikolouzos on 28/03/2019.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Firebase

let log = SwiftyBeaver.self
let firestore = FirebaseFirestore.Firestore.firestore()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application
		(_ application: UIApplication,
		 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// SwiftyBeaver configuration
		// Log to Xcode Console
		let console = ConsoleDestination()
		log.addDestination(console)

		// Log to the SwiftyBeaver app
		if let filePath = Bundle.main.path(forResource: "SwiftyBeaver", ofType: "plist"),
			let dict = NSDictionary(contentsOfFile: filePath) {
			let platform = SBPlatformDestination(appID: dict["appID"] as? String ?? "",
												 appSecret: dict["appSecret"] as? String ?? "",
												 encryptionKey: dict["encryptionKey"] as? String ?? "")
			log.addDestination(platform)
		}
		log.info("Added SwiftyBeaver logging!")

		// Add Firebase
		FirebaseApp.configure()

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Remove all the persistent Firestore listeners
		Firestore.shared.removePersistentListeners()
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the
		// changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart all the persistent Firestore listeners
		Firestore.shared.restartPersistentListeners()
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Remove all the persistent Firestore listeners
		Firestore.shared.removePersistentListeners()
	}
}
