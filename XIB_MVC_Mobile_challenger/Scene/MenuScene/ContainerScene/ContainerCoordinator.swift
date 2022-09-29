import Foundation
import UIKit

class ContainerCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator: Coordinator?
    private var viewController: ContainerViewController?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let containerViewController = ContainerViewController()
        containerViewController.delegate = self
        self.viewController = containerViewController
        navigationController.pushViewController(containerViewController, animated: true)
        childCoordinator = containerViewController as? Coordinator
    }
}
extension ContainerCoordinator: ContainerViewControllerDelegate {
    func showMenu(view: UIView) {
        let coodirnator = MenuCoordinator(navigationController: navigationController, view: view)
        coodirnator.start()
        self.childCoordinator = coodirnator
    }
}
