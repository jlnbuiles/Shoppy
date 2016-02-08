import Foundation
import UIKit

/**
 Displays an app category.

 - author: Julian Builes
*/
class AppCategoryCell: UITableViewCell {
  
  // MARK: - initializers
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureCell()
  }
  
  // MARK: - ui configuration
  private func configureCell() {
    detailTextLabel?.textColor = UIColor.grayColor()
  }
  
  // MARK: - display category
  /**
   Displays the provided category.
   
   If no category `name` is provided, "Unspecified" is displayed as the name.
   */
  func displayAppCategory(category: AppCategory) {
    
    if let name = category.name where !name.isEmpty {
      textLabel?.text = name
    } else {
      textLabel?.text = "Unspecified"
    }
    
    detailTextLabel?.text = category.resultsCount > 0
      ? "\(category.resultsCount) results" : ""
  }
}