import Foundation

struct GitHead: Codable {
    let total_count: Int
    let items: [GitRepository]
}
