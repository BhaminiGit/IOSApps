//
//  Matrix4+Extensions.swift
//  StARs
//
//  Created by Konrad Feiler on 17.12.17.
//  Copyright © 2017 Konrad Feiler. All rights reserved.
//

import Foundation
import SceneKit

extension float4x4 {
    init(_ matrix: SCNMatrix4) {
        self.init([
            SIMD4(matrix.m11, matrix.m12, matrix.m13, matrix.m14),
            SIMD4(matrix.m21, matrix.m22, matrix.m23, matrix.m24),
            SIMD4(matrix.m31, matrix.m32, matrix.m33, matrix.m34),
            SIMD4(matrix.m41, matrix.m42, matrix.m43, matrix.m44)
            ])
    }
}

extension SIMD4 {
    init(_ vector: SCNVector4) {
        
        self.init(vector.x as! Scalar, vector.y as! Scalar, vector.z as! Scalar, vector.w as! Scalar)
    }

    init(_ vector: SCNVector3) {
        self.init(vector.x as! Scalar, vector.y as! Scalar, vector.z as! Scalar, 1 as! Scalar)
    }
}

extension SCNVector4 {
    init(_ vector: SIMD4<Float>) {
        self.init(x: vector.x, y: vector.y, z: vector.z, w: vector.w)
    }
    
    init(_ vector: SCNVector3) {
        self.init(x: vector.x, y: vector.y, z: vector.z, w: 1)
    }
}

extension SCNVector3 {
    init(_ vector: SIMD4<Float>) {
        self.init(x: vector.x / vector.w, y: vector.y / vector.w, z: vector.z / vector.w)
    }
}

func * (left: SCNMatrix4, right: SCNVector4) -> SCNVector4 {
    let matrix = float4x4(left)
    let vector = SIMD4<Float>(right)
    let result = matrix * vector
    
    return SCNVector4(result)
}
