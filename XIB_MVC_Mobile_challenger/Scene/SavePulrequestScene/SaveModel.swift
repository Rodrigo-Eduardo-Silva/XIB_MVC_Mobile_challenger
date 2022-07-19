import Foundation
import UIKit
import CoreData
class SaveModel {
    var pullrequest: PullrequestSaved!
    
    func savePullrequest(pullrequest: PullRequest) {
        self.pullrequest = PullrequestSaved(context: context)
        self.pullrequest.title = pullrequest.title
        self.pullrequest.body = pullrequest.user.body
        self.pullrequest.avatar_url = pullrequest.user.avatar_url
        self.pullrequest.html_url = pullrequest.user.html_url
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }

}
extension SaveModel {
    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No context object found")
        }
        return appDelegate.persistentContainer.viewContext
    }
}
