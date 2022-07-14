import UIKit
import SwiftUI

class ContainerViewController: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    private var menuState: MenuState = .closed
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navigatorVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        addChildVC()
    }
    func addChildVC() {
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        homeVC.delegate = self
        let navigatorVC = UINavigationController(rootViewController: homeVC)
        addChild(navigatorVC)
        view.addSubview(navigatorVC.view)
        navigatorVC.didMove(toParent: self)
        self.navigatorVC = navigatorVC

    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion:(() -> Void)?) {
        switch menuState {

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navigatorVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navigatorVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
              } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
        }
    }
}

extension ContainerViewController: MenuViewControllerDelegate {
    func didSelect(menuItem: MenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
            switch menuItem {
            case .home:
                self.resetHome()
            case .java:
                self.ShowRepositories(with: menuItem.rawValue)
            case .csharp:
                self.ShowRepositories(with: menuItem.rawValue)
            case .swift:
                self.ShowRepositories(with: menuItem.rawValue)
            case .python:
                self.ShowRepositories(with: menuItem.rawValue)
            case .saved:
                self.SavedPullrequest()
            case .exit:
                exit(0)
            }
    }
    func ShowRepositories(with language: String) {
        let repositoriesVC = RepositoriesListViewController(language: language)
        let vc = repositoriesVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    func resetHome() {
        let repositoriesVC = RepositoriesListViewController(language: "")
        repositoriesVC.view.removeFromSuperview()
        repositoriesVC.didMove(toParent: self)
        homeVC.title = "Home"
    }
    func SavedPullrequest() {
        let savedPullrequestVC = SaveViewController()
        homeVC.addChild(savedPullrequestVC)
        homeVC.view.addSubview(savedPullrequestVC.view)
        savedPullrequestVC.view.frame = view.frame
        savedPullrequestVC.didMove(toParent: homeVC)
        homeVC.title =  "PullRequest Salvos"
    }

}
