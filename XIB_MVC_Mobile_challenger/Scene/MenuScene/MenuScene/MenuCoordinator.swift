import Foundation
import UIKit
import SideMenu
import SwiftUI
// swiftlint:disable line_length

class MenuCoordinator: Coordinator {
    var navigationController: UINavigationController
    var view: UIView
    private var sideMenu: SideMenuNavigationController?
    init(navigationController: UINavigationController, view: UIView) {
        self.navigationController = navigationController
        self.view = view
    }

    func start() {
        let viewController = makeSideMenu(with: view)
        navigationController.present(viewController, animated: true, completion: nil)
    }

    private func makeSideMenu(with view: UIView) -> UIViewController {
        let menu = MenuViewController(with: MenuModel.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu?.menuWidth = 300
        guard let viewController = sideMenu else {
            fatalError()
        }
        return viewController
    }

    private func showRepositories(with language: String) {
        let repositoryCoordinator = RepositoriesListCoordinator(navigationController: self.navigationController, language: language)
        repositoryCoordinator.start()
    }

    private func showSavedPullrequest() {
        let savedCoordinator = SaveCoordinator(navigationController: navigationController)
        savedCoordinator.start()
    }
}
extension MenuCoordinator: MenuViewControllerDelegate {
    func didSelectMenuOption(named: MenuModel) {
        sideMenu?.dismiss(animated: true, completion: {
            switch named {
            case .home:
                break
            case .java:
                self.showRepositories(with: named.rawValue)
            case .csharp:
                self.showRepositories(with: named.rawValue)
            case .swift:
                self.showRepositories(with: named.rawValue)
            case .python:
                self.showRepositories(with: named.rawValue)
            case .saved:
                self.showSavedPullrequest()
            case .exit:
                return
            }
        })
    }
}
