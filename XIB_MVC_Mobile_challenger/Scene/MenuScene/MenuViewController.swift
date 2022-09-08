import UIKit
import SideMenu
protocol MenuViewControllerDelegate: AnyObject {
    func didSelectMenuOption(named: menuOptions)
}

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let menuOptions: [menuOptions]
    private let color = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    weak var delegate: MenuViewControllerDelegate?
    
    init(with menuOptions: [menuOptions]){
        self.menuOptions = menuOptions
        
        super.init(nibName: nil, bundle: nil)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = color
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = color
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName:menuOptions[indexPath.row].imageName)
        print(menuOptions[indexPath.row].imageName)
        cell.textLabel?.text = menuOptions[indexPath.row].rawValue
        return cell
    }
}
extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = menuOptions[indexPath.row]
        delegate?.didSelectMenuOption(named: selectedOption)
    }
}
