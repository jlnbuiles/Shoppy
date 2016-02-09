import UIKit
import CoreData
import MBProgressHUD

/**
 Displays the app categories.
 
 - Author: Julian Builes
*/
class AppCategoriesTVC: UITableViewController, NSFetchedResultsControllerDelegate {

  // MARK: - properties
  var detailViewController: AppDetailVC? = nil
  var managedObjectContext: NSManagedObjectContext? = nil
  var categories: [AppCategory] = []
  var apps: [App] = []

  // #TEMP: remove for production code. Categories are hard-coded for simplicity's sake.
  private func createDummyCategories() {
    let category = NSEntityDescription.insertNewObjectForEntityForName("AppCategory",
      inManagedObjectContext: managedObjectContext!) as! AppCategory
    category.name = "Games"
    category.resultsCount = 4
    categories.append(category)
    
    let category2 = NSEntityDescription.insertNewObjectForEntityForName("AppCategory",
      inManagedObjectContext: managedObjectContext!) as! AppCategory
    category2.name = "Productivity"
    category2.resultsCount = 3
    categories.append(category2)
    
    let category3 = NSEntityDescription.insertNewObjectForEntityForName("AppCategory",
      inManagedObjectContext: managedObjectContext!) as! AppCategory
    category3.name = "Maps"
    category3.resultsCount = 6
    categories.append(category3)
  }
  
  // MARK: - requests
  private func fetchApps() {
    MBProgressHUD.showHUDAddedTo(self.parentViewController?.view, animated: true).labelText = "loading..."
    AppRepository.GETapps { (apps, requestError) -> Void in
      MBProgressHUD.hideAllHUDsForView(self.parentViewController?.view, animated: true)
      if let apps = apps where apps.count > 0 {
        self.apps = apps
      }
    }
  }
  
  // MARK: - view controller life cycle
  override func viewDidLoad() {

    super.viewDidLoad()
    fetchApps()
    
    if let split = self.splitViewController {
      let controllers = split.viewControllers
      self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? AppDetailVC
    }
    
    createDummyCategories()
  }

  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    if let nav = segue.destinationViewController as? UINavigationController,
      appsCVC = nav.viewControllers[0] as? AppsCVC where segue.identifier == "showDetail" {
        if let indexPath = tableView.indexPathForSelectedRow {
          appsCVC.title = categories[indexPath.row].name
        }
        appsCVC.apps = self.apps
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
  }

  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    if let categoryCell = cell as? AppCategoryCell {
      categoryCell.displayAppCategory(categories[indexPath.row])
    }
  }

}
