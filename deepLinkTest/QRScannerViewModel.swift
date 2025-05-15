//
//  QRScannerViewModel.swift
//  deepLinkTest
//
//  Created by Vasileios Diamantidis on 15.05.25.
//


import AVFoundation
import Foundation

final class QRScannerViewModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedURL: URL?
    
    let session = AVCaptureSession()
    
    override init() {
        super.init()
        setupSession()
    }
    
    private func setupSession() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device)
        else {
            print("❌ Camera input unavailable")
            return
        }
        
        session.beginConfiguration()
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
        }
        
        session.commitConfiguration()
    }
    
    func startScanning() {
        scannedURL = nil
        Task(priority: .background) {
            session.startRunning()
        }
    }
    
    func stopScanning() {
        session.stopRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              object.type == .qr,
              let stringValue = object.stringValue,
              let url = URL(string: stringValue)
        else { return }

        scannedURL = url
        stopScanning() // Stop scanning after successful detection
    }
}
