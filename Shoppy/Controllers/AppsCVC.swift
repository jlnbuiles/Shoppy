import Foundation
import UIKit

/**
Displays a category's apps.

- author: Julian Builes
*/
class AppsCVC: UICollectionViewController {
  
  // MARK: - properties
  var apps: [App] = []
  private let reuseIdentifier = "AppCell"
  
  // MARK: - view controller life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.whiteColor()
    navigationController?.view.backgroundColor = UIColor.whiteColor()
    view.frame = CGRectMake(-600, view.frame.origin.y, view.frame.width, view.frame.height)
    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.60, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: { () -> Void in
      self.view.frame = CGRectMake(0, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height)
      }) { (completed) -> Void in
    }
  }
  
  // MARK: - UICollectionView methods
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return apps.count
  }
  
  override func collectionView(collectionView: UICollectionView,
    cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier,
        forIndexPath: indexPath) as! AppCollectionViewCell
      cell.configureCellWithApp(apps[indexPath.row])
      return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)

    if let appDetailVC = segue.destinationViewController as? AppDetailVC {
        
      let cell = sender as! AppCollectionViewCell
      if let indexPath = self.collectionView!.indexPathForCell(cell) {
        appDetailVC.app = apps[indexPath.row]
      }
    }
  }
}