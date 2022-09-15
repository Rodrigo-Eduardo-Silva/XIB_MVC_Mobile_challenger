import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController?
    let window: UIWindow
    var childCoordinator: Coordinator?

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController

    }

    func eventOccured(with type: Event) {

    }

    func start() {
        let navigationController = UINavigationController()
        window.frame = UIScreen.main.bounds
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        startContainer(navigationController)
    }

    fileprivate func startContainer(_ navigationController: UINavigationController) {
        let containerCoordinator = ContainerCoordinator(navigationController: navigationController)
        containerCoordinator.start()
        self.childCoordinator = containerCoordinator
    }

}
