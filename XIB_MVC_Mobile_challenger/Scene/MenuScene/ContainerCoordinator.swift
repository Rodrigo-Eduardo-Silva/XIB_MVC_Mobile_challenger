import Foundation
import UIKit

class ContainerCoordinator: Coordinator {
    var navigationController: UINavigationController?
    private var viewController: ContainerViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func eventOccured(with type: Event) {

    }

    func start() {
        let containerViewController = ContainerViewController()
        self.viewController = containerViewController
        navigationController?.pushViewController(containerViewController, animated: true)
    }
}
