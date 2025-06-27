//
//  LoadingView.swift
//  bookapps
//
//  Created by Handrata Febrianto on 26/06/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            ProgressView("Loading...")
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .foregroundColor(.gray)
        }
    }
}
