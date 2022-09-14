import Foundation
enum menuOptions: String, CaseIterable {
    case home = "Home"
    case java = "Java"
    case csharp = "C#"
    case swift = "Swift"
    case python = "Python"
    case saved = "Pullrequest Salvos"
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
        case .saved:
            return "save"
        case .exit:
            return "rectangle.portrait.and.arrow.right"
        }
    }
}



