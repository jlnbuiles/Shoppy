import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

  var window: UIWindow?

  func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
    
    return true
  }
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    ApplicationController.configureApplicationWithWindow(window!, appDelegate: self)
    return true
  }

  func applicationWillResignActive(application: UIApplication) {}

  func applicationDidEnterBackground(application: UIApplication) {}

  func applicationWillEnterForeground(application: UIApplication) {}

  func applicationDidBecomeActive(application: UIApplication) {}

  func applicationWillTerminate(application: UIApplication) {
    NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion { (completed, error) -> Void in
      if error != nil {
        print("unable to save context with error \(error)")
      }
    }
  }

  // MARK: - Split view controller
  func splitViewController(splitViewController: UISplitViewController,
    collapseSecondaryViewController secondaryViewController:UIViewController,
    ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
      guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
      guard let _ = secondaryAsNavController.topViewController as? AppsCVC else { return false }
      return true
  }
}
