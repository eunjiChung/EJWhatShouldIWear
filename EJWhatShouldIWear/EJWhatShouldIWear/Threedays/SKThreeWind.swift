//
//  SKThreeWind.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeWind: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let wdir10hour = "wdir10hour"
    static let wspd7hour = "wspd7hour"
    static let wdir13hour = "wdir13hour"
    static let wspd61hour = "wspd61hour"
    static let wdir25hour = "wdir25hour"
    static let wspd46hour = "wspd46hour"
    static let wdir37hour = "wdir37hour"
    static let wdir19hour = "wdir19hour"
    static let wdir58hour = "wdir58hour"
    static let wdir55hour = "wdir55hour"
    static let wdir16hour = "wdir16hour"
    static let wdir46hour = "wdir46hour"
    static let wdir7hour = "wdir7hour"
    static let wdir49hour = "wdir49hour"
    static let wdir28hour = "wdir28hour"
    static let wspd19hour = "wspd19hour"
    static let wspd64hour = "wspd64hour"
    static let wspd67hour = "wspd67hour"
    static let wspd31hour = "wspd31hour"
    static let wspd58hour = "wspd58hour"
    static let wspd49hour = "wspd49hour"
    static let wspd22hour = "wspd22hour"
    static let wspd10hour = "wspd10hour"
    static let wspd16hour = "wspd16hour"
    static let wspd34hour = "wspd34hour"
    static let wspd55hour = "wspd55hour"
    static let wdir34hour = "wdir34hour"
    static let wdir40hour = "wdir40hour"
    static let wspd4hour = "wspd4hour"
    static let wspd28hour = "wspd28hour"
    static let wspd52hour = "wspd52hour"
    static let wspd43hour = "wspd43hour"
    static let wspd40hour = "wspd40hour"
    static let wdir43hour = "wdir43hour"
    static let wdir31hour = "wdir31hour"
    static let wdir22hour = "wdir22hour"
    static let wdir61hour = "wdir61hour"
    static let wspd25hour = "wspd25hour"
    static let wdir4hour = "wdir4hour"
    static let wspd13hour = "wspd13hour"
    static let wspd37hour = "wspd37hour"
    static let wdir52hour = "wdir52hour"
    static let wdir64hour = "wdir64hour"
    static let wdir67hour = "wdir67hour"
  }

  // MARK: Properties
  public var wdir10hour: String?
  public var wspd7hour: String?
  public var wdir13hour: String?
  public var wspd61hour: String?
  public var wdir25hour: String?
  public var wspd46hour: String?
  public var wdir37hour: String?
  public var wdir19hour: String?
  public var wdir58hour: String?
  public var wdir55hour: String?
  public var wdir16hour: String?
  public var wdir46hour: String?
  public var wdir7hour: String?
  public var wdir49hour: String?
  public var wdir28hour: String?
  public var wspd19hour: String?
  public var wspd64hour: String?
  public var wspd67hour: String?
  public var wspd31hour: String?
  public var wspd58hour: String?
  public var wspd49hour: String?
  public var wspd22hour: String?
  public var wspd10hour: String?
  public var wspd16hour: String?
  public var wspd34hour: String?
  public var wspd55hour: String?
  public var wdir34hour: String?
  public var wdir40hour: String?
  public var wspd4hour: String?
  public var wspd28hour: String?
  public var wspd52hour: String?
  public var wspd43hour: String?
  public var wspd40hour: String?
  public var wdir43hour: String?
  public var wdir31hour: String?
  public var wdir22hour: String?
  public var wdir61hour: String?
  public var wspd25hour: String?
  public var wdir4hour: String?
  public var wspd13hour: String?
  public var wspd37hour: String?
  public var wdir52hour: String?
  public var wdir64hour: String?
  public var wdir67hour: String?

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
    wdir10hour = json[SerializationKeys.wdir10hour].string
    wspd7hour = json[SerializationKeys.wspd7hour].string
    wdir13hour = json[SerializationKeys.wdir13hour].string
    wspd61hour = json[SerializationKeys.wspd61hour].string
    wdir25hour = json[SerializationKeys.wdir25hour].string
    wspd46hour = json[SerializationKeys.wspd46hour].string
    wdir37hour = json[SerializationKeys.wdir37hour].string
    wdir19hour = json[SerializationKeys.wdir19hour].string
    wdir58hour = json[SerializationKeys.wdir58hour].string
    wdir55hour = json[SerializationKeys.wdir55hour].string
    wdir16hour = json[SerializationKeys.wdir16hour].string
    wdir46hour = json[SerializationKeys.wdir46hour].string
    wdir7hour = json[SerializationKeys.wdir7hour].string
    wdir49hour = json[SerializationKeys.wdir49hour].string
    wdir28hour = json[SerializationKeys.wdir28hour].string
    wspd19hour = json[SerializationKeys.wspd19hour].string
    wspd64hour = json[SerializationKeys.wspd64hour].string
    wspd67hour = json[SerializationKeys.wspd67hour].string
    wspd31hour = json[SerializationKeys.wspd31hour].string
    wspd58hour = json[SerializationKeys.wspd58hour].string
    wspd49hour = json[SerializationKeys.wspd49hour].string
    wspd22hour = json[SerializationKeys.wspd22hour].string
    wspd10hour = json[SerializationKeys.wspd10hour].string
    wspd16hour = json[SerializationKeys.wspd16hour].string
    wspd34hour = json[SerializationKeys.wspd34hour].string
    wspd55hour = json[SerializationKeys.wspd55hour].string
    wdir34hour = json[SerializationKeys.wdir34hour].string
    wdir40hour = json[SerializationKeys.wdir40hour].string
    wspd4hour = json[SerializationKeys.wspd4hour].string
    wspd28hour = json[SerializationKeys.wspd28hour].string
    wspd52hour = json[SerializationKeys.wspd52hour].string
    wspd43hour = json[SerializationKeys.wspd43hour].string
    wspd40hour = json[SerializationKeys.wspd40hour].string
    wdir43hour = json[SerializationKeys.wdir43hour].string
    wdir31hour = json[SerializationKeys.wdir31hour].string
    wdir22hour = json[SerializationKeys.wdir22hour].string
    wdir61hour = json[SerializationKeys.wdir61hour].string
    wspd25hour = json[SerializationKeys.wspd25hour].string
    wdir4hour = json[SerializationKeys.wdir4hour].string
    wspd13hour = json[SerializationKeys.wspd13hour].string
    wspd37hour = json[SerializationKeys.wspd37hour].string
    wdir52hour = json[SerializationKeys.wdir52hour].string
    wdir64hour = json[SerializationKeys.wdir64hour].string
    wdir67hour = json[SerializationKeys.wdir67hour].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = wdir10hour { dictionary[SerializationKeys.wdir10hour] = value }
    if let value = wspd7hour { dictionary[SerializationKeys.wspd7hour] = value }
    if let value = wdir13hour { dictionary[SerializationKeys.wdir13hour] = value }
    if let value = wspd61hour { dictionary[SerializationKeys.wspd61hour] = value }
    if let value = wdir25hour { dictionary[SerializationKeys.wdir25hour] = value }
    if let value = wspd46hour { dictionary[SerializationKeys.wspd46hour] = value }
    if let value = wdir37hour { dictionary[SerializationKeys.wdir37hour] = value }
    if let value = wdir19hour { dictionary[SerializationKeys.wdir19hour] = value }
    if let value = wdir58hour { dictionary[SerializationKeys.wdir58hour] = value }
    if let value = wdir55hour { dictionary[SerializationKeys.wdir55hour] = value }
    if let value = wdir16hour { dictionary[SerializationKeys.wdir16hour] = value }
    if let value = wdir46hour { dictionary[SerializationKeys.wdir46hour] = value }
    if let value = wdir7hour { dictionary[SerializationKeys.wdir7hour] = value }
    if let value = wdir49hour { dictionary[SerializationKeys.wdir49hour] = value }
    if let value = wdir28hour { dictionary[SerializationKeys.wdir28hour] = value }
    if let value = wspd19hour { dictionary[SerializationKeys.wspd19hour] = value }
    if let value = wspd64hour { dictionary[SerializationKeys.wspd64hour] = value }
    if let value = wspd67hour { dictionary[SerializationKeys.wspd67hour] = value }
    if let value = wspd31hour { dictionary[SerializationKeys.wspd31hour] = value }
    if let value = wspd58hour { dictionary[SerializationKeys.wspd58hour] = value }
    if let value = wspd49hour { dictionary[SerializationKeys.wspd49hour] = value }
    if let value = wspd22hour { dictionary[SerializationKeys.wspd22hour] = value }
    if let value = wspd10hour { dictionary[SerializationKeys.wspd10hour] = value }
    if let value = wspd16hour { dictionary[SerializationKeys.wspd16hour] = value }
    if let value = wspd34hour { dictionary[SerializationKeys.wspd34hour] = value }
    if let value = wspd55hour { dictionary[SerializationKeys.wspd55hour] = value }
    if let value = wdir34hour { dictionary[SerializationKeys.wdir34hour] = value }
    if let value = wdir40hour { dictionary[SerializationKeys.wdir40hour] = value }
    if let value = wspd4hour { dictionary[SerializationKeys.wspd4hour] = value }
    if let value = wspd28hour { dictionary[SerializationKeys.wspd28hour] = value }
    if let value = wspd52hour { dictionary[SerializationKeys.wspd52hour] = value }
    if let value = wspd43hour { dictionary[SerializationKeys.wspd43hour] = value }
    if let value = wspd40hour { dictionary[SerializationKeys.wspd40hour] = value }
    if let value = wdir43hour { dictionary[SerializationKeys.wdir43hour] = value }
    if let value = wdir31hour { dictionary[SerializationKeys.wdir31hour] = value }
    if let value = wdir22hour { dictionary[SerializationKeys.wdir22hour] = value }
    if let value = wdir61hour { dictionary[SerializationKeys.wdir61hour] = value }
    if let value = wspd25hour { dictionary[SerializationKeys.wspd25hour] = value }
    if let value = wdir4hour { dictionary[SerializationKeys.wdir4hour] = value }
    if let value = wspd13hour { dictionary[SerializationKeys.wspd13hour] = value }
    if let value = wspd37hour { dictionary[SerializationKeys.wspd37hour] = value }
    if let value = wdir52hour { dictionary[SerializationKeys.wdir52hour] = value }
    if let value = wdir64hour { dictionary[SerializationKeys.wdir64hour] = value }
    if let value = wdir67hour { dictionary[SerializationKeys.wdir67hour] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.wdir10hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir10hour) as? String
    self.wspd7hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd7hour) as? String
    self.wdir13hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir13hour) as? String
    self.wspd61hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd61hour) as? String
    self.wdir25hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir25hour) as? String
    self.wspd46hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd46hour) as? String
    self.wdir37hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir37hour) as? String
    self.wdir19hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir19hour) as? String
    self.wdir58hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir58hour) as? String
    self.wdir55hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir55hour) as? String
    self.wdir16hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir16hour) as? String
    self.wdir46hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir46hour) as? String
    self.wdir7hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir7hour) as? String
    self.wdir49hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir49hour) as? String
    self.wdir28hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir28hour) as? String
    self.wspd19hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd19hour) as? String
    self.wspd64hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd64hour) as? String
    self.wspd67hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd67hour) as? String
    self.wspd31hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd31hour) as? String
    self.wspd58hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd58hour) as? String
    self.wspd49hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd49hour) as? String
    self.wspd22hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd22hour) as? String
    self.wspd10hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd10hour) as? String
    self.wspd16hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd16hour) as? String
    self.wspd34hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd34hour) as? String
    self.wspd55hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd55hour) as? String
    self.wdir34hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir34hour) as? String
    self.wdir40hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir40hour) as? String
    self.wspd4hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd4hour) as? String
    self.wspd28hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd28hour) as? String
    self.wspd52hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd52hour) as? String
    self.wspd43hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd43hour) as? String
    self.wspd40hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd40hour) as? String
    self.wdir43hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir43hour) as? String
    self.wdir31hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir31hour) as? String
    self.wdir22hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir22hour) as? String
    self.wdir61hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir61hour) as? String
    self.wspd25hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd25hour) as? String
    self.wdir4hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir4hour) as? String
    self.wspd13hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd13hour) as? String
    self.wspd37hour = aDecoder.decodeObject(forKey: SerializationKeys.wspd37hour) as? String
    self.wdir52hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir52hour) as? String
    self.wdir64hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir64hour) as? String
    self.wdir67hour = aDecoder.decodeObject(forKey: SerializationKeys.wdir67hour) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(wdir10hour, forKey: SerializationKeys.wdir10hour)
    aCoder.encode(wspd7hour, forKey: SerializationKeys.wspd7hour)
    aCoder.encode(wdir13hour, forKey: SerializationKeys.wdir13hour)
    aCoder.encode(wspd61hour, forKey: SerializationKeys.wspd61hour)
    aCoder.encode(wdir25hour, forKey: SerializationKeys.wdir25hour)
    aCoder.encode(wspd46hour, forKey: SerializationKeys.wspd46hour)
    aCoder.encode(wdir37hour, forKey: SerializationKeys.wdir37hour)
    aCoder.encode(wdir19hour, forKey: SerializationKeys.wdir19hour)
    aCoder.encode(wdir58hour, forKey: SerializationKeys.wdir58hour)
    aCoder.encode(wdir55hour, forKey: SerializationKeys.wdir55hour)
    aCoder.encode(wdir16hour, forKey: SerializationKeys.wdir16hour)
    aCoder.encode(wdir46hour, forKey: SerializationKeys.wdir46hour)
    aCoder.encode(wdir7hour, forKey: SerializationKeys.wdir7hour)
    aCoder.encode(wdir49hour, forKey: SerializationKeys.wdir49hour)
    aCoder.encode(wdir28hour, forKey: SerializationKeys.wdir28hour)
    aCoder.encode(wspd19hour, forKey: SerializationKeys.wspd19hour)
    aCoder.encode(wspd64hour, forKey: SerializationKeys.wspd64hour)
    aCoder.encode(wspd67hour, forKey: SerializationKeys.wspd67hour)
    aCoder.encode(wspd31hour, forKey: SerializationKeys.wspd31hour)
    aCoder.encode(wspd58hour, forKey: SerializationKeys.wspd58hour)
    aCoder.encode(wspd49hour, forKey: SerializationKeys.wspd49hour)
    aCoder.encode(wspd22hour, forKey: SerializationKeys.wspd22hour)
    aCoder.encode(wspd10hour, forKey: SerializationKeys.wspd10hour)
    aCoder.encode(wspd16hour, forKey: SerializationKeys.wspd16hour)
    aCoder.encode(wspd34hour, forKey: SerializationKeys.wspd34hour)
    aCoder.encode(wspd55hour, forKey: SerializationKeys.wspd55hour)
    aCoder.encode(wdir34hour, forKey: SerializationKeys.wdir34hour)
    aCoder.encode(wdir40hour, forKey: SerializationKeys.wdir40hour)
    aCoder.encode(wspd4hour, forKey: SerializationKeys.wspd4hour)
    aCoder.encode(wspd28hour, forKey: SerializationKeys.wspd28hour)
    aCoder.encode(wspd52hour, forKey: SerializationKeys.wspd52hour)
    aCoder.encode(wspd43hour, forKey: SerializationKeys.wspd43hour)
    aCoder.encode(wspd40hour, forKey: SerializationKeys.wspd40hour)
    aCoder.encode(wdir43hour, forKey: SerializationKeys.wdir43hour)
    aCoder.encode(wdir31hour, forKey: SerializationKeys.wdir31hour)
    aCoder.encode(wdir22hour, forKey: SerializationKeys.wdir22hour)
    aCoder.encode(wdir61hour, forKey: SerializationKeys.wdir61hour)
    aCoder.encode(wspd25hour, forKey: SerializationKeys.wspd25hour)
    aCoder.encode(wdir4hour, forKey: SerializationKeys.wdir4hour)
    aCoder.encode(wspd13hour, forKey: SerializationKeys.wspd13hour)
    aCoder.encode(wspd37hour, forKey: SerializationKeys.wspd37hour)
    aCoder.encode(wdir52hour, forKey: SerializationKeys.wdir52hour)
    aCoder.encode(wdir64hour, forKey: SerializationKeys.wdir64hour)
    aCoder.encode(wdir67hour, forKey: SerializationKeys.wdir67hour)
  }

}
