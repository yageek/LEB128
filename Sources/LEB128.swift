/**
    Algorithms are taken from
   "DWARF Debugging Information Format Specification Version 2.0, Draft" (PDF)
 */

// MARK: - Core

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

// MARK: - Unsigned Integer
/**
 Encode the unsigned integer as LEB128

 - parameter out: The `ByteOut` to write in
 - parameter value: The `UInt` value to convert
 - returns:         The number of written byte
 */

public func encode(out: ByteOut, value: UInt) -> Int {
    var value = value
    var count = 0

    repeat {
        var byte = Byte(value & 0x7F)
        value = value >> 7
        if value != 0 {
            byte |= 0x80
        }
        out.write(byte)
        count += 1
    } while value != 0

    return count
}

/**
 Encode the unsigned integer as LEB128 (Alternative)

 - parameter out:   The `ByteOut` to write in
 - parameter value: The `UInt` value to convert
 - returns:         The number of written byte
 */

internal func encode2(out: ByteOut, value: UInt) -> Int {

    var value = value
    var count = 0
    var remaining = value >> 7

    while remaining != 0 {
        out.write(Byte( (value & 0x7F) | 0x80 ))
        count += 1
        value = remaining
        remaining = remaining >> 7
    }

    out.write(Byte(value & 0x7F))
    count += 1

    return count
}

/**
 Decode the unsigned integer as LEB128

 - parameter input: The `ByteIn` to read
 - returns:         The decoded value
 */
public func decodeULEB(input: ByteIn) -> UInt {
    var result: UInt = 0
    var shift: UInt = 0

    while true {
        let byte = input.read()
        result |= ((UInt(byte) & 0x7F) << shift)

        if (byte >> 7) == 0 {
            break
        }
        shift += 7
    }
    return result
}

// MARK: - Signed Integer

/**
 Encode the signed integer as LEB128

 - parameter out: The `ByteOut` to write in
 - parameter val: The `Int` value to convert
 - returns:         The number of written byte
 */

public func encode(out: ByteOut, value: Int) -> Int {

    var value = value
    var more = true
    var count = 0

    while more {
        var byte = Byte(value & 0x7F)
        value = value >> 7

        if (value == 0 && (byte >> 6) == 0) || (value == -1 && (byte >> 6) == 1) {
            more = false
        } else {
            byte |= 0x80
        }

        out.write(byte)
        count += 1
    }
    return count
}


/**
 Decode the unsigned integer as LEB128

 - parameter input: The `ByteIn` to read
 - returns:         The decoded value
 */
public func decodeSLEB(input: ByteIn) -> Int {
    var result: Int = 0
    var shift: Int = 0
    let size: Int = sizeof(Int.self)

    var byte: Byte = 0

    while true {
        byte = input.read()
        result |= ((Int(byte) & 0x7F) << shift)

        if (byte >> 7) == 0 {
            break
        }
        shift += 7
    }

    if (shift < size) && Int(byte >> 6) == 1 {
        result |= -(1 << shift)
    }
    return result
}
