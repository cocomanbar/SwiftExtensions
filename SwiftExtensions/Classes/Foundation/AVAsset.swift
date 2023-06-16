//
//  AVAsset.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import AVFoundation

extension MKSwiftExtension where Base: AVAsset {
    
    public var videoCoverImage: UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: base)
        imageGenerator.appliesPreferredTrackTransform = true
        guard let fps: Float = base.tracks(withMediaType: .video).last?.nominalFrameRate else {
            return nil
        }
        do {
            let time = CMTimeMakeWithSeconds(0, preferredTimescale: Int32(fps))
            let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let newImage = UIImage(cgImage: cgImage)
            return newImage
        } catch { }
        return nil
    }
}
