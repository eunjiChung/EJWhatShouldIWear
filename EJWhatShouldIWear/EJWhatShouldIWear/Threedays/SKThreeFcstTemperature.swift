//
//  SKThreeTemperature.swift
//
//  Created by eunji on 16/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeFcstTemperature: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let temp37hour = "temp37hour"
    static let temp25hour = "temp25hour"
    static let temp4hour = "temp4hour"
    static let temp7hour = "temp7hour"
    static let temp64hour = "temp64hour"
    static let temp61hour = "temp61hour"
    static let temp10hour = "temp10hour"
    static let temp28hour = "temp28hour"
    static let temp58hour = "temp58hour"
    static let temp19hour = "temp19hour"
    static let temp34hour = "temp34hour"
    static let temp13hour = "temp13hour"
    static let temp46hour = "temp46hour"
    static let temp55hour = "temp55hour"
    static let temp40hour = "temp40hour"
    static let temp16hour = "temp16hour"
    static let temp43hour = "temp43hour"
    static let temp52hour = "temp52hour"
    static let temp49hour = "temp49hour"
    static let temp67hour = "temp67hour"
    static let temp31hour = "temp31hour"
    static let temp22hour = "temp22hour"
  }

  // MARK: Properties
  public var temp37hour: String?
  public var temp25hour: String?
  public var temp4hour: String?
  public var temp7hour: String?
  public var temp64hour: String?
  public var temp61hour: String?
  public var temp10hour: String?
  public var temp28hour: String?
  public var temp58hour: String?
  public var temp19hour: String?
  public var temp34hour: String?
  public var temp13hour: String?
  public var temp46hour: String?
  public var temp55hour: String?
  public var temp40hour: String?
  public var temp16hour: String?
  public var temp43hour: String?
  public var temp52hour: String?
  public var temp49hour: String?
  public var temp67hour: String?
  public var temp31hour: String?
  public var temp22hour: String?

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
    temp37hour = json[SerializationKeys.temp37hour].string
    temp25hour = json[SerializationKeys.temp25hour].string
    temp4hour = json[SerializationKeys.temp4hour].string
    temp7hour = json[SerializationKeys.temp7hour].string
    temp64hour = json[SerializationKeys.temp64hour].string
    temp61hour = json[SerializationKeys.temp61hour].string
    temp10hour = json[SerializationKeys.temp10hour].string
    temp28hour = json[SerializationKeys.temp28hour].string
    temp58hour = json[SerializationKeys.temp58hour].string
    temp19hour = json[SerializationKeys.temp19hour].string
    temp34hour = json[SerializationKeys.temp34hour].string
    temp13hour = json[SerializationKeys.temp13hour].string
    temp46hour = json[SerializationKeys.temp46hour].string
    temp55hour = json[SerializationKeys.temp55hour].string
    temp40hour = json[SerializationKeys.temp40hour].string
    temp16hour = json[SerializationKeys.temp16hour].string
    temp43hour = json[SerializationKeys.temp43hour].string
    temp52hour = json[SerializationKeys.temp52hour].string
    temp49hour = json[SerializationKeys.temp49hour].string
    temp67hour = json[SerializationKeys.temp67hour].string
    temp31hour = json[SerializationKeys.temp31hour].string
    temp22hour = json[SerializationKeys.temp22hour].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = temp37hour { dictionary[SerializationKeys.temp37hour] = value }
    if let value = temp25hour { dictionary[SerializationKeys.temp25hour] = value }
    if let value = temp4hour { dictionary[SerializationKeys.temp4hour] = value }
    if let value = temp7hour { dictionary[SerializationKeys.temp7hour] = value }
    if let value = temp64hour { dictionary[SerializationKeys.temp64hour] = value }
    if let value = temp61hour { dictionary[SerializationKeys.temp61hour] = value }
    if let value = temp10hour { dictionary[SerializationKeys.temp10hour] = value }
    if let value = temp28hour { dictionary[SerializationKeys.temp28hour] = value }
    if let value = temp58hour { dictionary[SerializationKeys.temp58hour] = value }
    if let value = temp19hour { dictionary[SerializationKeys.temp19hour] = value }
    if let value = temp34hour { dictionary[SerializationKeys.temp34hour] = value }
    if let value = temp13hour { dictionary[SerializationKeys.temp13hour] = value }
    if let value = temp46hour { dictionary[SerializationKeys.temp46hour] = value }
    if let value = temp55hour { dictionary[SerializationKeys.temp55hour] = value }
    if let value = temp40hour { dictionary[SerializationKeys.temp40hour] = value }
    if let value = temp16hour { dictionary[SerializationKeys.temp16hour] = value }
    if let value = temp43hour { dictionary[SerializationKeys.temp43hour] = value }
    if let value = temp52hour { dictionary[SerializationKeys.temp52hour] = value }
    if let value = temp49hour { dictionary[SerializationKeys.temp49hour] = value }
    if let value = temp67hour { dictionary[SerializationKeys.temp67hour] = value }
    if let value = temp31hour { dictionary[SerializationKeys.temp31hour] = value }
    if let value = temp22hour { dictionary[SerializationKeys.temp22hour] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.temp37hour = aDecoder.decodeObject(forKey: SerializationKeys.temp37hour) as? String
    self.temp25hour = aDecoder.decodeObject(forKey: SerializationKeys.temp25hour) as? String
    self.temp4hour = aDecoder.decodeObject(forKey: SerializationKeys.temp4hour) as? String
    self.temp7hour = aDecoder.decodeObject(forKey: SerializationKeys.temp7hour) as? String
    self.temp64hour = aDecoder.decodeObject(forKey: SerializationKeys.temp64hour) as? String
    self.temp61hour = aDecoder.decodeObject(forKey: SerializationKeys.temp61hour) as? String
    self.temp10hour = aDecoder.decodeObject(forKey: SerializationKeys.temp10hour) as? String
    self.temp28hour = aDecoder.decodeObject(forKey: SerializationKeys.temp28hour) as? String
    self.temp58hour = aDecoder.decodeObject(forKey: SerializationKeys.temp58hour) as? String
    self.temp19hour = aDecoder.decodeObject(forKey: SerializationKeys.temp19hour) as? String
    self.temp34hour = aDecoder.decodeObject(forKey: SerializationKeys.temp34hour) as? String
    self.temp13hour = aDecoder.decodeObject(forKey: SerializationKeys.temp13hour) as? String
    self.temp46hour = aDecoder.decodeObject(forKey: SerializationKeys.temp46hour) as? String
    self.temp55hour = aDecoder.decodeObject(forKey: SerializationKeys.temp55hour) as? String
    self.temp40hour = aDecoder.decodeObject(forKey: SerializationKeys.temp40hour) as? String
    self.temp16hour = aDecoder.decodeObject(forKey: SerializationKeys.temp16hour) as? String
    self.temp43hour = aDecoder.decodeObject(forKey: SerializationKeys.temp43hour) as? String
    self.temp52hour = aDecoder.decodeObject(forKey: SerializationKeys.temp52hour) as? String
    self.temp49hour = aDecoder.decodeObject(forKey: SerializationKeys.temp49hour) as? String
    self.temp67hour = aDecoder.decodeObject(forKey: SerializationKeys.temp67hour) as? String
    self.temp31hour = aDecoder.decodeObject(forKey: SerializationKeys.temp31hour) as? String
    self.temp22hour = aDecoder.decodeObject(forKey: SerializationKeys.temp22hour) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(temp37hour, forKey: SerializationKeys.temp37hour)
    aCoder.encode(temp25hour, forKey: SerializationKeys.temp25hour)
    aCoder.encode(temp4hour, forKey: SerializationKeys.temp4hour)
    aCoder.encode(temp7hour, forKey: SerializationKeys.temp7hour)
    aCoder.encode(temp64hour, forKey: SerializationKeys.temp64hour)
    aCoder.encode(temp61hour, forKey: SerializationKeys.temp61hour)
    aCoder.encode(temp10hour, forKey: SerializationKeys.temp10hour)
    aCoder.encode(temp28hour, forKey: SerializationKeys.temp28hour)
    aCoder.encode(temp58hour, forKey: SerializationKeys.temp58hour)
    aCoder.encode(temp19hour, forKey: SerializationKeys.temp19hour)
    aCoder.encode(temp34hour, forKey: SerializationKeys.temp34hour)
    aCoder.encode(temp13hour, forKey: SerializationKeys.temp13hour)
    aCoder.encode(temp46hour, forKey: SerializationKeys.temp46hour)
    aCoder.encode(temp55hour, forKey: SerializationKeys.temp55hour)
    aCoder.encode(temp40hour, forKey: SerializationKeys.temp40hour)
    aCoder.encode(temp16hour, forKey: SerializationKeys.temp16hour)
    aCoder.encode(temp43hour, forKey: SerializationKeys.temp43hour)
    aCoder.encode(temp52hour, forKey: SerializationKeys.temp52hour)
    aCoder.encode(temp49hour, forKey: SerializationKeys.temp49hour)
    aCoder.encode(temp67hour, forKey: SerializationKeys.temp67hour)
    aCoder.encode(temp31hour, forKey: SerializationKeys.temp31hour)
    aCoder.encode(temp22hour, forKey: SerializationKeys.temp22hour)
  }

}
