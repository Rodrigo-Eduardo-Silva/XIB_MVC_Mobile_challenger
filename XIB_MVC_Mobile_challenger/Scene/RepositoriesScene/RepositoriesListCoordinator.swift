import Foundation
import UIKit
protocol RepositoriesListCoordinatorDelegate: AnyObject {
    func addChildViewController(_ viewController: RepositoriesListViewController)
}

class RepositoriesListCoordinator: Coordinator {
    weak var delegate: RepositoriesListCoordinatorDelegate?
    var navigationController: UINavigationController
    var language: String
    private var viewController: RepositoriesListViewController?
    init(navigationController: UINavigationController, language: String) {
        self.language = language
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RepositoriesListViewController(language: language)
//        self.viewController = viewController
        delegate?.addChildViewController(viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func makeRepositoriesListViewController() -> RepositoriesListViewController {
        let viewController = RepositoriesListViewController(language: language)
//        let model = RepositoriesListModel()
//        model.delegate = viewController
//        viewController.model = model
        return viewController
    }
}
