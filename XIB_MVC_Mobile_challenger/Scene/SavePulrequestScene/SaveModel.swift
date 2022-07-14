import Foundation
import UIKit
import CoreData
protocol SaveModelDelegate: AnyObject {
    func loadPullrequest()
}

class SaveModel {
    weak var delegate: SaveModelDelegate?

}
