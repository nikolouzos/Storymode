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
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of
		// temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the
		// application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games
		// should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application
		// state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate:
		// when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the
		// changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the
		// application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also
		// applicationDidEnterBackground:.
	}
}
