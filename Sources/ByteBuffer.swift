//
//  ByteBuffer.swift
//  LEB128
//
//  Created by Yannick Heinrich on 16.06.16.
//
//

import Foundation

public func == (left: ByteBuffer, right: ByteBuffer) -> Bool {
    guard left.size == right.size else { return false }

    for i in 0..<left.size {
        if left[i] != right[i] {
            return false
        }
    }
    return true
}
/// ByteBuffer holds a buffer.
public class ByteBuffer: ByteOut, ByteIn, Equatable {

    private var buff: ContiguousArray<UInt8>
    private var index: Int

    /**
      Returns the buffer size
      - returns: The size of the buffer
     */
    public var size: Int { return buff.count }

    public init(size: Int) {

        index = 0
        buff = ContiguousArray(count: size, repeatedValue: 0)
    }

    public func clear() {
        buff = ContiguousArray<UInt8>(count: size, repeatedValue: 0)
        index = 0
    }

    public func write(byte: UInt8) {
        defer {
            index += 1
        }
        buff[index] = byte

    }

    public func read() -> UInt8 {
        defer {
            index += 1
        }
        return buff[index]
    }

    public subscript (index: Int) -> UInt8 {
        get {
            return buff[index]
        }
    }

    public subscript(range: Range<Int>) -> ArraySlice<UInt8> {
        get {
            return buff[range]
        }
    }
}
