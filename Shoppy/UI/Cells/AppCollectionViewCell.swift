import UIKit
import AlamofireImage

/**
  Displays an `App`'s details in a collection view.

- author: Julian Builes
*/
class AppCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var imageView: UIImageView?
  
  func configureCellWithApp(app: App) {
    titleLabel?.text = app.name
    if let URL = NSURL(string: app.imageURL!) {
      imageView?.af_setImageWithURL(URL)
//      print(URL)
//      print(imageView)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView?.layer.masksToBounds = true
    imageView?.layer.cornerRadius = 7
    imageView?.layer.borderWidth = 0
    imageView?.layer.borderColor = UIColor.clearColor().CGColor
    
    imageView?.alpha = 0
    UIView.animateWithDuration(1.2, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
      self.imageView?.alpha = 1
      }) { (completed) -> Void in
        
    }
  }
}
