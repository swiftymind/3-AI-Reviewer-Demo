import Foundation
import SwiftUI

/// ViewModel for user search functionality
@MainActor
final class UserSearchViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var searchText = ""
    @Published var user: GitHubUser?
    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Private Properties
    private let gitHubService: GitHubServiceProtocol
    private var searchTask: Task<Void, Never>?

    // MARK: - Initialization
    init(gitHubService: GitHubServiceProtocol) {
        self.gitHubService = gitHubService
    }

    // MARK: - Public Methods
    func searchUser() {
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedText.isEmpty {
            user = nil
            errorMessage = nil
            searchTask?.cancel()
            return
        }

        searchTask?.cancel()

        searchTask = Task {
            isLoading = true
            errorMessage = nil

            do {
                let foundUser = try await gitHubService.searchUser(username: trimmedText)
                user = foundUser
                errorMessage = nil
            } catch {
                user = nil
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }

    func clearResults() {
        user = nil
        errorMessage = nil
        searchTask?.cancel()
    }

    deinit {
        searchTask?.cancel()
    }
}
