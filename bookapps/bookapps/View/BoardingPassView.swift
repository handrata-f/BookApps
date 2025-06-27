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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    BoardingPassView(viewModel: BoardingPassViewModel(passengerFlightIds: ["p01.01.s1.f1"])
}
