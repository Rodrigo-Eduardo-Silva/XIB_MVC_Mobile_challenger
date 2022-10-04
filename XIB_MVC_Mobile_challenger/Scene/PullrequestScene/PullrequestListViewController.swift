import UIKit
import SafariServices
// swiftlint:disable line_length

protocol PullrequestListViewControllerDelegate: AnyObject {
    func showDetailPullrequest(url: URL)
}

class PullrequestListViewController: UIViewController {
    var saveModel = SaveModel()
    weak var delegate: PullrequestListViewControllerDelegate?
    @IBOutlet weak var tableView: UITableView!
    var pullrequest: [PullRequest] = []
    var pullmodel: PullRequestListModel?
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    init(model: PullRequestListModel) {
        self.pullmodel = model
        super.init(nibName: "PullrequestListViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = " Não á Pullrequests para esse Repositório"
        registerPullCells()
        pullmodel?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pullmodel?.loadPullRequest()
    }

    func registerPullCells() {
        let nib = UINib(nibName: PullrequestListTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PullrequestListTableViewCell.identifier)
    }
}

extension PullrequestListViewController: PullRequestListModelDelegate {
    func updatePullRequest() {
        guard let pullmodel = pullmodel else {
            return
        }
        pullrequest += pullmodel.pullrequest
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.pullmodel?.rechargeList = false
          }
    }
}

extension  PullrequestListViewController {
    static func create(repository: GitRepository) -> PullrequestListViewController {
        let model = PullRequestListModel(gitRepository: repository, service: PullRequestListService())
        let pullrequestViewController = PullrequestListViewController(model: model)
        pullrequestViewController.title = repository.name
        return pullrequestViewController
    }
}
// MARK: - Table view data source
extension PullrequestListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = pullmodel?.pullrequest.count == 0 ? label : nil
        return pullmodel?.pullrequest.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: PullrequestListTableViewCell.identifier, for: indexPath) as? PullrequestListTableViewCell else {
            fatalError()
        }
        guard let pullrequestCell = pullmodel?.pullrequest[indexPath.row] else {
            fatalError()
        }
        cell.preparePullrequest(with: pullrequestCell, at: indexPath.row)
        cell.delegate = self
        return cell
    }

    func saveAltert(with pullrequest: PullRequest) {
        let title = "Pullrequest Salvo"
        let alert = UIAlertController(title: title, message: pullrequest.title, preferredStyle: .alert)
        let button = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }

}
// MARK: - Table view Delegate
extension PullrequestListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pullrequest = pullmodel?.pullrequest[indexPath.row]
        let pathURL = pullrequest?.user.html_url ?? ""
        guard let url = URL(string: pathURL) else {
            fatalError()
        }
        delegate?.showDetailPullrequest(url: url)
    }
}

extension PullrequestListViewController: PullrequestListTableViewCellDelegate {
    func save(index: Int) {
        guard let pullrequest = pullmodel?.pullrequest[index] else {
        fatalError()
        }
        saveModel.savePullrequest(pullrequest: pullrequest)
        saveAltert(with: pullrequest)
        print("Pullrequest Salvo", index)
    }
}
