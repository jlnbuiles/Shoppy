import UIKit

/**
 Displays an app's information.
 
 - Author: Julian Builes
*/
class AppDetailVC: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!

  var app: App? {
    didSet {
        self.configureView()
    }
  }

  func configureView() {
    title = app?.name
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
