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

    private var buff = ByteBuffer(size: 1024)

    func testWikipediaExample() {

        let val: UInt = 624485
        encode(buff, val: val)
        XCTAssertEqual(buff[0..<3], [0xE5, 0x8E, 0x26])
    }
   
    
}
