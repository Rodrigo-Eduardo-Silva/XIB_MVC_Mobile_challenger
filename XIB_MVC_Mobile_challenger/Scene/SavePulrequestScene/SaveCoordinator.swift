import UIKit

class SaveCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: Coordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = showSavedPullrequest()
        navigationController.pushViewController(viewController, animated: true)
    }
    func showSavedPullrequest() -> SaveViewController {
        let viewController = SaveViewController()
        return viewController
    }

}
