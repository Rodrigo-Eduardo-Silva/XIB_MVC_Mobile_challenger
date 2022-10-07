import UIKit
import MapKit
import Foundation
// swiftlint:disable line_length
protocol RepositoriesListViewControllerDelegate: AnyObject {
    func didSelectRepository(repository: GitRepository)
}

class RepositoriesListViewController: UIViewController {

    weak var delegate: RepositoriesListViewControllerDelegate?
    @IBOutlet weak var tableview: UITableView!

    var model: RepositoriesListModel?
    var totalrepositories: GitHead!
    var repositories: [GitRepository] {
        model?.repositories ?? []
    }

     var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()

    var language: String
    init(language: String) {
        self.language = language
        super.init(nibName: "RepositoriesListViewController", bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Carregando Repositórios.Aguarde..."
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(RepositoriesListTableViewCell.nib,
                           forCellReuseIdentifier: RepositoriesListTableViewCell.cell)

       // model?.delegate = self
        loadRepositories()
    }

    private func loadRepositories() {
        model?.loadRepositories(language: language)
    }

    func showPullrequest(repository: GitRepository) {
        delegate?.didSelectRepository(repository: repository)
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
        if indexPath.row == repositories.count - 2 && !(model?.rechargeList ?? true) && repositories.count != model?.totalrepository {
            model?.currentPage += 1
            model?.loadRepositories(language: language)
            print("Total de Repositórios: \(String(describing: model?.totalrepository)) , Já Inclusos : \(repositories.count)")
        }
    }
}

extension RepositoriesListViewController: RepositoriesListModelDelegate {
    func internetMessage(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: message, message: "Verifique a conexão com a internet , o aplicativo será encerrado", preferredStyle: .alert)
            let button = UIAlertAction(title: "OK", style: .default) { _ in
                exit(0)
            }
            alert.addAction(button)
            self.present(alert, animated: true, completion: nil)
            print("teste")
        }
    }

    func updateRepositoriesModel() {
        DispatchQueue.main.async { [weak self] in
            self?.tableview.reloadData()
            self?.model?.rechargeList = false
         }
    }
}
