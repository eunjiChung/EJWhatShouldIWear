//
//  SKThreeSky.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeSky: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name58hour = "name58hour"
    static let code46hour = "code46hour"
    static let name10hour = "name10hour"
    static let name67hour = "name67hour"
    static let code64hour = "code64hour"
    static let name22hour = "name22hour"
    static let code22hour = "code22hour"
    static let code16hour = "code16hour"
    static let name25hour = "name25hour"
    static let code25hour = "code25hour"
    static let name13hour = "name13hour"
    static let name37hour = "name37hour"
    static let code4hour = "code4hour"
    static let name7hour = "name7hour"
    static let name40hour = "name40hour"
    static let name49hour = "name49hour"
    static let name19hour = "name19hour"
    static let name16hour = "name16hour"
    static let code52hour = "code52hour"
    static let code34hour = "code34hour"
    static let name34hour = "name34hour"
    static let name64hour = "name64hour"
    static let code43hour = "code43hour"
    static let code40hour = "code40hour"
    static let name43hour = "name43hour"
    static let code37hour = "code37hour"
    static let code31hour = "code31hour"
    static let code67hour = "code67hour"
    static let code61hour = "code61hour"
    static let code58hour = "code58hour"
    static let code10hour = "code10hour"
    static let code28hour = "code28hour"
    static let code19hour = "code19hour"
    static let name61hour = "name61hour"
    static let code13hour = "code13hour"
    static let name55hour = "name55hour"
    static let name52hour = "name52hour"
    static let code49hour = "code49hour"
    static let code7hour = "code7hour"
    static let name28hour = "name28hour"
    static let name4hour = "name4hour"
    static let name31hour = "name31hour"
    static let code55hour = "code55hour"
    static let name46hour = "name46hour"
  }

  // MARK: Properties
  public var name58hour: String?
  public var code46hour: String?
  public var name10hour: String?
  public var name67hour: String?
  public var code64hour: String?
  public var name22hour: String?
  public var code22hour: String?
  public var code16hour: String?
  public var name25hour: String?
  public var code25hour: String?
  public var name13hour: String?
  public var name37hour: String?
  public var code4hour: String?
  public var name7hour: String?
  public var name40hour: String?
  public var name49hour: String?
  public var name19hour: String?
  public var name16hour: String?
  public var code52hour: String?
  public var code34hour: String?
  public var name34hour: String?
  public var name64hour: String?
  public var code43hour: String?
  public var code40hour: String?
  public var name43hour: String?
  public var code37hour: String?
  public var code31hour: String?
  public var code67hour: String?
  public var code61hour: String?
  public var code58hour: String?
  public var code10hour: String?
  public var code28hour: String?
  public var code19hour: String?
  public var name61hour: String?
  public var code13hour: String?
  public var name55hour: String?
  public var name52hour: String?
  public var code49hour: String?
  public var code7hour: String?
  public var name28hour: String?
  public var name4hour: String?
  public var name31hour: String?
  public var code55hour: String?
  public var name46hour: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    name58hour = json[SerializationKeys.name58hour].string
    code46hour = json[SerializationKeys.code46hour].string
    name10hour = json[SerializationKeys.name10hour].string
    name67hour = json[SerializationKeys.name67hour].string
    code64hour = json[SerializationKeys.code64hour].string
    name22hour = json[SerializationKeys.name22hour].string
    code22hour = json[SerializationKeys.code22hour].string
    code16hour = json[SerializationKeys.code16hour].string
    name25hour = json[SerializationKeys.name25hour].string
    code25hour = json[SerializationKeys.code25hour].string
    name13hour = json[SerializationKeys.name13hour].string
    name37hour = json[SerializationKeys.name37hour].string
    code4hour = json[SerializationKeys.code4hour].string
    name7hour = json[SerializationKeys.name7hour].string
    name40hour = json[SerializationKeys.name40hour].string
    name49hour = json[SerializationKeys.name49hour].string
    name19hour = json[SerializationKeys.name19hour].string
    name16hour = json[SerializationKeys.name16hour].string
    code52hour = json[SerializationKeys.code52hour].string
    code34hour = json[SerializationKeys.code34hour].string
    name34hour = json[SerializationKeys.name34hour].string
    name64hour = json[SerializationKeys.name64hour].string
    code43hour = json[SerializationKeys.code43hour].string
    code40hour = json[SerializationKeys.code40hour].string
    name43hour = json[SerializationKeys.name43hour].string
    code37hour = json[SerializationKeys.code37hour].string
    code31hour = json[SerializationKeys.code31hour].string
    code67hour = json[SerializationKeys.code67hour].string
    code61hour = json[SerializationKeys.code61hour].string
    code58hour = json[SerializationKeys.code58hour].string
    code10hour = json[SerializationKeys.code10hour].string
    code28hour = json[SerializationKeys.code28hour].string
    code19hour = json[SerializationKeys.code19hour].string
    name61hour = json[SerializationKeys.name61hour].string
    code13hour = json[SerializationKeys.code13hour].string
    name55hour = json[SerializationKeys.name55hour].string
    name52hour = json[SerializationKeys.name52hour].string
    code49hour = json[SerializationKeys.code49hour].string
    code7hour = json[SerializationKeys.code7hour].string
    name28hour = json[SerializationKeys.name28hour].string
    name4hour = json[SerializationKeys.name4hour].string
    name31hour = json[SerializationKeys.name31hour].string
    code55hour = json[SerializationKeys.code55hour].string
    name46hour = json[SerializationKeys.name46hour].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name58hour { dictionary[SerializationKeys.name58hour] = value }
    if let value = code46hour { dictionary[SerializationKeys.code46hour] = value }
    if let value = name10hour { dictionary[SerializationKeys.name10hour] = value }
    if let value = name67hour { dictionary[SerializationKeys.name67hour] = value }
    if let value = code64hour { dictionary[SerializationKeys.code64hour] = value }
    if let value = name22hour { dictionary[SerializationKeys.name22hour] = value }
    if let value = code22hour { dictionary[SerializationKeys.code22hour] = value }
    if let value = code16hour { dictionary[SerializationKeys.code16hour] = value }
    if let value = name25hour { dictionary[SerializationKeys.name25hour] = value }
    if let value = code25hour { dictionary[SerializationKeys.code25hour] = value }
    if let value = name13hour { dictionary[SerializationKeys.name13hour] = value }
    if let value = name37hour { dictionary[SerializationKeys.name37hour] = value }
    if let value = code4hour { dictionary[SerializationKeys.code4hour] = value }
    if let value = name7hour { dictionary[SerializationKeys.name7hour] = value }
    if let value = name40hour { dictionary[SerializationKeys.name40hour] = value }
    if let value = name49hour { dictionary[SerializationKeys.name49hour] = value }
    if let value = name19hour { dictionary[SerializationKeys.name19hour] = value }
    if let value = name16hour { dictionary[SerializationKeys.name16hour] = value }
    if let value = code52hour { dictionary[SerializationKeys.code52hour] = value }
    if let value = code34hour { dictionary[SerializationKeys.code34hour] = value }
    if let value = name34hour { dictionary[SerializationKeys.name34hour] = value }
    if let value = name64hour { dictionary[SerializationKeys.name64hour] = value }
    if let value = code43hour { dictionary[SerializationKeys.code43hour] = value }
    if let value = code40hour { dictionary[SerializationKeys.code40hour] = value }
    if let value = name43hour { dictionary[SerializationKeys.name43hour] = value }
    if let value = code37hour { dictionary[SerializationKeys.code37hour] = value }
    if let value = code31hour { dictionary[SerializationKeys.code31hour] = value }
    if let value = code67hour { dictionary[SerializationKeys.code67hour] = value }
    if let value = code61hour { dictionary[SerializationKeys.code61hour] = value }
    if let value = code58hour { dictionary[SerializationKeys.code58hour] = value }
    if let value = code10hour { dictionary[SerializationKeys.code10hour] = value }
    if let value = code28hour { dictionary[SerializationKeys.code28hour] = value }
    if let value = code19hour { dictionary[SerializationKeys.code19hour] = value }
    if let value = name61hour { dictionary[SerializationKeys.name61hour] = value }
    if let value = code13hour { dictionary[SerializationKeys.code13hour] = value }
    if let value = name55hour { dictionary[SerializationKeys.name55hour] = value }
    if let value = name52hour { dictionary[SerializationKeys.name52hour] = value }
    if let value = code49hour { dictionary[SerializationKeys.code49hour] = value }
    if let value = code7hour { dictionary[SerializationKeys.code7hour] = value }
    if let value = name28hour { dictionary[SerializationKeys.name28hour] = value }
    if let value = name4hour { dictionary[SerializationKeys.name4hour] = value }
    if let value = name31hour { dictionary[SerializationKeys.name31hour] = value }
    if let value = code55hour { dictionary[SerializationKeys.code55hour] = value }
    if let value = name46hour { dictionary[SerializationKeys.name46hour] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name58hour = aDecoder.decodeObject(forKey: SerializationKeys.name58hour) as? String
    self.code46hour = aDecoder.decodeObject(forKey: SerializationKeys.code46hour) as? String
    self.name10hour = aDecoder.decodeObject(forKey: SerializationKeys.name10hour) as? String
    self.name67hour = aDecoder.decodeObject(forKey: SerializationKeys.name67hour) as? String
    self.code64hour = aDecoder.decodeObject(forKey: SerializationKeys.code64hour) as? String
    self.name22hour = aDecoder.decodeObject(forKey: SerializationKeys.name22hour) as? String
    self.code22hour = aDecoder.decodeObject(forKey: SerializationKeys.code22hour) as? String
    self.code16hour = aDecoder.decodeObject(forKey: SerializationKeys.code16hour) as? String
    self.name25hour = aDecoder.decodeObject(forKey: SerializationKeys.name25hour) as? String
    self.code25hour = aDecoder.decodeObject(forKey: SerializationKeys.code25hour) as? String
    self.name13hour = aDecoder.decodeObject(forKey: SerializationKeys.name13hour) as? String
    self.name37hour = aDecoder.decodeObject(forKey: SerializationKeys.name37hour) as? String
    self.code4hour = aDecoder.decodeObject(forKey: SerializationKeys.code4hour) as? String
    self.name7hour = aDecoder.decodeObject(forKey: SerializationKeys.name7hour) as? String
    self.name40hour = aDecoder.decodeObject(forKey: SerializationKeys.name40hour) as? String
    self.name49hour = aDecoder.decodeObject(forKey: SerializationKeys.name49hour) as? String
    self.name19hour = aDecoder.decodeObject(forKey: SerializationKeys.name19hour) as? String
    self.name16hour = aDecoder.decodeObject(forKey: SerializationKeys.name16hour) as? String
    self.code52hour = aDecoder.decodeObject(forKey: SerializationKeys.code52hour) as? String
    self.code34hour = aDecoder.decodeObject(forKey: SerializationKeys.code34hour) as? String
    self.name34hour = aDecoder.decodeObject(forKey: SerializationKeys.name34hour) as? String
    self.name64hour = aDecoder.decodeObject(forKey: SerializationKeys.name64hour) as? String
    self.code43hour = aDecoder.decodeObject(forKey: SerializationKeys.code43hour) as? String
    self.code40hour = aDecoder.decodeObject(forKey: SerializationKeys.code40hour) as? String
    self.name43hour = aDecoder.decodeObject(forKey: SerializationKeys.name43hour) as? String
    self.code37hour = aDecoder.decodeObject(forKey: SerializationKeys.code37hour) as? String
    self.code31hour = aDecoder.decodeObject(forKey: SerializationKeys.code31hour) as? String
    self.code67hour = aDecoder.decodeObject(forKey: SerializationKeys.code67hour) as? String
    self.code61hour = aDecoder.decodeObject(forKey: SerializationKeys.code61hour) as? String
    self.code58hour = aDecoder.decodeObject(forKey: SerializationKeys.code58hour) as? String
    self.code10hour = aDecoder.decodeObject(forKey: SerializationKeys.code10hour) as? String
    self.code28hour = aDecoder.decodeObject(forKey: SerializationKeys.code28hour) as? String
    self.code19hour = aDecoder.decodeObject(forKey: SerializationKeys.code19hour) as? String
    self.name61hour = aDecoder.decodeObject(forKey: SerializationKeys.name61hour) as? String
    self.code13hour = aDecoder.decodeObject(forKey: SerializationKeys.code13hour) as? String
    self.name55hour = aDecoder.decodeObject(forKey: SerializationKeys.name55hour) as? String
    self.name52hour = aDecoder.decodeObject(forKey: SerializationKeys.name52hour) as? String
    self.code49hour = aDecoder.decodeObject(forKey: SerializationKeys.code49hour) as? String
    self.code7hour = aDecoder.decodeObject(forKey: SerializationKeys.code7hour) as? String
    self.name28hour = aDecoder.decodeObject(forKey: SerializationKeys.name28hour) as? String
    self.name4hour = aDecoder.decodeObject(forKey: SerializationKeys.name4hour) as? String
    self.name31hour = aDecoder.decodeObject(forKey: SerializationKeys.name31hour) as? String
    self.code55hour = aDecoder.decodeObject(forKey: SerializationKeys.code55hour) as? String
    self.name46hour = aDecoder.decodeObject(forKey: SerializationKeys.name46hour) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name58hour, forKey: SerializationKeys.name58hour)
    aCoder.encode(code46hour, forKey: SerializationKeys.code46hour)
    aCoder.encode(name10hour, forKey: SerializationKeys.name10hour)
    aCoder.encode(name67hour, forKey: SerializationKeys.name67hour)
    aCoder.encode(code64hour, forKey: SerializationKeys.code64hour)
    aCoder.encode(name22hour, forKey: SerializationKeys.name22hour)
    aCoder.encode(code22hour, forKey: SerializationKeys.code22hour)
    aCoder.encode(code16hour, forKey: SerializationKeys.code16hour)
    aCoder.encode(name25hour, forKey: SerializationKeys.name25hour)
    aCoder.encode(code25hour, forKey: SerializationKeys.code25hour)
    aCoder.encode(name13hour, forKey: SerializationKeys.name13hour)
    aCoder.encode(name37hour, forKey: SerializationKeys.name37hour)
    aCoder.encode(code4hour, forKey: SerializationKeys.code4hour)
    aCoder.encode(name7hour, forKey: SerializationKeys.name7hour)
    aCoder.encode(name40hour, forKey: SerializationKeys.name40hour)
    aCoder.encode(name49hour, forKey: SerializationKeys.name49hour)
    aCoder.encode(name19hour, forKey: SerializationKeys.name19hour)
    aCoder.encode(name16hour, forKey: SerializationKeys.name16hour)
    aCoder.encode(code52hour, forKey: SerializationKeys.code52hour)
    aCoder.encode(code34hour, forKey: SerializationKeys.code34hour)
    aCoder.encode(name34hour, forKey: SerializationKeys.name34hour)
    aCoder.encode(name64hour, forKey: SerializationKeys.name64hour)
    aCoder.encode(code43hour, forKey: SerializationKeys.code43hour)
    aCoder.encode(code40hour, forKey: SerializationKeys.code40hour)
    aCoder.encode(name43hour, forKey: SerializationKeys.name43hour)
    aCoder.encode(code37hour, forKey: SerializationKeys.code37hour)
    aCoder.encode(code31hour, forKey: SerializationKeys.code31hour)
    aCoder.encode(code67hour, forKey: SerializationKeys.code67hour)
    aCoder.encode(code61hour, forKey: SerializationKeys.code61hour)
    aCoder.encode(code58hour, forKey: SerializationKeys.code58hour)
    aCoder.encode(code10hour, forKey: SerializationKeys.code10hour)
    aCoder.encode(code28hour, forKey: SerializationKeys.code28hour)
    aCoder.encode(code19hour, forKey: SerializationKeys.code19hour)
    aCoder.encode(name61hour, forKey: SerializationKeys.name61hour)
    aCoder.encode(code13hour, forKey: SerializationKeys.code13hour)
    aCoder.encode(name55hour, forKey: SerializationKeys.name55hour)
    aCoder.encode(name52hour, forKey: SerializationKeys.name52hour)
    aCoder.encode(code49hour, forKey: SerializationKeys.code49hour)
    aCoder.encode(code7hour, forKey: SerializationKeys.code7hour)
    aCoder.encode(name28hour, forKey: SerializationKeys.name28hour)
    aCoder.encode(name4hour, forKey: SerializationKeys.name4hour)
    aCoder.encode(name31hour, forKey: SerializationKeys.name31hour)
    aCoder.encode(code55hour, forKey: SerializationKeys.code55hour)
    aCoder.encode(name46hour, forKey: SerializationKeys.name46hour)
  }

}
