import Foundation

/// Concrete implementation of GitHub API service
final class GitHubService: GitHubServiceProtocol {
    private let session: URLSession
    private let baseURL = "https://api.github.com"

    /// Initializes the service with a URLSession
    /// - Parameter session: URLSession to use for network requests
    init(session: URLSession = .shared) {
        self.session = session
    }

    /// Searches for a GitHub user by username using modern Swift concurrency
    /// - Parameter username: The GitHub username to search for
    /// - Returns: A GitHubUser if found
    /// - Throws: NetworkError or other errors that may occur during the request
    func searchUser(username: String) async throws -> GitHubUser {
        guard let url = URL(string: "\(baseURL)/users/\(username)") else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200:
                break
            case 404:
                throw NetworkError.userNotFound
            default:
                throw NetworkError.invalidResponse
            }

            guard !data.isEmpty else {
                throw NetworkError.noData
            }

            do {
                let user = try JSONDecoder().decode(GitHubUser.self, from: data)
                return user
            } catch {
                throw NetworkError.decodingError
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}