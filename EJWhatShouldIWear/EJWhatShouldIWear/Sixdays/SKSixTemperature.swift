//
//  SKSixTemperature.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKSixTemperature: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let tmin6day = "tmin6day"
    static let tmin4day = "tmin4day"
    static let tmin7day = "tmin7day"
    static let tmin5day = "tmin5day"
    static let tmax4day = "tmax4day"
    static let tmax8day = "tmax8day"
    static let tmin10day = "tmin10day"
    static let tmax2day = "tmax2day"
    static let tmin3day = "tmin3day"
    static let tmax3day = "tmax3day"
    static let tmax7day = "tmax7day"
    static let tmax9day = "tmax9day"
    static let tmin2day = "tmin2day"
    static let tmin8day = "tmin8day"
    static let tmax10day = "tmax10day"
    static let tmax5day = "tmax5day"
    static let tmin9day = "tmin9day"
    static let tmax6day = "tmax6day"
  }

  // MARK: Properties
  public var tmin6day: String?
  public var tmin4day: String?
  public var tmin7day: String?
  public var tmin5day: String?
  public var tmax4day: String?
  public var tmax8day: String?
  public var tmin10day: String?
  public var tmax2day: String?
  public var tmin3day: String?
  public var tmax3day: String?
  public var tmax7day: String?
  public var tmax9day: String?
  public var tmin2day: String?
  public var tmin8day: String?
  public var tmax10day: String?
  public var tmax5day: String?
  public var tmin9day: String?
  public var tmax6day: String?

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
    tmin6day = json[SerializationKeys.tmin6day].string
    tmin4day = json[SerializationKeys.tmin4day].string
    tmin7day = json[SerializationKeys.tmin7day].string
    tmin5day = json[SerializationKeys.tmin5day].string
    tmax4day = json[SerializationKeys.tmax4day].string
    tmax8day = json[SerializationKeys.tmax8day].string
    tmin10day = json[SerializationKeys.tmin10day].string
    tmax2day = json[SerializationKeys.tmax2day].string
    tmin3day = json[SerializationKeys.tmin3day].string
    tmax3day = json[SerializationKeys.tmax3day].string
    tmax7day = json[SerializationKeys.tmax7day].string
    tmax9day = json[SerializationKeys.tmax9day].string
    tmin2day = json[SerializationKeys.tmin2day].string
    tmin8day = json[SerializationKeys.tmin8day].string
    tmax10day = json[SerializationKeys.tmax10day].string
    tmax5day = json[SerializationKeys.tmax5day].string
    tmin9day = json[SerializationKeys.tmin9day].string
    tmax6day = json[SerializationKeys.tmax6day].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = tmin6day { dictionary[SerializationKeys.tmin6day] = value }
    if let value = tmin4day { dictionary[SerializationKeys.tmin4day] = value }
    if let value = tmin7day { dictionary[SerializationKeys.tmin7day] = value }
    if let value = tmin5day { dictionary[SerializationKeys.tmin5day] = value }
    if let value = tmax4day { dictionary[SerializationKeys.tmax4day] = value }
    if let value = tmax8day { dictionary[SerializationKeys.tmax8day] = value }
    if let value = tmin10day { dictionary[SerializationKeys.tmin10day] = value }
    if let value = tmax2day { dictionary[SerializationKeys.tmax2day] = value }
    if let value = tmin3day { dictionary[SerializationKeys.tmin3day] = value }
    if let value = tmax3day { dictionary[SerializationKeys.tmax3day] = value }
    if let value = tmax7day { dictionary[SerializationKeys.tmax7day] = value }
    if let value = tmax9day { dictionary[SerializationKeys.tmax9day] = value }
    if let value = tmin2day { dictionary[SerializationKeys.tmin2day] = value }
    if let value = tmin8day { dictionary[SerializationKeys.tmin8day] = value }
    if let value = tmax10day { dictionary[SerializationKeys.tmax10day] = value }
    if let value = tmax5day { dictionary[SerializationKeys.tmax5day] = value }
    if let value = tmin9day { dictionary[SerializationKeys.tmin9day] = value }
    if let value = tmax6day { dictionary[SerializationKeys.tmax6day] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.tmin6day = aDecoder.decodeObject(forKey: SerializationKeys.tmin6day) as? String
    self.tmin4day = aDecoder.decodeObject(forKey: SerializationKeys.tmin4day) as? String
    self.tmin7day = aDecoder.decodeObject(forKey: SerializationKeys.tmin7day) as? String
    self.tmin5day = aDecoder.decodeObject(forKey: SerializationKeys.tmin5day) as? String
    self.tmax4day = aDecoder.decodeObject(forKey: SerializationKeys.tmax4day) as? String
    self.tmax8day = aDecoder.decodeObject(forKey: SerializationKeys.tmax8day) as? String
    self.tmin10day = aDecoder.decodeObject(forKey: SerializationKeys.tmin10day) as? String
    self.tmax2day = aDecoder.decodeObject(forKey: SerializationKeys.tmax2day) as? String
    self.tmin3day = aDecoder.decodeObject(forKey: SerializationKeys.tmin3day) as? String
    self.tmax3day = aDecoder.decodeObject(forKey: SerializationKeys.tmax3day) as? String
    self.tmax7day = aDecoder.decodeObject(forKey: SerializationKeys.tmax7day) as? String
    self.tmax9day = aDecoder.decodeObject(forKey: SerializationKeys.tmax9day) as? String
    self.tmin2day = aDecoder.decodeObject(forKey: SerializationKeys.tmin2day) as? String
    self.tmin8day = aDecoder.decodeObject(forKey: SerializationKeys.tmin8day) as? String
    self.tmax10day = aDecoder.decodeObject(forKey: SerializationKeys.tmax10day) as? String
    self.tmax5day = aDecoder.decodeObject(forKey: SerializationKeys.tmax5day) as? String
    self.tmin9day = aDecoder.decodeObject(forKey: SerializationKeys.tmin9day) as? String
    self.tmax6day = aDecoder.decodeObject(forKey: SerializationKeys.tmax6day) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(tmin6day, forKey: SerializationKeys.tmin6day)
    aCoder.encode(tmin4day, forKey: SerializationKeys.tmin4day)
    aCoder.encode(tmin7day, forKey: SerializationKeys.tmin7day)
    aCoder.encode(tmin5day, forKey: SerializationKeys.tmin5day)
    aCoder.encode(tmax4day, forKey: SerializationKeys.tmax4day)
    aCoder.encode(tmax8day, forKey: SerializationKeys.tmax8day)
    aCoder.encode(tmin10day, forKey: SerializationKeys.tmin10day)
    aCoder.encode(tmax2day, forKey: SerializationKeys.tmax2day)
    aCoder.encode(tmin3day, forKey: SerializationKeys.tmin3day)
    aCoder.encode(tmax3day, forKey: SerializationKeys.tmax3day)
    aCoder.encode(tmax7day, forKey: SerializationKeys.tmax7day)
    aCoder.encode(tmax9day, forKey: SerializationKeys.tmax9day)
    aCoder.encode(tmin2day, forKey: SerializationKeys.tmin2day)
    aCoder.encode(tmin8day, forKey: SerializationKeys.tmin8day)
    aCoder.encode(tmax10day, forKey: SerializationKeys.tmax10day)
    aCoder.encode(tmax5day, forKey: SerializationKeys.tmax5day)
    aCoder.encode(tmin9day, forKey: SerializationKeys.tmin9day)
    aCoder.encode(tmax6day, forKey: SerializationKeys.tmax6day)
  }

}
