//
//  ImageModel.swift
//  PhotoPicker
//
//  Created by liangqi on 16/3/11.
//  Copyright © 2016年 dailyios. All rights reserved.
//

import Foundation
import Photos

enum ModelType{
    case Button
    case Image
}

struct PhotoImageModel: Equatable {
    var type: ModelType?
    var data: PHAsset?
    
    init(type: ModelType?,data:PHAsset?){
        self.type = type
        self.data = data
    }
    
    static func ==(lhs: PhotoImageModel, rhs: PhotoImageModel) -> Bool {
        return lhs.type == rhs.type && lhs.data == rhs.data
    }
}
