//
//  SKThreeFcst6hour.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKThreeFcst6hour: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let snow42hour = "snow42hour"
    static let snow6hour = "snow6hour"
    static let rain42hour = "rain42hour"
    static let snow60hour = "snow60hour"
    static let snow30hour = "snow30hour"
    static let rain60hour = "rain60hour"
    static let snow18hour = "snow18hour"
    static let rain18hour = "rain18hour"
    static let rain24hour = "rain24hour"
    static let rain36hour = "rain36hour"
    static let rain66hour = "rain66hour"
    static let snow36hour = "snow36hour"
    static let snow48hour = "snow48hour"
    static let rain6hour = "rain6hour"
    static let snow12hour = "snow12hour"
    static let rain30hour = "rain30hour"
    static let rain54hour = "rain54hour"
    static let snow24hour = "snow24hour"
    static let rain48hour = "rain48hour"
    static let snow54hour = "snow54hour"
    static let rain12hour = "rain12hour"
    static let snow66hour = "snow66hour"
  }

  // MARK: Properties
  public var snow42hour: String?
  public var snow6hour: String?
  public var rain42hour: String?
  public var snow60hour: String?
  public var snow30hour: String?
  public var rain60hour: String?
  public var snow18hour: String?
  public var rain18hour: String?
  public var rain24hour: String?
  public var rain36hour: String?
  public var rain66hour: String?
  public var snow36hour: String?
  public var snow48hour: String?
  public var rain6hour: String?
  public var snow12hour: String?
  public var rain30hour: String?
  public var rain54hour: String?
  public var snow24hour: String?
  public var rain48hour: String?
  public var snow54hour: String?
  public var rain12hour: String?
  public var snow66hour: String?

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
    snow42hour = json[SerializationKeys.snow42hour].string
    snow6hour = json[SerializationKeys.snow6hour].string
    rain42hour = json[SerializationKeys.rain42hour].string
    snow60hour = json[SerializationKeys.snow60hour].string
    snow30hour = json[SerializationKeys.snow30hour].string
    rain60hour = json[SerializationKeys.rain60hour].string
    snow18hour = json[SerializationKeys.snow18hour].string
    rain18hour = json[SerializationKeys.rain18hour].string
    rain24hour = json[SerializationKeys.rain24hour].string
    rain36hour = json[SerializationKeys.rain36hour].string
    rain66hour = json[SerializationKeys.rain66hour].string
    snow36hour = json[SerializationKeys.snow36hour].string
    snow48hour = json[SerializationKeys.snow48hour].string
    rain6hour = json[SerializationKeys.rain6hour].string
    snow12hour = json[SerializationKeys.snow12hour].string
    rain30hour = json[SerializationKeys.rain30hour].string
    rain54hour = json[SerializationKeys.rain54hour].string
    snow24hour = json[SerializationKeys.snow24hour].string
    rain48hour = json[SerializationKeys.rain48hour].string
    snow54hour = json[SerializationKeys.snow54hour].string
    rain12hour = json[SerializationKeys.rain12hour].string
    snow66hour = json[SerializationKeys.snow66hour].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = snow42hour { dictionary[SerializationKeys.snow42hour] = value }
    if let value = snow6hour { dictionary[SerializationKeys.snow6hour] = value }
    if let value = rain42hour { dictionary[SerializationKeys.rain42hour] = value }
    if let value = snow60hour { dictionary[SerializationKeys.snow60hour] = value }
    if let value = snow30hour { dictionary[SerializationKeys.snow30hour] = value }
    if let value = rain60hour { dictionary[SerializationKeys.rain60hour] = value }
    if let value = snow18hour { dictionary[SerializationKeys.snow18hour] = value }
    if let value = rain18hour { dictionary[SerializationKeys.rain18hour] = value }
    if let value = rain24hour { dictionary[SerializationKeys.rain24hour] = value }
    if let value = rain36hour { dictionary[SerializationKeys.rain36hour] = value }
    if let value = rain66hour { dictionary[SerializationKeys.rain66hour] = value }
    if let value = snow36hour { dictionary[SerializationKeys.snow36hour] = value }
    if let value = snow48hour { dictionary[SerializationKeys.snow48hour] = value }
    if let value = rain6hour { dictionary[SerializationKeys.rain6hour] = value }
    if let value = snow12hour { dictionary[SerializationKeys.snow12hour] = value }
    if let value = rain30hour { dictionary[SerializationKeys.rain30hour] = value }
    if let value = rain54hour { dictionary[SerializationKeys.rain54hour] = value }
    if let value = snow24hour { dictionary[SerializationKeys.snow24hour] = value }
    if let value = rain48hour { dictionary[SerializationKeys.rain48hour] = value }
    if let value = snow54hour { dictionary[SerializationKeys.snow54hour] = value }
    if let value = rain12hour { dictionary[SerializationKeys.rain12hour] = value }
    if let value = snow66hour { dictionary[SerializationKeys.snow66hour] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.snow42hour = aDecoder.decodeObject(forKey: SerializationKeys.snow42hour) as? String
    self.snow6hour = aDecoder.decodeObject(forKey: SerializationKeys.snow6hour) as? String
    self.rain42hour = aDecoder.decodeObject(forKey: SerializationKeys.rain42hour) as? String
    self.snow60hour = aDecoder.decodeObject(forKey: SerializationKeys.snow60hour) as? String
    self.snow30hour = aDecoder.decodeObject(forKey: SerializationKeys.snow30hour) as? String
    self.rain60hour = aDecoder.decodeObject(forKey: SerializationKeys.rain60hour) as? String
    self.snow18hour = aDecoder.decodeObject(forKey: SerializationKeys.snow18hour) as? String
    self.rain18hour = aDecoder.decodeObject(forKey: SerializationKeys.rain18hour) as? String
    self.rain24hour = aDecoder.decodeObject(forKey: SerializationKeys.rain24hour) as? String
    self.rain36hour = aDecoder.decodeObject(forKey: SerializationKeys.rain36hour) as? String
    self.rain66hour = aDecoder.decodeObject(forKey: SerializationKeys.rain66hour) as? String
    self.snow36hour = aDecoder.decodeObject(forKey: SerializationKeys.snow36hour) as? String
    self.snow48hour = aDecoder.decodeObject(forKey: SerializationKeys.snow48hour) as? String
    self.rain6hour = aDecoder.decodeObject(forKey: SerializationKeys.rain6hour) as? String
    self.snow12hour = aDecoder.decodeObject(forKey: SerializationKeys.snow12hour) as? String
    self.rain30hour = aDecoder.decodeObject(forKey: SerializationKeys.rain30hour) as? String
    self.rain54hour = aDecoder.decodeObject(forKey: SerializationKeys.rain54hour) as? String
    self.snow24hour = aDecoder.decodeObject(forKey: SerializationKeys.snow24hour) as? String
    self.rain48hour = aDecoder.decodeObject(forKey: SerializationKeys.rain48hour) as? String
    self.snow54hour = aDecoder.decodeObject(forKey: SerializationKeys.snow54hour) as? String
    self.rain12hour = aDecoder.decodeObject(forKey: SerializationKeys.rain12hour) as? String
    self.snow66hour = aDecoder.decodeObject(forKey: SerializationKeys.snow66hour) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(snow42hour, forKey: SerializationKeys.snow42hour)
    aCoder.encode(snow6hour, forKey: SerializationKeys.snow6hour)
    aCoder.encode(rain42hour, forKey: SerializationKeys.rain42hour)
    aCoder.encode(snow60hour, forKey: SerializationKeys.snow60hour)
    aCoder.encode(snow30hour, forKey: SerializationKeys.snow30hour)
    aCoder.encode(rain60hour, forKey: SerializationKeys.rain60hour)
    aCoder.encode(snow18hour, forKey: SerializationKeys.snow18hour)
    aCoder.encode(rain18hour, forKey: SerializationKeys.rain18hour)
    aCoder.encode(rain24hour, forKey: SerializationKeys.rain24hour)
    aCoder.encode(rain36hour, forKey: SerializationKeys.rain36hour)
    aCoder.encode(rain66hour, forKey: SerializationKeys.rain66hour)
    aCoder.encode(snow36hour, forKey: SerializationKeys.snow36hour)
    aCoder.encode(snow48hour, forKey: SerializationKeys.snow48hour)
    aCoder.encode(rain6hour, forKey: SerializationKeys.rain6hour)
    aCoder.encode(snow12hour, forKey: SerializationKeys.snow12hour)
    aCoder.encode(rain30hour, forKey: SerializationKeys.rain30hour)
    aCoder.encode(rain54hour, forKey: SerializationKeys.rain54hour)
    aCoder.encode(snow24hour, forKey: SerializationKeys.snow24hour)
    aCoder.encode(rain48hour, forKey: SerializationKeys.rain48hour)
    aCoder.encode(snow54hour, forKey: SerializationKeys.snow54hour)
    aCoder.encode(rain12hour, forKey: SerializationKeys.rain12hour)
    aCoder.encode(snow66hour, forKey: SerializationKeys.snow66hour)
  }

}
