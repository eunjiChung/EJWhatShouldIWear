//
//  SKThreeHumidity.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeHumidity: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let rh22hour = "rh22hour"
    static let rh46hour = "rh46hour"
    static let rh55hour = "rh55hour"
    static let rh61hour = "rh61hour"
    static let rh10hour = "rh10hour"
    static let rh28hour = "rh28hour"
    static let rh43hour = "rh43hour"
    static let rh7hour = "rh7hour"
    static let rh19hour = "rh19hour"
    static let rh4hour = "rh4hour"
    static let rh25hour = "rh25hour"
    static let rh67hour = "rh67hour"
    static let rh52hour = "rh52hour"
    static let rh40hour = "rh40hour"
    static let rh37hour = "rh37hour"
    static let rh16hour = "rh16hour"
    static let rh31hour = "rh31hour"
    static let rh49hour = "rh49hour"
    static let rh34hour = "rh34hour"
    static let rh58hour = "rh58hour"
    static let rh64hour = "rh64hour"
    static let rh13hour = "rh13hour"
  }

  // MARK: Properties
  public var rh22hour: String?
  public var rh46hour: String?
  public var rh55hour: String?
  public var rh61hour: String?
  public var rh10hour: String?
  public var rh28hour: String?
  public var rh43hour: String?
  public var rh7hour: String?
  public var rh19hour: String?
  public var rh4hour: String?
  public var rh25hour: String?
  public var rh67hour: String?
  public var rh52hour: String?
  public var rh40hour: String?
  public var rh37hour: String?
  public var rh16hour: String?
  public var rh31hour: String?
  public var rh49hour: String?
  public var rh34hour: String?
  public var rh58hour: String?
  public var rh64hour: String?
  public var rh13hour: String?

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
    rh22hour = json[SerializationKeys.rh22hour].string
    rh46hour = json[SerializationKeys.rh46hour].string
    rh55hour = json[SerializationKeys.rh55hour].string
    rh61hour = json[SerializationKeys.rh61hour].string
    rh10hour = json[SerializationKeys.rh10hour].string
    rh28hour = json[SerializationKeys.rh28hour].string
    rh43hour = json[SerializationKeys.rh43hour].string
    rh7hour = json[SerializationKeys.rh7hour].string
    rh19hour = json[SerializationKeys.rh19hour].string
    rh4hour = json[SerializationKeys.rh4hour].string
    rh25hour = json[SerializationKeys.rh25hour].string
    rh67hour = json[SerializationKeys.rh67hour].string
    rh52hour = json[SerializationKeys.rh52hour].string
    rh40hour = json[SerializationKeys.rh40hour].string
    rh37hour = json[SerializationKeys.rh37hour].string
    rh16hour = json[SerializationKeys.rh16hour].string
    rh31hour = json[SerializationKeys.rh31hour].string
    rh49hour = json[SerializationKeys.rh49hour].string
    rh34hour = json[SerializationKeys.rh34hour].string
    rh58hour = json[SerializationKeys.rh58hour].string
    rh64hour = json[SerializationKeys.rh64hour].string
    rh13hour = json[SerializationKeys.rh13hour].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = rh22hour { dictionary[SerializationKeys.rh22hour] = value }
    if let value = rh46hour { dictionary[SerializationKeys.rh46hour] = value }
    if let value = rh55hour { dictionary[SerializationKeys.rh55hour] = value }
    if let value = rh61hour { dictionary[SerializationKeys.rh61hour] = value }
    if let value = rh10hour { dictionary[SerializationKeys.rh10hour] = value }
    if let value = rh28hour { dictionary[SerializationKeys.rh28hour] = value }
    if let value = rh43hour { dictionary[SerializationKeys.rh43hour] = value }
    if let value = rh7hour { dictionary[SerializationKeys.rh7hour] = value }
    if let value = rh19hour { dictionary[SerializationKeys.rh19hour] = value }
    if let value = rh4hour { dictionary[SerializationKeys.rh4hour] = value }
    if let value = rh25hour { dictionary[SerializationKeys.rh25hour] = value }
    if let value = rh67hour { dictionary[SerializationKeys.rh67hour] = value }
    if let value = rh52hour { dictionary[SerializationKeys.rh52hour] = value }
    if let value = rh40hour { dictionary[SerializationKeys.rh40hour] = value }
    if let value = rh37hour { dictionary[SerializationKeys.rh37hour] = value }
    if let value = rh16hour { dictionary[SerializationKeys.rh16hour] = value }
    if let value = rh31hour { dictionary[SerializationKeys.rh31hour] = value }
    if let value = rh49hour { dictionary[SerializationKeys.rh49hour] = value }
    if let value = rh34hour { dictionary[SerializationKeys.rh34hour] = value }
    if let value = rh58hour { dictionary[SerializationKeys.rh58hour] = value }
    if let value = rh64hour { dictionary[SerializationKeys.rh64hour] = value }
    if let value = rh13hour { dictionary[SerializationKeys.rh13hour] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.rh22hour = aDecoder.decodeObject(forKey: SerializationKeys.rh22hour) as? String
    self.rh46hour = aDecoder.decodeObject(forKey: SerializationKeys.rh46hour) as? String
    self.rh55hour = aDecoder.decodeObject(forKey: SerializationKeys.rh55hour) as? String
    self.rh61hour = aDecoder.decodeObject(forKey: SerializationKeys.rh61hour) as? String
    self.rh10hour = aDecoder.decodeObject(forKey: SerializationKeys.rh10hour) as? String
    self.rh28hour = aDecoder.decodeObject(forKey: SerializationKeys.rh28hour) as? String
    self.rh43hour = aDecoder.decodeObject(forKey: SerializationKeys.rh43hour) as? String
    self.rh7hour = aDecoder.decodeObject(forKey: SerializationKeys.rh7hour) as? String
    self.rh19hour = aDecoder.decodeObject(forKey: SerializationKeys.rh19hour) as? String
    self.rh4hour = aDecoder.decodeObject(forKey: SerializationKeys.rh4hour) as? String
    self.rh25hour = aDecoder.decodeObject(forKey: SerializationKeys.rh25hour) as? String
    self.rh67hour = aDecoder.decodeObject(forKey: SerializationKeys.rh67hour) as? String
    self.rh52hour = aDecoder.decodeObject(forKey: SerializationKeys.rh52hour) as? String
    self.rh40hour = aDecoder.decodeObject(forKey: SerializationKeys.rh40hour) as? String
    self.rh37hour = aDecoder.decodeObject(forKey: SerializationKeys.rh37hour) as? String
    self.rh16hour = aDecoder.decodeObject(forKey: SerializationKeys.rh16hour) as? String
    self.rh31hour = aDecoder.decodeObject(forKey: SerializationKeys.rh31hour) as? String
    self.rh49hour = aDecoder.decodeObject(forKey: SerializationKeys.rh49hour) as? String
    self.rh34hour = aDecoder.decodeObject(forKey: SerializationKeys.rh34hour) as? String
    self.rh58hour = aDecoder.decodeObject(forKey: SerializationKeys.rh58hour) as? String
    self.rh64hour = aDecoder.decodeObject(forKey: SerializationKeys.rh64hour) as? String
    self.rh13hour = aDecoder.decodeObject(forKey: SerializationKeys.rh13hour) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(rh22hour, forKey: SerializationKeys.rh22hour)
    aCoder.encode(rh46hour, forKey: SerializationKeys.rh46hour)
    aCoder.encode(rh55hour, forKey: SerializationKeys.rh55hour)
    aCoder.encode(rh61hour, forKey: SerializationKeys.rh61hour)
    aCoder.encode(rh10hour, forKey: SerializationKeys.rh10hour)
    aCoder.encode(rh28hour, forKey: SerializationKeys.rh28hour)
    aCoder.encode(rh43hour, forKey: SerializationKeys.rh43hour)
    aCoder.encode(rh7hour, forKey: SerializationKeys.rh7hour)
    aCoder.encode(rh19hour, forKey: SerializationKeys.rh19hour)
    aCoder.encode(rh4hour, forKey: SerializationKeys.rh4hour)
    aCoder.encode(rh25hour, forKey: SerializationKeys.rh25hour)
    aCoder.encode(rh67hour, forKey: SerializationKeys.rh67hour)
    aCoder.encode(rh52hour, forKey: SerializationKeys.rh52hour)
    aCoder.encode(rh40hour, forKey: SerializationKeys.rh40hour)
    aCoder.encode(rh37hour, forKey: SerializationKeys.rh37hour)
    aCoder.encode(rh16hour, forKey: SerializationKeys.rh16hour)
    aCoder.encode(rh31hour, forKey: SerializationKeys.rh31hour)
    aCoder.encode(rh49hour, forKey: SerializationKeys.rh49hour)
    aCoder.encode(rh34hour, forKey: SerializationKeys.rh34hour)
    aCoder.encode(rh58hour, forKey: SerializationKeys.rh58hour)
    aCoder.encode(rh64hour, forKey: SerializationKeys.rh64hour)
    aCoder.encode(rh13hour, forKey: SerializationKeys.rh13hour)
  }

}
