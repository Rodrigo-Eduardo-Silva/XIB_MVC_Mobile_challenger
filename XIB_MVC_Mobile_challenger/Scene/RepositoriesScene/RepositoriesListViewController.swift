import UIKit

class RepositoriesListViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var model = RepositoriesListModel()
    var repositories: [GitRepository] {
        model.repositories
    }
    var totalrepositories: GitHead!
    var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando Repositórios.Aguarde..."
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(RepositoriesListTableViewCell.nib, forCellReuseIdentifier: RepositoriesListTableViewCell.cell)
        model.delegate = self
        model.loadRepositories()
}
    func showPullrequest(repository: GitRepository) {
        let repository = repositories[tableview.indexPathForSelectedRow!.row]
        let viewController = PullrequestListViewController.create(repository: repository)
        viewController.modalPresentationStyle  = .fullScreen
        navigationController?.pushViewController(viewController, animated: true)
    }
}
// MARK: - Table view data source
extension RepositoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundView = repositories.count == 0 ? label : nil
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
// MARK: - Table view delegate
extension RepositoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        showPullrequest(repository: repository)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 2 && !model.rechargeList && repositories.count != model.totalrepository {
            model.currentPage += 1
            model.loadRepositories()
            print("Total de Repositórios: \(model.totalrepository) , Já Inclusos : \(repositories.count)")
        }
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
