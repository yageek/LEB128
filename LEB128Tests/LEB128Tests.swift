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

    let unsignedMap: [UInt: ByteBuffer] = [
        0: ByteBuffer(elements: [0]),
        1: ByteBuffer(elements: [0x01]),
        2: ByteBuffer(elements: [0x02]),
        127: ByteBuffer(elements: [0x7f]),
        128: ByteBuffer(elements: [0x80, 0x01]),
        129: ByteBuffer(elements: [0x81, 0x01]),
        130: ByteBuffer(elements: [0x82, 0x01]),
        12857: ByteBuffer(elements: [0xB9, 0x64]),
        16256:  ByteBuffer(elements: [0x80, 0x7f]),
        0x40c:  ByteBuffer(elements: [0x8c, 0x08]),
        624485:  ByteBuffer(elements: [0xe5, 0x8e, 0x26]),
    ]

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
        for (raw, expected) in unsignedMap {
            XCTAssertEqual(expected[0..<expected.size], encodeUnsignedLeb(raw))
        }
    }

    func testDecodeUnsignedLeb() {
        XCTAssertEqual(0, decodeULEB(ByteBuffer(elements:[0])))
        XCTAssertEqual(1, decodeULEB(ByteBuffer(elements:[1])))
        XCTAssertEqual(127, decodeULEB(ByteBuffer(elements:[0x7f])))
        XCTAssertEqual(16256, decodeULEB(ByteBuffer(elements:[0x80, 0x7f])))
    }


    func testDecodSignedLeb() {
        XCTAssertEqual(0, decodeSLEB(ByteBuffer(elements:[0])))
        XCTAssertEqual(1, decodeSLEB(ByteBuffer(elements:[1])))
        XCTAssertEqual(-1, decodeSLEB(ByteBuffer(elements:[0x7f])))
        XCTAssertEqual(0x3c, decodeSLEB(ByteBuffer(elements:[0x3C])))
        XCTAssertEqual(-128, decodeSLEB(ByteBuffer(elements:[0x80, 0x7f])))
    }

    // MARK: Signed integer
    func testSignedEncode() {
        XCTAssertEqual([0], encodeSignedLeb(0))
        XCTAssertEqual([1], encodeSignedLeb(1))
        XCTAssertEqual([0x7f, ], encodeSignedLeb(-1))
        XCTAssertEqual([0x80, 0x7f], encodeSignedLeb(-128))
    }



}
