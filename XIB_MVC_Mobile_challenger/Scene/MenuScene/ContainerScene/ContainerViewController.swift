import UIKit
import SideMenu
import SwiftUI
protocol ContainerViewControllerDelegate: AnyObject {
    func showMenu(view: UIView)
}

class ContainerViewController: UIViewController {
    private var sideMenu: SideMenuNavigationController?
    weak var delegate: ContainerViewControllerDelegate?
    var menu = MenuViewController(with: MenuModel.allCases)
    @IBOutlet weak var containerTabbar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
//         menu.delegate = self
//        let menu = MenuViewController(with: MenuModel.allCases)
//        menu.delegate = self
//        sideMenu = SideMenuNavigationController(rootViewController: menu)
//        sideMenu?.leftSide = true
//        SideMenuManager.default.leftMenuNavigationController = sideMenu
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
//        sideMenu?.menuWidth = 300
    }

    func didTapMenuButton() {
        delegate?.showMenu(view: view)
//        guard let viewController = sideMenu else {
//            fatalError()
//        }
//        navigationController?.present(viewController, animated: true, completion: nil)
    }

    func showRepositories(with language: String) {
//        let navigation = UINavigationController()
//        let repositoryView = RepositoriesListCoordinator(navigationController: navigation, language: language)
//        repositoryView.start()
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

    func showHome() {
        let viewController = HomeViewController()
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    @IBAction func shoeSideMenu(_ sender: Any) {
        didTapMenuButton()
    }
}

// extension ContainerViewController: MenuViewControllerDelegate {
//    func didSelectMenuOption(named: MenuModel) {
//        sideMenu?.dismiss(animated: true, completion: { [weak self] in
//            switch named {
//            case .home:
//                self?.showHome()
//            case .java:
//                self?.showRepositories(with: named.rawValue)
//            case .csharp:
//                self?.showRepositories(with: named.rawValue)
//            case .swift:
//                self?.showRepositories(with: named.rawValue)
//            case .python:
//                self?.showRepositories(with: named.rawValue)
//            case .saved:
//                self?.showSaveRepository()
//            case .exit:
//                return
//            }
//        })
//    }
// }
