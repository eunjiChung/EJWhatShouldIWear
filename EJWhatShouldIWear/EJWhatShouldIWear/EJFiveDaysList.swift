//
//  EJFiveDaysList.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJFiveDaysList: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let main = "main"
    static let clouds = "clouds"
    static let weather = "weather"
    static let dtTxt = "dt_txt"
    static let dt = "dt"
    static let sys = "sys"
    static let wind = "wind"
  }

  // MARK: Properties
  public var main: EJFiveDaysMain?
  public var clouds: EJFiveDaysClouds?
  public var weather: [EJFiveDaysWeather]?
  public var dtTxt: String?
  public var dt: Int?
  public var sys: EJFiveDaysSys?
  public var wind: EJFiveDaysWind?

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
    main = EJFiveDaysMain(json: json[SerializationKeys.main])
    clouds = EJFiveDaysClouds(json: json[SerializationKeys.clouds])
    if let items = json[SerializationKeys.weather].array { weather = items.map { EJFiveDaysWeather(json: $0) } }
    dtTxt = json[SerializationKeys.dtTxt].string
    dt = json[SerializationKeys.dt].int
    sys = EJFiveDaysSys(json: json[SerializationKeys.sys])
    wind = EJFiveDaysWind(json: json[SerializationKeys.wind])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = main { dictionary[SerializationKeys.main] = value.dictionaryRepresentation() }
    if let value = clouds { dictionary[SerializationKeys.clouds] = value.dictionaryRepresentation() }
    if let value = weather { dictionary[SerializationKeys.weather] = value.map { $0.dictionaryRepresentation() } }
    if let value = dtTxt { dictionary[SerializationKeys.dtTxt] = value }
    if let value = dt { dictionary[SerializationKeys.dt] = value }
    if let value = sys { dictionary[SerializationKeys.sys] = value.dictionaryRepresentation() }
    if let value = wind { dictionary[SerializationKeys.wind] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.main = aDecoder.decodeObject(forKey: SerializationKeys.main) as? EJFiveDaysMain
    self.clouds = aDecoder.decodeObject(forKey: SerializationKeys.clouds) as? EJFiveDaysClouds
    self.weather = aDecoder.decodeObject(forKey: SerializationKeys.weather) as? [EJFiveDaysWeather]
    self.dtTxt = aDecoder.decodeObject(forKey: SerializationKeys.dtTxt) as? String
    self.dt = aDecoder.decodeObject(forKey: SerializationKeys.dt) as? Int
    self.sys = aDecoder.decodeObject(forKey: SerializationKeys.sys) as? EJFiveDaysSys
    self.wind = aDecoder.decodeObject(forKey: SerializationKeys.wind) as? EJFiveDaysWind
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(main, forKey: SerializationKeys.main)
    aCoder.encode(clouds, forKey: SerializationKeys.clouds)
    aCoder.encode(weather, forKey: SerializationKeys.weather)
    aCoder.encode(dtTxt, forKey: SerializationKeys.dtTxt)
    aCoder.encode(dt, forKey: SerializationKeys.dt)
    aCoder.encode(sys, forKey: SerializationKeys.sys)
    aCoder.encode(wind, forKey: SerializationKeys.wind)
  }

}
