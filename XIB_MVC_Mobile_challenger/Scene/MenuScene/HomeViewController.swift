import UIKit
import SideMenu
import SwiftUI

class HomeViewController: UIViewController {
    
    private var sideMenu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuViewController(with: menuOptions.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu?.menuWidth = 300
   
    }
    
    @IBAction func ditTapMenuButton(_ sender: Any) {
        guard let viewController = sideMenu else {
            fatalError()
        }
        navigationController?.present(viewController, animated: true, completion: nil)
        print("did tap")
    }
    
    func showRepositories(with language: String) {
        let viewController = RepositoriesListViewController(language: language)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    func showSaveRepository() {
        let viewController = SaveViewController()
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}

extension HomeViewController : MenuViewControllerDelegate {
    func didSelectMenuOption(named: menuOptions) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            switch named {
            case .home:
                return
            case .java:
                self?.showRepositories(with: named.rawValue)
            case .csharp:
                self?.showRepositories(with: named.rawValue)
            case .swift:
                self?.showRepositories(with: named.rawValue)
            case .python:
                self?.showRepositories(with: named.rawValue)
            case .saved:
                self?.showSaveRepository()
            case .exit:
                return
            }
        })
    }
}
