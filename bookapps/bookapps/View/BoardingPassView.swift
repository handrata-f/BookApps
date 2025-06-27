//
//  BoardingPassView.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import SwiftUI

struct BoardingPassView: View {
    @ObservedObject var viewModel: BoardingPassViewModel

    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack(spacing: 20) {
                        HStack(alignment: .top) {
                            Text("Boarding\nPass")
                                .helveticaFont(size: 32, weight: .bold)
                                .padding(.top, 32)

                            Spacer()
                        }


                        Spacer()

                        ForEach(viewModel.boardingPasInfos.indices, id: \.self) { index in
                            BoardingPassCard(info: viewModel.boardingPasInfos[index])
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            if viewModel.isLoading {
                LoadingView()
            }
        }

        .onAppear {
            viewModel.fetchBoardingPass()
        }
        .navigationBarHidden(true)
    }
}

struct BoardingPassCard: View {
    let info: BoardingPassInfo

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading) {
                HStack {
                    Text(info.fullName.uppercased())
                        .helveticaFont(size: 18, weight: .medium)
                        .foregroundColor(.white)

                    Spacer()
                }
                .padding(20)
            }
            .background(Color(hex: primaryColor))

            VStack(spacing: 16) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(info.flightInfo)
                            .helveticaFont(size: 16)
                        Text(info.gate) // static gate zone, optional to bind
                            .helveticaFont(size: 22, weight: .bold)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("SEAT")
                            .helveticaFont(size: 16)

                        Text(info.seat)
                            .helveticaFont(size: 22, weight: .bold)
                    }
                }

                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 1)
                    .overlay(
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [3]))
                            .foregroundColor(Color(hex: primaryColor))
                    )
                    .padding(.zero)

                HStack {
                    Text(info.departureAirport)
                        .helveticaFont(size: 18, weight: .medium)

                    Spacer()
                    Text(info.arrivalAirport)
                        .helveticaFont(size: 18, weight: .medium)
                }

                Image(uiImage: generateBarcode(from: info.barcode) ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: .infinity)

                Spacer()
            }
            .padding()
            .background(Color(hex: primaryColor).opacity(0.1))

        }
        .background(Color(.clear))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
        .cornerRadius(16)
    }
}

#Preview {
    BoardingPassView(viewModel: BoardingPassViewModel(passengerFlightIds: ["p01.01.s1.f1"]))
}
