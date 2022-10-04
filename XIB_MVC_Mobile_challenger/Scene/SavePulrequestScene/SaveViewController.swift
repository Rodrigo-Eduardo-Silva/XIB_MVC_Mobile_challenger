import UIKit
import CoreData
import SafariServices
// swiftlint:disable line_length
// swiftlint:disable switch_case_alignment
class SaveViewController: UIViewController {

    var fetchResultController: NSFetchedResultsController<PullrequestSaved>!
    @IBOutlet weak var tableView: UITableView!
    init() {

        super.init(nibName: "SaveViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerPullCells()
        tableView.delegate = self
        tableView.dataSource = self
        loadSavedPullrequest()
    }
    func registerPullCells() {
        let nib = UINib(nibName: SaveTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SaveTableViewCell.identifier)
    }
    func loadSavedPullrequest() {
        let fetchRequest: NSFetchRequest<PullrequestSaved> = PullrequestSaved.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension SaveViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = fetchResultController.fetchedObjects?.count ?? 0
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: SaveTableViewCell.identifier, for: indexPath) as? SaveTableViewCell else {
            fatalError()
        }
        guard let pullrequest = fetchResultController.fetchedObjects?[indexPath.row] else {
            return cell
        }
        cell.preparePullrequestSaved(with: pullrequest)
     return cell
   }
}
// MARK: - Table view Delegate
extension SaveViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pullrequest = fetchResultController.fetchedObjects?[indexPath.row]
        let pathURL = pullrequest?.html_url ?? ""
        guard let url = URL(string: pathURL) else {
            fatalError()
        }
        let webviewController = SFSafariViewController(url: url)
        present(webviewController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let pullrequest = fetchResultController.fetchedObjects?[indexPath.row] else {return}
            context.delete(pullrequest)
        }
    }

}

extension SaveViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert:
                tableView.reloadData()
            case .delete:
                if let indexPath = indexPath {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            case .move:
                tableView.reloadData()
            case .update:
                tableView.reloadData()
            @unknown default:
                print("erro")
        }
    }

}
extension SaveViewController {
    var context: NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("No context object found")
        }
        return appDelegate.persistentContainer.viewContext
    }

}
