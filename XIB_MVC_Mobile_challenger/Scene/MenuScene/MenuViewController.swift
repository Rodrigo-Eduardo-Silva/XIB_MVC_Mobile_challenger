import UIKit
protocol MenuViewControllerDelegate : AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOptions)
}

class MenuViewController: UIViewController {
    weak var delegate: MenuViewControllerDelegate?
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case java = "Java"
        case csharp = "C#"
        case swift = "Swift"
        case python = "Python"
        case exit = "Sair"
        
        var imageName: String {
            switch self {
            case .home:
                return "home"
            case .java:
                return "pngwing.com"
            case .csharp:
                return "csharp"
            case .swift:
                return "swift"
            case .python:
                return "Python.svg.png"
            case .exit:
                return "rectangle.portrait.and.arrow.right"
            }
        }
    }

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
        title = "Select the language for seach"
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
        cell.textLabel?.textColor = .white
        var image =  UIImage(named: MenuOptions.allCases[indexPath.row].imageName)
        if image == nil {
            image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        }
        cell.imageView?.image = image
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        return cell
    }
}
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
