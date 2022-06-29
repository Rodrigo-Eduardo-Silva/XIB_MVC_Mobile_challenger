import UIKit

class PullrequestListTableViewController: UITableViewController {

    @IBOutlet weak var tableview: UITableView!
    var pullrequest: [PullRequest] = []
    var pullmodel: PullRequestListModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(PullrequestListTableViewCell.nib, forCellReuseIdentifier: PullrequestListTableViewCell.cell)
        pullmodel?.delegate = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pullmodel?.pullrequest.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableview.dequeueReusableCell(withIdentifier: PullrequestListTableViewCell.cell, for: indexPath) as? PullrequestListTableViewCell else {
            fatalError()
        }
        guard let pullrequestCell = pullmodel?.pullrequest[indexPath.row] else {
            fatalError()
        }
        cell.preparePullrequest(with: pullrequestCell)
        return cell
    }
}
extension PullrequestListTableViewController: PullRequestListModelDelegate {
    func updatePullRequest() {
        guard let pullmodel = pullmodel else {
            return
        }
        pullrequest += pullmodel.pullrequest
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
            self?.pullmodel?.rechargeList = false
          }
    }
}

extension  PullrequestListTableViewController {
    static func create(repository: GitRepository) -> PullrequestListTableViewController {
        let pullscreen = UINib(nibName: "PullrequestListTableViewController", bundle: nil)
        guard let tableviewcontroller = pullscreen.instantiate(withOwner: nil, options: nil) as? PullrequestListTableViewController else {
            fatalError()
        }
        tableviewcontroller.pullmodel = PullRequestListModel(gitRepository: repository, service: PullRequestListService())
        return tableviewcontroller
    }
}
