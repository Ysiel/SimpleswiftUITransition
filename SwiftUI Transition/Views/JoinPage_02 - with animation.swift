import SwiftUI

private enum JoinViewState {
    case welcome // initial state
    case waiting // waiting for network operation
    case success // success
}

struct JoinPage_02 {
    @State private var viewState: JoinViewState = .welcome
    @State private var username: String = "Yoan"
}

extension JoinPage_02: View {
    var body: some View {
        VStack {
            switch viewState {
            case .welcome:
                welcomeView  // implicit .transition(.opacity)
            case .waiting:
                waitingView  // implicit .transition(.opacity)
            case .success:
                successView  // implicit .transition(.opacity)
            }
        }
        .background(Color.blue.opacity(0.5))
    }

    private func join() async {
        withAnimation { viewState = .waiting }  // implicit .default animation

        try? await pauseTask(1) // Simulates a network call

        withAnimation { viewState = .success }  // implicit .default animation
    }
}

extension JoinPage_02 {
    private var welcomeView: some View {
        VStack {
            VStack(spacing: .mediumMargin) {
                Text("Hello Friend")
                    .font(.largeTitle)
                    .foregroundColor(.primary)

                Text("please enter your information")
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .largeMargin)
                    .padding(.bottom, .mediumMargin)

                TextField("User name (email address)", text: $username)
                    .padding(.smallMargin)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(10)

                Button("Join the network") { Task { await join() } }
                    .buttonStyle(.bordered)
            }
            .frame(maxWidth: 350) // Magic number for large screens
            .padding(.top, .xLargeMargin)
            .padding(.horizontal, .largeMargin)

            Spacer().frame(maxHeight: .infinity)
        }
    }

    private var successView: some View {
        VStack {
            Spacer()
            Text("Success").font(.largeTitle).foregroundColor(.accentColor).padding(.mediumMargin)
            Text("🎉🎉🎉").font(.title)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.largeMargin)
    }

    private var waitingView: some View {
        VStack {
            Text("Please Wait")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 370) // Magic number for large screens
                .padding(.horizontal, .largeMargin)

            Spacer().frame(maxHeight: .infinity)
        }
        .padding(.top, .xLargeMargin)
    }
}

extension JoinPage_02 {
    /// Pause a task during a given time in seconds.
    ///
    /// It is a convenience nice to use while we support iOS 15.
    private func pauseTask(_ seconds: UInt64) async throws {
        if #available(iOS 16.0, *) {
            try await Task.sleep(for: .seconds(seconds))
        } else {
            try await Task.sleep(nanoseconds: seconds * 1_000_000_000)
        }
    }
}

struct JJoinPage_02_Previews: PreviewProvider {
    struct HostView: View {
        @State private var showSheet = true

        var body: some View {
            Button("Sign up") { showSheet.toggle() }
                .sheet(isPresented: $showSheet) { JoinPage_02() }
        }
    }

    @ViewBuilder static var views: some View { HostView() }

    static var previews: some View {
        Group {
            views.previewDisplayName("Default Animation")
        }
    }
}
