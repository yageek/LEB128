//
//  LEB128Tests.swift
//  LEB128Tests
//
//  Created by Yannick Heinrich on 16.06.16.
//
//

import XCTest
import LEB128

class LEB128Tests: XCTestCase {

    // MARK: Helpers
    private func encodeUnsignedLeb(leb: UInt) -> ArraySlice<Byte> {
        let buff = ByteBuffer(size: 5)
        let length = encode(buff, value: leb)
        return buff[0..<length]
    }

    private func encodeSignedLeb(leb: Int) -> ArraySlice<Byte> {
        let buff = ByteBuffer(size: 5)
        let length = encode(buff, value: leb)
        return buff[0..<length]
    }


    // MARK: Unsigned integer
    func testUnsignedEncode() {
            XCTAssertEqual([0], encodeUnsignedLeb(0))
            XCTAssertEqual([1], encodeUnsignedLeb(1))
            XCTAssertEqual([0x80, 0x7f], encodeUnsignedLeb(16256))
            XCTAssertEqual([0xb4, 0x07], encodeUnsignedLeb(0x3b4))
            XCTAssertEqual([0x8c, 0x08], encodeUnsignedLeb(0x40c))
            XCTAssertEqual([0xe5, 0x8e, 0x26], encodeUnsignedLeb(624485))
    }

    func testDecodeUnsignedLeb() {
        XCTAssertEqual(0, decode(ByteBuffer(elements:[0])))
        XCTAssertEqual(1, decode(ByteBuffer(elements:[1])))
        XCTAssertEqual(127, decode(ByteBuffer(elements:[0x7f])))
        XCTAssertEqual(16256, decode(ByteBuffer(elements:[0x80, 0x7f])))
    }

    // MARK: Signed integer
    func testSignedEncode() {
        XCTAssertEqual([0], encodeSignedLeb(0))
        XCTAssertEqual([1], encodeSignedLeb(1))
        XCTAssertEqual([0x7f, ], encodeSignedLeb(-1))
        XCTAssertEqual([0x80, 0x7f], encodeSignedLeb(-128))
    }



}
