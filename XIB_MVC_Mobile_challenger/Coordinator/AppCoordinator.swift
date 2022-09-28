import Foundation
import UIKit
import SideMenu

class AppCoordinator {
    var navigationController: UINavigationController?
    var childCoordinator: Coordinator?
    let window: UIWindow
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
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
        childCoordinator = containerCoordinator
    }

}
