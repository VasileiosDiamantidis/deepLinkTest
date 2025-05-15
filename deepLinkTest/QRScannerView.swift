//
//  ContentView.swift
//  deepLinkTest
//
//  Created by Vasileios Diamantidis on 15.05.25.
//

import SwiftUI
import AVFoundation

struct QRScannerView: View {
    @StateObject private var scanner = QRScannerViewModel()
    
    var body: some View {
        ZStack {
            QRPreviewView(session: scanner.session)
                .edgesIgnoringSafeArea(.all)
            
            if let scannedURL = scanner.scannedURL {
                VStack {
                    Spacer()
                    Text("Scanned URL:")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(scannedURL.absoluteString)
                        .font(.body)
                        .foregroundColor(.yellow)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            scanner.startScanning()
        }
        .onDisappear {
            scanner.stopScanning()
        }
    }
}
