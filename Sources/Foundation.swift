//
//  Foundation.swift
//  LEB128
//
//  Created by Yannick Heinrich on 17.06.16.
//
//

import Foundation

/// Make Stream compatible
extension InputStream: ByteIn {

    public func read() -> UInt8 {
        var value: UInt8 = 0
        self.read(&value, maxLength: 1)
        return value
    }
}

extension OutputStream: ByteOut {

    public func write(_ byte: UInt8) {
        var byte = byte
        self.write(&byte, maxLength: 1)
    }
}
