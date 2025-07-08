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
    @Environment(\.dismiss) var dismiss

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
                                .foregroundColor(.white)
                                .padding(.top, 32)

                            Spacer()

                            VStack(alignment: .leading, spacing: 8) {
                                Text("PNR")
                                    .helveticaFont(size: 18, weight: .medium)
                                    .foregroundColor(.white)

                                TextField("Enter PNR", text: $viewModel.pnr)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                                    .focused($focusedField, equals: .pnr)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            }

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Last Name")
                                    .foregroundColor(.white)
                                    .helveticaFont(size: 18, weight: .medium)

                                TextField("Enter Last Name", text: $viewModel.lastName)
                                    .padding(.horizontal)
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )
                                    .focused($focusedField, equals: .pnr)
                                    .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 1)
                            }

                            Spacer(minLength: 100)
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)

                    Button(action: {
                        // Trigger check-in
                        viewModel.buttonContinueAction()
                    }) {
                        Text("Continue")
                            .helveticaFont(size: 18, weight: .bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
//                    .alert(viewModel.errorTitle, isPresented: $viewModel.showErrorAlert) {
//                        Button("OK", role: .cancel) {
//                            dismiss()
//                        }
//                    } message: {
//                        Text(viewModel.errorMessage)
//                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)

                .navigationDestination(isPresented: $viewModel.navigateToDetails) {
                    if let detail = viewModel.passengerDetail {
                        PassengerDetailsView(viewModel: PassengerDetailsViewModel(detail: detail))
                    }
                }

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
