import Foundation
import UIKit

class RepositoriesListCoordinator: Coordinator {
    var navigationController: UINavigationController?
    private var viewController: RepositoriesListViewController?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func eventOccured(with type: Event) {
        
    }
    func start() {
        let repositoriesViewController = makeRepositoriesListViewController(langage: <#T##String#>)
        
    }
    private func makeRepositoriesListViewController(langage: String) -> RepositoriesListViewController {
        let viewController = RepositoriesListViewController(language: langage)
        let model = RepositoriesListModel()
        model.delegate = viewController
        viewController.model = model
        return viewController
    }
}
