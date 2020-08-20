//
//  AppDelegate.swift
//  Hush-SwiftUI
//
//  Created by Dima Virych on 30.03.2020.
//  Copyright © 2020 AppServices. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Purchases
import PushNotifications
import BackgroundTasks

let pushNotifications = PushNotifications.shared

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .light
        }
        
        ApplicationDelegate.shared.application(
           application,
           didFinishLaunchingWithOptions: launchOptions
        )
        
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "dOgiuWrnvfyvWYRkKZVpXPDwFgUzCfvO")
                
        // pusher notification
        pushNotifications.start(instanceId: "6db18817-a55f-4c38-bd3c-0fd827fa2888")
        pushNotifications.registerForRemoteNotifications()
        //try? pushNotifications.addDeviceInterest(interest: "hello")
                
        registerBackgroundTaks()

        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        pushNotifications.registerDeviceToken(deviceToken)
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        pushNotifications.handleNotification(userInfo: userInfo)
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if let aps = userInfo["aps"] as? NSDictionary {
            if let alert = aps["alert"] as? NSDictionary {
                if let body = alert["body"] as? String {
                   //Do stuff
                    let params = body.components(separatedBy: ",")
                    let action = params[0]
                    if (action == "chat") {
                        
                    }
                }
            }
        }
    }
    
    private func registerBackgroundTaks() {

           BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.hinder.unreadchat", using: nil) { task in
           //This task is cast with processing request (BGProcessingTask)
               self.handleUnreadChatFetcherTask(task: task as! BGProcessingTask)
           }
       }
       
       func cancelAllPendingBGTask() {
           BGTaskScheduler.shared.cancelAllTaskRequests()
       }
       
       func scheduleUnreadChatfetcher() {
           let request = BGAppRefreshTaskRequest(identifier: "com.hinder.unreadchat")
           //request.requiresNetworkConnectivity = true // Need to true if your task need to network process. Defaults to false.
           //request.requiresExternalPower = false
           //If we keep requiredExternalPower = true then it required device is connected to external power.

           request.earliestBeginDate = Date(timeIntervalSinceNow: 30) // fetch Image Count after 1 minute.
           //Note :: EarliestBeginDate should not be set to too far into the future.
           do {
               try BGTaskScheduler.shared.submit(request)
           } catch {
               print("Could not schedule image fetch: \(error)")
           }
       }
       
       func handleUnreadChatFetcherTask(task: BGProcessingTask) {
           print("background task---------", Date())
           scheduleUnreadChatfetcher()
       }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )

    } 
}
