//
//  OnlineCheckInView.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import SwiftUI

struct OnlineCheckInView: View {
    @StateObject private var viewModel = OnlineCheckInViewModel()
    @FocusState private var focusedField: Field?
    @State private var isFirstAppear: Bool = true

    enum Field {
        case pnr, lastName
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: secondaryColor)
                    .ignoresSafeArea()

                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("ONLINE\nCHECK-IN")
                                .helveticaFont(size: 32, weight: .bold)
                                .textCase(.uppercase)
                                .foregroundColor(.white)
                                .padding(.top, 32)

                            Spacer()

                            VStack(alignment: .leading, spacing: 8) {
                                Text("PNR")
                                    .helveticaFont(size: 18, weight: .medium)
                                    .foregroundColor(.white)
                                TextField("Enter PNR", text: $viewModel.pnr)
                                    .textFieldStyle(.roundedBorder)
                                    .focused($focusedField, equals: .pnr)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Last Name")
                                    .foregroundColor(.white)
                                    .helveticaFont(size: 18, weight: .medium)
                                TextField("Enter Last Name", text: $viewModel.lastName)
                                    .textFieldStyle(.roundedBorder)
                                    .focused($focusedField, equals: .lastName)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            }

                            Spacer(minLength: 100)
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)

                    NavigationLink(
                        destination: PassengerDetailsView(viewModel: PassengerDetailsViewModel(detail: viewModel.passengerDetail)),
                        isActive: $viewModel.navigateToDetails
                    ) {
                        EmptyView()
                    }

                    Button(action: {
                        // Trigger check-in
                        viewModel.buttonContinueAction()
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                if viewModel.isLoading {
                    LoadingView()
                }
            }
            .onAppear {
                if isFirstAppear {
                    isFirstAppear = false
                    viewModel.requestToken()
                }
            }
        }
    }
}

#Preview {
    OnlineCheckInView()
}
