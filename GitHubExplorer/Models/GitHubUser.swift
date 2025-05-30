import Foundation

/// Represents a GitHub user from the API
struct GitHubUser: Codable, Identifiable, Equatable {
    let id: Int
    let login: String
    let avatarURL: String
    let htmlURL: String
    let name: String?
    let bio: String?
    let publicRepos: Int
    let followers: Int
    let following: Int

    private enum CodingKeys: String, CodingKey {
        case id, login, name, bio, followers, following
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case publicRepos = "public_repos"
    }
}