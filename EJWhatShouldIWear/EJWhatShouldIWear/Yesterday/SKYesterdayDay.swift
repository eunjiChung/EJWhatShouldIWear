//
//  SKYesterdayDay.swift
//
//  Created by eunji on 10/09/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class SKYesterdayDay: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let timeRelease = "timeRelease"
    static let sky = "sky"
    static let temperature = "temperature"
    static let precipitation = "precipitation"
    static let hourly = "hourly"
  }

  // MARK: Properties
  public var timeRelease: String?
  public var sky: SKYesterdaySky?
  public var temperature: SKYesterdayTemperature?
  public var precipitation: SKYesterdayPrecipitation?
  public var hourly: [SKYesterdayHourly]?

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
    timeRelease = json[SerializationKeys.timeRelease].string
    sky = SKYesterdaySky(json: json[SerializationKeys.sky])
    temperature = SKYesterdayTemperature(json: json[SerializationKeys.temperature])
    precipitation = SKYesterdayPrecipitation(json: json[SerializationKeys.precipitation])
    if let items = json[SerializationKeys.hourly].array { hourly = items.map { SKYesterdayHourly(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = timeRelease { dictionary[SerializationKeys.timeRelease] = value }
    if let value = sky { dictionary[SerializationKeys.sky] = value.dictionaryRepresentation() }
    if let value = temperature { dictionary[SerializationKeys.temperature] = value.dictionaryRepresentation() }
    if let value = precipitation { dictionary[SerializationKeys.precipitation] = value.dictionaryRepresentation() }
    if let value = hourly { dictionary[SerializationKeys.hourly] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.timeRelease = aDecoder.decodeObject(forKey: SerializationKeys.timeRelease) as? String
    self.sky = aDecoder.decodeObject(forKey: SerializationKeys.sky) as? SKYesterdaySky
    self.temperature = aDecoder.decodeObject(forKey: SerializationKeys.temperature) as? SKYesterdayTemperature
    self.precipitation = aDecoder.decodeObject(forKey: SerializationKeys.precipitation) as? SKYesterdayPrecipitation
    self.hourly = aDecoder.decodeObject(forKey: SerializationKeys.hourly) as? [SKYesterdayHourly]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(timeRelease, forKey: SerializationKeys.timeRelease)
    aCoder.encode(sky, forKey: SerializationKeys.sky)
    aCoder.encode(temperature, forKey: SerializationKeys.temperature)
    aCoder.encode(precipitation, forKey: SerializationKeys.precipitation)
    aCoder.encode(hourly, forKey: SerializationKeys.hourly)
  }

}
