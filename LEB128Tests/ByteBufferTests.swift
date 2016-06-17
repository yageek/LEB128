//
//  ByteBufferTests.swift
//  LEB128
//
//  Created by Yannick Heinrich on 17.06.16.
//
//

import XCTest
import LEB128

class ByteBufferTests: XCTestCase {

    func testByteBuffer() {
        let elements: Array<Byte> = [0x01, 0x02, 0x03];
        let buff = ByteBuffer(elements: elements)
        
        XCTAssertEqual(ArraySlice<Byte>(elements), buff[0..<3])

        buff.clear()
        XCTAssertEqual(ArraySlice<Byte>([0, 0, 0]), buff[0..<3])
    }
}
