import UIKit

/**
 Displays an app's information.
 
 - Author: Julian Builes
*/
class AppDetailVC: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!

  var detailItem: AnyObject? {
    didSet {
        self.configureView()
    }
  }

  func configureView() {
    if let detail = self.detailItem {
        if let label = self.detailDescriptionLabel {
            label.text = detail.valueForKey("timeStamp")!.description
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

