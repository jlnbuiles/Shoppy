import Foundation
import UIKit

/**
 Responsible for managing application-level controller logic.
 
 - author: Julian Builes
 */
class ApplicationController {

  class func configureAppearanceProxies() {
    let font = UIFont(name: "Kohinoor Bangla", size: 21)
    let navBarTextAttributes = [NSFontAttributeName: font!]
    
    let navBarAppearance = UINavigationBar.appearance()
    navBarAppearance.titleTextAttributes = navBarTextAttributes
  }
}