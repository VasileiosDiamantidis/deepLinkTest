//
//  QRCodeGenerator.swift
//  deepLinkTest
//
//  Created by Vasileios Diamantidis on 15.05.25.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator {
    private static let context = CIContext()
    private static let filter = CIFilter.qrCodeGenerator()

    static func generate(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        guard let outputImage = filter.outputImage else { return nil }

        // Scale the image
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage, scale: 1.0, orientation: .up)
        }

        return nil
    }
}
