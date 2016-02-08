import UIKit
import CoreData

/**
 Displays the app categories. Categories are hard-coded for simplicity's sake.
 
 - Author: Julian Builes
*/
class AppCategoriesTVC: UITableViewController, NSFetchedResultsControllerDelegate {

  var detailViewController: AppDetailVC? = nil
  var managedObjectContext: NSManagedObjectContext? = nil
  var categories: [AppCategory] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    // #TEMP: remove once done.
    let category = NSEntityDescription.insertNewObjectForEntityForName("AppCategory", inManagedObjectContext: managedObjectContext!) as! AppCategory
    category.name = "Games"
    category.resultsCount = 4
    categories.append(category)
    
    let category2 = NSEntityDescription.insertNewObjectForEntityForName("AppCategory", inManagedObjectContext: managedObjectContext!) as! AppCategory
    category2.name = "Productivity"
    category2.resultsCount = 3
    categories.append(category2)
    
    let category3 = NSEntityDescription.insertNewObjectForEntityForName("AppCategory", inManagedObjectContext: managedObjectContext!) as! AppCategory
    category3.name = "Maps"
    category3.resultsCount = 6
    categories.append(category3)
    
    if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? AppDetailVC
    }
  }

  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func insertNewObject(sender: AnyObject) {
    let context = self.fetchedResultsController.managedObjectContext
    let entity = self.fetchedResultsController.fetchRequest.entity!
    let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context)
         
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    newManagedObject.setValue(NSDate(), forKey: "timeStamp")
         
    // Save the context.
    do {
        try context.save()
    } catch {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        //print("Unresolved error \(error), \(error.userInfo)")
      print("Unable to save context with error: \(error)")
      abort()
    }
  }

  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! AppDetailVC
            controller.detailItem = object
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    return self.fetchedResultsController.sections?.count ?? 0
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    let sectionInfo = self.fetchedResultsController.sections![section]
    return categories.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    self.configureCell(cell, atIndexPath: indexPath)
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
//    let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
    if let categoryCell = cell as? AppCategoryCell {
      categoryCell.displayAppCategory(categories[indexPath.row])
    }
  }

  // MARK: - Fetched results controller

  var fetchedResultsController: NSFetchedResultsController {
      if _fetchedResultsController != nil {
          return _fetchedResultsController!
      }
      
      let fetchRequest = NSFetchRequest()
      // Edit the entity name as appropriate.
      let entity = NSEntityDescription.entityForName("Event", inManagedObjectContext: self.managedObjectContext!)
      fetchRequest.entity = entity
      
      // Set the batch size to a suitable number.
      fetchRequest.fetchBatchSize = 20
      
      // Edit the sort key as appropriate.
      let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
      
      fetchRequest.sortDescriptors = [sortDescriptor]
      
      // Edit the section name key path and cache name if appropriate.
      // nil for section name key path means "no sections".
      let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
      aFetchedResultsController.delegate = self
      _fetchedResultsController = aFetchedResultsController
      
      do {
          try _fetchedResultsController!.performFetch()
      } catch {
           // Replace this implementation with code to handle the error appropriately.
           // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
           //print("Unresolved error \(error), \(error.userInfo)")
           abort()
      }
      
      return _fetchedResultsController!
  }
  
  var _fetchedResultsController: NSFetchedResultsController? = nil

  func controllerWillChangeContent(controller: NSFetchedResultsController) {
      self.tableView.beginUpdates()
  }

  func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
      switch type {
          case .Insert:
              self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
          case .Delete:
              self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
          default:
              return
      }
  }

  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
      switch type {
          case .Insert:
              tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
          case .Delete:
              tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
          case .Update:
              self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, atIndexPath: indexPath!)
          case .Move:
              tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
              tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
      }
  }

  func controllerDidChangeContent(controller: NSFetchedResultsController) {
      self.tableView.endUpdates()
  }

  /*
   // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
   
   func controllerDidChangeContent(controller: NSFetchedResultsController) {
       // In the simplest, most efficient, case, reload the table view.
       self.tableView.reloadData()
   }
   */

}

