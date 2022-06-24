import Foundation

struct GitRepository: Codable {
    let id: Int
    let name: String
    let full_name: String
    let stargazers_count: Int
    let forks: Int
    let description: String?
    let owner: Owner
}
