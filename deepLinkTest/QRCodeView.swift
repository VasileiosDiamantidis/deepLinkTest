//
//  QRCodeView.swift
//  deepLinkTest
//
//  Created by Vasileios Diamantidis on 15.05.25.
//
import SwiftUI

struct QRCodeView: View {
    let url: String

    var body: some View {
        if let qrImage = QRCodeGenerator.generate(from: url) {
            Image(uiImage: qrImage)
                .interpolation(.none)
                .resizable()
                .frame(width: 200, height: 200)
                .accessibilityLabel("QR code for \(url)")
        } else {
            Text("Failed to generate QR code")
                .foregroundColor(.red)
        }
    }
}
