import UIKit

class RepositoriesListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableview: UITableView!
    var model = RepositoriesListModel()
    var repositories: [GitRepository] {
        model.repositories
    }
    var totalrepositories: GitHead!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(RepositoriesListTableViewCell.nib, forCellReuseIdentifier: RepositoriesListTableViewCell.cell)
        model.delegate = self
        model.loadRepositories()
    }
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: RepositoriesListTableViewCell.cell, for: indexPath) as? RepositoriesListTableViewCell else {
            fatalError()
        }
        let repositoryCell = repositories[indexPath.row]
        cell.prepareRepositoryCell(with: repositoryCell)
        return cell
    }
}

extension RepositoriesListViewController: RepositoriesListModelDelegate {
    func updateRepositoriesModel() {
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
            self?.model.rechargeList = false
         }
    }
}
