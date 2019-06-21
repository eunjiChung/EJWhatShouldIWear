//
//  EJFiveDaysWeatherModel.swift
//
//  Created by DEV_MOBILE_IOS_JUNIOR on 22/06/2019
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class EJFiveDaysWeatherModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let list = "list"
    static let cod = "cod"
    static let cnt = "cnt"
    static let message = "message"
    static let city = "city"
  }

  // MARK: Properties
  public var list: [EJFiveDaysList]?
  public var cod: String?
  public var cnt: Int?
  public var message: Float?
  public var city: EJFiveDaysCity?

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
    if let items = json[SerializationKeys.list].array { list = items.map { EJFiveDaysList(json: $0) } }
    cod = json[SerializationKeys.cod].string
    cnt = json[SerializationKeys.cnt].int
    message = json[SerializationKeys.message].float
    city = EJFiveDaysCity(json: json[SerializationKeys.city])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = list { dictionary[SerializationKeys.list] = value.map { $0.dictionaryRepresentation() } }
    if let value = cod { dictionary[SerializationKeys.cod] = value }
    if let value = cnt { dictionary[SerializationKeys.cnt] = value }
    if let value = message { dictionary[SerializationKeys.message] = value }
    if let value = city { dictionary[SerializationKeys.city] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.list = aDecoder.decodeObject(forKey: SerializationKeys.list) as? [EJFiveDaysList]
    self.cod = aDecoder.decodeObject(forKey: SerializationKeys.cod) as? String
    self.cnt = aDecoder.decodeObject(forKey: SerializationKeys.cnt) as? Int
    self.message = aDecoder.decodeObject(forKey: SerializationKeys.message) as? Float
    self.city = aDecoder.decodeObject(forKey: SerializationKeys.city) as? EJFiveDaysCity
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(list, forKey: SerializationKeys.list)
    aCoder.encode(cod, forKey: SerializationKeys.cod)
    aCoder.encode(cnt, forKey: SerializationKeys.cnt)
    aCoder.encode(message, forKey: SerializationKeys.message)
    aCoder.encode(city, forKey: SerializationKeys.city)
  }

}
