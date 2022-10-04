import Foundation
import UIKit

class RepositoriesListCoordinator: Coordinator {
    var navigationController: UINavigationController
    var language: String
    var childCoordinator: Coordinator?
    private var viewController: RepositoriesListViewController?
    init(navigationController: UINavigationController, language: String) {
        self.language = language
        self.navigationController = navigationController
    }

    func start() {
        let viewController = makeRepositoriesListViewController()
        self.viewController = viewController
        navigationController.pushViewController(viewController, animated: true)
    }

    func makeRepositoriesListViewController() -> RepositoriesListViewController {
        let viewController = RepositoriesListViewController(language: language)
        let model = RepositoriesListModel()
        model.delegate = viewController
        viewController.model = model
        viewController.delegate = self
        return viewController
    }
}

extension RepositoriesListCoordinator: RepositoriesListViewControllerDelegate {
     func didSelectRepository(repository: GitRepository) {
        let coordinator = PullrequestListCoordinator(navigationController: navigationController, repository: repository)
        coordinator.start()
        self.childCoordinator = coordinator
    }
}
