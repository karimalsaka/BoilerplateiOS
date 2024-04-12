//
//  HomeView.swift
//  MyApp
//
//  Created by Karim Alsaka on 12/04/2024.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    private var authManager: AuthManager
    
    init(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func signOut() throws {
        try authManager.signOut()
    }
}

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @Binding private var shouldShowSignIn: Bool

    init(viewModel: HomeViewModel, shouldShowSignIn: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._shouldShowSignIn = shouldShowSignIn
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                Task {
                    do {
                        try viewModel.signOut()
                        shouldShowSignIn = true
                    } catch {
                        //MARK: show error alert to user
                        print("error")
                    }
                }
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)

            }
        }
        .padding()
        .navigationTitle("Home")
    }
}

#Preview {
    let viewModel = HomeViewModel(authManager: AuthManager())
    return HomeView(viewModel: viewModel, shouldShowSignIn: .constant(false))
}
