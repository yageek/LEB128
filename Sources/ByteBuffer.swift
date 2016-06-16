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

    private var buff: ContiguousArray<Byte>
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

    public convenience init(elements: Array<Byte>) {
        self.init(size: elements.count)

        for element in elements {
            write(element)
        }

        index = 0
    }



    public func clear() {
        buff = ContiguousArray<Byte>(count: size, repeatedValue: 0)
        index = 0
    }

    public func write(byte: Byte) {
        defer {
            index += 1
        }
        buff[index] = byte

    }

    public func read() -> Byte {
        defer {
            index += 1
        }
        return buff[index]
    }

    public subscript (index: Int) -> Byte {
        get {
            return buff[index]
        }
    }

    public subscript(range: Range<Int>) -> ArraySlice<Byte> {
        get {
            return buff[range]
        }
    }
}
