
import UIKit
import SideMenu
import SwiftUI
protocol ContainerViewControllerDelegate: AnyObject {
    func ShowSideMenu()
}

class ContainerViewController: UIViewController {
    private var sideMenu: SideMenuNavigationController?
    @IBOutlet weak var containerTabbar: UINavigationBar!
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
    
    func didTapMenuButton() {
        guard let viewController = sideMenu else {
            fatalError()
        }
        navigationController?.present(viewController, animated: true, completion: nil)
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
    
    func ShowHome(){
        let viewController = HomeViewController()
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    @IBAction func shoeSideMenu(_ sender: Any) {
        didTapMenuButton()
    }
    
}

extension ContainerViewController : MenuViewControllerDelegate {
    func didSelectMenuOption(named: menuOptions) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            switch named {
            case .home:
                self?.ShowHome()
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
