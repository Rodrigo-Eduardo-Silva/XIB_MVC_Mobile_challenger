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
    let RepositoriesVC = RepositoriesListViewController()
    var navigatorVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        addChildVC()
    }
    func addChildVC(){
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
        print("did")
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
                self.ShowRepositories()
            case .appRating:
                break
            case .shareApp:
                break
            case .settings:
                break
            }
    }
    func ShowRepositories(){
        let vc = RepositoriesVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    func resetHome(){
        RepositoriesVC.view.removeFromSuperview()
        RepositoriesVC.didMove(toParent: self)
        homeVC.title = "Home"
    }
    
}
