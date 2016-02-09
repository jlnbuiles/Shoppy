import Foundation
import UIKit
import MagicalRecord

/**
 Responsible for managing application-level controller logic.
 
 - author: Julian Builes
 */
class ApplicationController {

  class func configureApplicationWithWindow(window: UIWindow, appDelegate: AppDelegate) {
    ShoppyConfig.configureApplicationServices()
    ApplicationController.configureViewControllers(window, appDelegate: appDelegate)
    ApplicationController.configureAppearanceProxies()
  }
  
  private class func configureAppearanceProxies() {
    let font = UIFont(name: "Kohinoor Bangla", size: 21)
    let navBarTextAttributes = [NSFontAttributeName: font!]
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.titleTextAttributes = navBarTextAttributes
  }
  
  private class func configureViewControllers(window: UIWindow, appDelegate: AppDelegate) {
    let splitViewController = window.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
    navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    splitViewController.delegate = appDelegate
    
    let masterNavigationController = splitViewController.viewControllers[0] as! UINavigationController
    let controller = masterNavigationController.topViewController as! AppCategoriesTVC
    controller.managedObjectContext = NSManagedObjectContext.MR_defaultContext()
  }
}
