//
//  AVAssetExportSession.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import AVKit

extension MKSwiftExtension where Base: AVAssetExportSession {
    
    /// 本地视频压缩
    /// - Parameters:
    ///   - input: 输入文件路径
    ///   - output: 输出文件路径
    ///   - outputFileType: 输入文件格式，默认 mp4
    ///   - shouldOptimizeForNetworkUse: 是否优化网络，默认true
    ///   - exportPresetMediumQuality: 压缩质量，这种设置方式，最终生成的视频分辨率与具体的拍摄设备有关。比如 iPhone6 拍摄的视频：使用AVAssetExportPresetHighestQuality则视频分辨率是1920x1080（不压缩）；AVAssetExportPresetMediumQuality视频分辨率是568x320；AVAssetExportPresetLowQuality视频分辨率是224x128
    ///   - completion: 处理视频的闭包，参数1：处理结果，参数2：转码后的视频本地地址
    public static func assetExportSession(_ input: String,
                                          output: String,
                                          outputFileType: AVFileType = .mp4,
                                          shouldOptimizeForNetworkUse: Bool = true,
                                          exportPresetMediumQuality: String = AVAssetExportPresetMediumQuality,
                                          completion: @escaping (Bool, String?) -> Void)
    
    {
        guard FileManager.default.fileExists(atPath: input) else {
            completion(false, nil)
            return
        }
        try? FileManager.default.removeItem(atPath: output)
        let avAsset: AVURLAsset = AVURLAsset(url: URL(fileURLWithPath: input), options: nil)
        guard let exportSession: AVAssetExportSession = AVAssetExportSession(asset: avAsset, presetName: exportPresetMediumQuality) else {
            completion(false, nil)
            return
        }
        exportSession.outputURL = URL(fileURLWithPath: output)
        exportSession.outputFileType = outputFileType
        exportSession.shouldOptimizeForNetworkUse = shouldOptimizeForNetworkUse
        exportSession.exportAsynchronously {
            DispatchQueue.main.async {
                if exportSession.status == .completed {
                    completion(true, output)
                } else {
                    completion(false, nil)
                }
            }
        }
    }
}
