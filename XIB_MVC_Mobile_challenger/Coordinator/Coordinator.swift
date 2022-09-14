import Foundation
import UIKit
enum Event {
    case cellSelected
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController?  { get set }
    
    func eventOccured(with type: Event)
    func start()
}
