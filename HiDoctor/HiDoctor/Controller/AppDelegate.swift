//
//  AppDelegate.swift
//  HiDoctor
//
//  Created by Vijay on 01/09/15.
//  Copyright © 2015 Swaas Systems. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, PNObjectEventListener {

    var window: UIWindow?

    //MARK: - Application Life Cycle
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Window Custom Settings
        self.window?.backgroundColor = windowBg
        
        // StatusBar Custom Settings
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        // NavigationBar Custom Settings
        UINavigationBar.appearance().barTintColor = navigationBarBg
        UINavigationBar.appearance().tintColor = navigationBarText
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : navigationBarText]
        
        // Setting HomeViewController as the InitialViewController if the user already logged on
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let loggedEmail:NSString? = userDefaults.objectForKey(userEmail) as? String
        if loggedEmail != nil && loggedEmail != ""
        {
            tabbarRootController()
        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    //MARK: - Tabbar Root Controller
    func tabbarRootController() {
        
        let tabBarController = UITabBarController()
        
        let home_sb = UIStoryboard(name: sbHome, bundle: nil)
        let home_vc = home_sb.instantiateViewControllerWithIdentifier(vcHome) as UIViewController
        
        let patient_sb = UIStoryboard(name: sbPatient, bundle: nil)
        let patient_vc = patient_sb.instantiateViewControllerWithIdentifier(vcPatient) as UIViewController
        
        let drug_sb = UIStoryboard(name: sbDrug, bundle: nil)
        let drug_vc = drug_sb.instantiateViewControllerWithIdentifier(vcDrug) as UIViewController
        
        let alert_sb = UIStoryboard(name: sbAlert, bundle: nil)
        let alert_vc = alert_sb.instantiateViewControllerWithIdentifier(vcAlert) as UIViewController
        
        let more_sb = UIStoryboard(name: sbMore, bundle: nil)
        let more_vc = more_sb.instantiateViewControllerWithIdentifier(vcMore) as UIViewController
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(red: 15/255, green: 103/255, blue: 169/255, alpha: 1)], forState:.Selected)
        
        
        home_vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icon-home")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon-home-active")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let home_nc: UINavigationController = UINavigationController(rootViewController: home_vc)
        
        patient_vc.tabBarItem = UITabBarItem(title: "Patient", image: UIImage(named: "icon-patient")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon-patient-active")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let patient_nc: UINavigationController = UINavigationController(rootViewController: patient_vc)
        
        drug_vc.tabBarItem = UITabBarItem(title: "Drug", image: UIImage(named: "icon-drug")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon-drug-active")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let drug_nc: UINavigationController = UINavigationController(rootViewController: drug_vc)
        
        alert_vc.tabBarItem = UITabBarItem(title: "Alert", image: UIImage(named: "icon-notifications")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon-notifications-active")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let alert_nc: UINavigationController = UINavigationController(rootViewController: alert_vc)
        
        more_vc.tabBarItem = UITabBarItem(title: "More", image: UIImage(named: "icon-more")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), selectedImage: UIImage(named: "icon-more-active")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let more_nc: UINavigationController = UINavigationController(rootViewController: more_vc)
        
        let controllers = [home_nc,patient_nc,drug_nc,alert_nc, more_nc]
        tabBarController.viewControllers = controllers
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.swaas.HiDoctor" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("HiDoctor", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

