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

    }

    func didTapMenuButton() {
        delegate?.showMenu(view: view)
    }

    @IBAction func shoeSideMenu(_ sender: Any) {
        didTapMenuButton()
    }
}
