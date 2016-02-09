import Foundation
import Alamofire
import ObjectMapper
import MagicalRecord

/**
  Contains all `App` request-related logic.

  - author: Julian Builes
*/
class AppRepository {
  
  /**
   Fetches the first 20 top free applications from the ios app store.
   
   - parameter completion: The completion block
   */
  class func GETapps(completion:(apps: [App]?, requestError: NSError?) -> Void) {
    
    if Reachability.isConnectedToNetwork() {
      
      AppRepository.deleteOldApps()
      
      Alamofire.request(.GET, "https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json")
        .validate()
        .responseJSON { response in
          switch response.result {
          case .Success:
            if let JSON = response.result.value, JSONFeed = JSON["feed"], JSONapps = JSONFeed?["entry"],
              apps = Mapper<App>().mapArray(JSONapps) {
                // for time constraint reasons, we delete all previous entries and save all new ones
                // ideally we should only persist entries that haven't already been persisted
                AppRepository.persistApps(apps)
                completion(apps: apps, requestError: nil)
            } else {
              print("Unexpected JSON response structure in response \(response.result)")
              completion(apps: nil, requestError: nil)
            }
          case .Failure(let error):
            print("fetching all entries: \(App.MR_findAll()![0])")
            print("failed to serialize request with error \(error)")
            completion(apps: nil, requestError: error)
          }
      }
    } else {
      if let apps = App.MR_findAll() as? [App] {
        completion(apps: apps, requestError: nil)
      } else {
        print("did not get apps")
      }
    }
  }
  
  /**
   - paramter apps: The `App`s to save
   
   Persists the provided apps.
   */
  private class func persistApps(apps: [App]) {
    NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion({
      (complete, error) -> Void in
      if error != nil {
         print("Unable to save with error: \(error)")
      }
    })
  }
  
  /**
    Deletes old apps before the new ones are fetched.
  */
  private class func deleteOldApps() {
    if let oldApps = App.MR_findAll() as? [App] {
      for app in oldApps {
        app.MR_deleteEntity()
      }
    }
  }
  
}
