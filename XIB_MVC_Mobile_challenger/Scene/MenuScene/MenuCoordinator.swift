import Foundation
import UIKit
import SideMenu
import SwiftUI

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

}
//
