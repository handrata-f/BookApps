//
//  CustomFunction.swift
//  bookapps
//
//  Created by Handrata Febrianto on 27/06/25.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

func convertToDictionary(from jsonString: String) -> [String: Any]? {
    guard let data = jsonString.data(using: .utf8) else { return nil }

    do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        return json as? [String: Any]
    } catch {
        print("❌ JSON decoding error: \(error)")
        return nil
    }
}

func generateBarcode(from string: String) -> UIImage? {
    print("Barcode String: \(string)")

    // 1. Generate barcode
    guard let data = string.data(using: .ascii),
          let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
        print("❌ Failed to create barcode filter.")
        return nil
    }
    filter.setValue(data, forKey: "inputMessage")
    filter.setValue(0, forKey: "inputQuietSpace")

    // 2. Get output image and scale
    guard let outputImage = filter.outputImage?
            .transformed(by: CGAffineTransform(scaleX: 3, y: 3)) else {
        print("❌ Failed to transform image.")
        return nil
    }

    // 3. Create transparent image using color controls
    let transparentFilter = CIFilter(name: "CIFalseColor")
    transparentFilter?.setDefaults()
    transparentFilter?.setValue(outputImage, forKey: kCIInputImageKey)
    transparentFilter?.setValue(CIColor(color: .black), forKey: "inputColor0") // barcode lines
    transparentFilter?.setValue(CIColor.clear, forKey: "inputColor1") // background

    guard let transparentImage = transparentFilter?.outputImage else {
        print("❌ Failed to apply false color filter.")
        return nil
    }

    // 4. Convert to UIImage
    let context = CIContext()
    guard let cgImage = context.createCGImage(transparentImage, from: transparentImage.extent) else {
        print("❌ Failed to create CGImage.")
        return nil
    }

    let uiImage = UIImage(cgImage: cgImage)
    print("✅ Transparent Barcode Image generated successfully.")
    return uiImage
}

func dateToString(_ date: Date, _ dateFormat: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
}
