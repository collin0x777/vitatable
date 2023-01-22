//
//  ScannerView.swift
//  VitaTable
//
//  Created by Collin Gray on 1/6/23.
//

import SwiftUI
import AVFoundation

class CameraController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    struct PreviewWrapper: UIViewRepresentable {
        @Binding var session: AVCaptureSession

        func makeUIView(context: Context) -> PreviewView {
            PreviewView()
        }

        func updateUIView(_ uiView: PreviewView, context: Context) {
            print("UpdateUIView occurred...")
            uiView.videoPreviewLayer.session = session
            uiView.videoPreviewLayer.videoGravity = .resizeAspectFill
        }
    }
    
    class PreviewView: UIView {
        override class var layerClass: AnyClass {
            return AVCaptureVideoPreviewLayer.self
        }
        
        /// Convenience wrapper to get layer as its statically known type.
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    @State var captureSession = AVCaptureSession()
        
    var scannerPreview: PreviewWrapper {
        return PreviewWrapper(session: $captureSession)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects {
            switch metadata {
            case let barcode as AVMetadataMachineReadableCodeObject:
                print("Barcode: \(barcode.stringValue ?? "could not read barcode...")")
            default:
                print("Got something other than barcode")
            }
        }
    }
    
    func stopVideoCapture() {
        captureSession.stopRunning()
    }

    func beginVideoCapture() {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        
        let videoDevice = AVCaptureDevice.default(for: AVMediaType.video)
        guard
            let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice!),
            captureSession.canAddInput(videoDeviceInput)
            else {
                print("Failed to start camera input")
                return
            }
        captureSession.addInput(videoDeviceInput)
        
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        
        print(metadataOutput.availableMetadataObjectTypes)
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.face, .upce, .ean13, .ean8]

        
        captureSession.commitConfiguration()
        
        print("Running session...")
        
        captureSession.startRunning()
    }
    
    func toggleVideoCapture() {
        if (isCaptureRunning()) {
            stopVideoCapture()
        } else {
            beginVideoCapture()
        }
    }
    
    func isCaptureRunning() -> Bool {
        return captureSession.isRunning
    }
}

struct ScannerView: View {
    let camera = CameraController()
    
    var body: some View {
        ZStack {
            camera.scannerPreview
                .background(Color(UIColor.systemBackground).colorInvert())

            HStack {
                Spacer()
                Button(action: {
                    print("Button pressed")
                    camera.toggleVideoCapture()
                }) {
                Image(systemName: "camera.circle.fill")
                    .foregroundColor(Color.gray)
                    .font(.largeTitle)
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }

        }.frame(height: 100).cornerRadius(globalRadius)
    }
}
