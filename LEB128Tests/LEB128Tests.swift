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

    let unsignedMap: [UInt: Array<Byte>] = [
        0: [0],
        1: [0x01],
        2: [0x02],
        127: [0x7f],
        128: [0x80, 0x01],
        129: [0x81, 0x01],
        130: [0x82, 0x01],
        12857: [0xB9, 0x64],
        16256: [0x80, 0x7f],
        0x40c: [0x8c, 0x08],
        624485: [0xe5, 0x8e, 0x26],
    ]

    let signedMap: [Int: Array<Byte>] = [
        0: [0],
        1: [0x01],
        2: [0x02],
        127:  [0xFF, 0x00],
        128:  [0x80, 0x01],
        129:  [0x81, 0x01],
        -1: [0x7f],
        -2:   [0x7e],
        -127: [0x81, 0x7f],
        -128: [0x80, 0x7f],
        -129: [0xFF, 0x7e],
        ]


    // MARK: Helpers
    private func encodeUnsignedLeb(leb: UInt) -> ArraySlice<Byte> {
        let buff = ByteBuffer(size: 5)
        let length = encodeUnsignedLEB(buff, value: leb)
        return buff[0..<length]
    }

    private func encodeSignedLeb(leb: Int) -> ArraySlice<Byte> {
        let buff = ByteBuffer(size: 5)
        let length = encodeSignedLEB(buff, value: leb)
        return buff[0..<length]
    }


    // MARK: Unsigned integer

    func testUnsignedEncode() {
        for (raw, bytes) in unsignedMap {
            let expected = ByteBuffer(elements: bytes)
            XCTAssertEqual(expected[0..<expected.size], encodeUnsignedLeb(raw))
        }
    }

    func testDecodeUnsignedLeb() {

        for (raw, bytes) in unsignedMap {
            let elements = ByteBuffer(elements: bytes)
            XCTAssertEqual(raw, decodeUnsignedLEB(elements))
        }
    }


    // MARK: Signed integer

    func testSignedEncode() {
        for (raw, bytes) in signedMap {
            let expected = ByteBuffer(elements: bytes)
            XCTAssertEqual(expected[0..<expected.size], encodeSignedLeb(raw))
        }

    }

    func testDecodSignedLeb() {

        for (raw, bytes) in signedMap {
            let elements = ByteBuffer(elements: bytes)
            XCTAssertEqual(raw, decodeSignedLEB(elements))
        }
    }


}
