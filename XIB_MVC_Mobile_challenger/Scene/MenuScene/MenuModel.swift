import Foundation
import UIKit

protocol MenuViewModelDelegate: AnyObject {
    func didSelectMenuItem(named: menuOptions)
}


class MenuViewModel {
    
    weak var delegate: MenuViewModelDelegate?
    
    
}
