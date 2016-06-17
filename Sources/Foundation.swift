//
//  Foundation.swift
//  LEB128
//
//  Created by Yannick Heinrich on 17.06.16.
//
//

import Foundation

/// Make NSStream compatible
extension NSInputStream: ByteIn {

    public func read() -> UInt8 {
        var value: UInt8 = 0
        self.read(&value, maxLength: 1)
        return value
    }
}

extension NSOutputStream: ByteOut {

    public func write(byte: UInt8) {
        var byte = byte
        self.write(&byte, maxLength: 1)
    }
}
