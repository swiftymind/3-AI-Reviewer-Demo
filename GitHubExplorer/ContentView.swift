import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserSearchViewModel(
        gitHubService: GitHubService()
    )

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Search section
                VStack(spacing: 12) {
                    TextField("Enter GitHub username", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            viewModel.searchUser()
                        }

                    Button("Search") {
                        viewModel.searchUser()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.searchText.isEmpty || viewModel.isLoading)
                }
                .padding(.horizontal)

                // Content section
                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let user = viewModel.user {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Avatar
                            AsyncImage(url: URL(string: user.avatarURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 50)
                                    .fill(Color.gray.opacity(0.3))
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())

                            VStack(spacing: 8) {
                                Text(user.name ?? user.login)
                                    .font(.title2)
                                    .fontWeight(.bold)

                                Text("@\(user.login)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                if let bio = user.bio {
                                    Text(bio)
                                        .font(.body)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                }
                            }

                            // Stats
                            HStack(spacing: 20) {
                                VStack(spacing: 4) {
                                    Text("\(user.publicRepos)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Repos")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                VStack(spacing: 4) {
                                    Text("\(user.followers)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Followers")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                VStack(spacing: 4) {
                                    Text("\(user.following)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text("Following")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Enter a GitHub username to search")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }

                Spacer()
            }
            .navigationTitle("GitHub Explorer")
        }
    }
}

/// View for displaying user details
private struct UserDetailView: View {
    let user: GitHubUser

    var body: some View {

    }
}

/// View for displaying a stat with title and value
private struct StatView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(spacing: 4) {
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    ContentView()
}
