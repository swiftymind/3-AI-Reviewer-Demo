import Foundation

/// Protocol defining GitHub API operations
protocol GitHubServiceProtocol {
    /// Searches for a GitHub user by username
    /// - Parameter username: The GitHub username to search for
    /// - Returns: A GitHubUser if found
    /// - Throws: NetworkError or other errors that may occur during the request
    func searchUser(username: String) async throws -> GitHubUser
}

/// Errors that can occur during network operations
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case userNotFound
    case invalidResponse
    case decodingError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .userNotFound:
            return "User not found"
        case .invalidResponse:
            return "Invalid response"
        case .decodingError:
            return "Failed to decode response"
        }
    }
}