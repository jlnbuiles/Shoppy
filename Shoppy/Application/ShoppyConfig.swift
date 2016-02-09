import Foundation
import MagicalRecord

/**
Encapsulates services' configuration.

- author: Julian Builes
*/
class ShoppyConfig {
  
  class func configureApplicationServices() {
    MagicalRecord.setupCoreDataStackWithStoreNamed("Shoppy")
  }
  
}
