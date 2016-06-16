/// Typealias to byte
public typealias Byte = UInt8

/// Protocol for output buffer
public protocol ByteOut {
    func write(byte: UInt8)
}

/// Protocol for input buffer
public protocol ByteIn {
    func read() -> UInt8
}

/**
 Encode the unsigned integer as LEB128

 - parameter out: The `ByteOut` to write in
 - parameter val: The `UInt` value to convert
 */

public func encode(out: ByteOut, val: UInt) {

    var value = val
    var remaining = value >> 7

    while remaining != 0 {
        out.write(Byte( (value & 0x7F) | 0x80 ))
        value = remaining
        remaining = remaining >> 7
    }

    out.write(Byte(value & 0x7F))
}

/**
 Encode the signed integer as LEB128

 - parameter out: The `ByteOut` to write in
 - parameter val: The `Int` value to convert
 */

public func encode(out: ByteOut, val: Int) {

   
}
