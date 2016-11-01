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
open class ByteBuffer: ByteOut, ByteIn, Equatable {

    fileprivate var buff: ContiguousArray<Byte>
    fileprivate var index: Int

    /**
      Returns the buffer size
      - returns: The size of the buffer
     */
    open var size: Int { return buff.count }

    /**
      Initialize a buffer with size

     - parameter size: Size as Int
    */
    public init(size: Int) {
        index = 0
        buff = ContiguousArray(repeating: 0, count: size)
    }

    /**
     Convenience init for a readable buffer.

     - parameter elements: Elements as `Array<Byte>`
     */
    public convenience init(elements: Array<Byte>) {
        self.init(size: elements.count)

        for element in elements {
            write(element)
        }

        index = 0
    }


    /**
        Reset the buffer
    */
    open func clear() {
        buff = ContiguousArray<Byte>(repeating: 0, count: size)
        index = 0
    }

    /**
      Write a `Byte` in the buffer

      - parameter byte: The value to write in
     */
    open func write(_ byte: Byte) {
        defer {
            index += 1
        }
        buff[index] = byte

    }

    /**
      Read the current value

     - returns: The `Byte` at the current index.
   */
    open func read() -> Byte {
        defer {
            index += 1
        }
        return buff[index]
    }

    open subscript (index: Int) -> Byte {
        get {
            return buff[index]
        }
    }

    open subscript(range: Range<Int>) -> ArraySlice<Byte> {
        get {
            return buff[range]
        }
    }
}
