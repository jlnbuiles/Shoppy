import Foundation
import CoreData
import ObjectMapper

/**
 Represents an app.
 
 - author: Julian Builes
 */
class App: NSManagedObject, Mappable {

  required init?(_ map: Map) {
    let context = NSManagedObjectContext.MR_defaultContext()
    let entity = NSEntityDescription.entityForName("App", inManagedObjectContext: context)
    super.init(entity: entity!, insertIntoManagedObjectContext: context)
    mapping(map)
  }
  
  override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
    super.init(entity: entity, insertIntoManagedObjectContext: context)
  }
  
  func mapping(map: Map) {
    name      <- map["im:name.label"]
    price     <- map["im:price.attributes.amount"]
    summary   <- map["summary.label"]
    id        <- map["id.attributes.im:id"]
    imageURL  <- map["im:image.2.label"]
  }
}
