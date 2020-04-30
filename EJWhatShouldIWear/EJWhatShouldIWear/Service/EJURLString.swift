//
//  EJURLString.swift
//  EJWhatShouldIWear
//
//  Created by CHUNGEUNJI on 17/04/2020.
//  Copyright © 2020 DEV_MOBILE_IOS_JUNIOR. All rights reserved.
//

import Foundation

// Firebase App ID : evPE2Kib0Lo

// MARK: - App Store URL
public let AppStoreURL                          =   "https://apps.apple.com/kr/app/%EC%98%A4%EB%8A%98%EB%AA%A8%EC%9E%85%EC%A7%80/id1469342013"
public let appStoreID                           =   "1469342013"

// MARK: - Google Admob
public let googleAdmobAppID                     =   "ca-app-pub-1994779937843028~3906710093"
public let googleAdmobUnitID                    =   "ca-app-pub-1994779937843028/3973448265"
//public let googleAdmobUnitID                    =   "ca-app-pub-3940256099942544/2934735716" // Google's TestID

// MARK: - OpenWeatherMAP
public let owmAPIPath                           =   "http://api.openweathermap.org/data/2.5/"
public let owmAppKey                            =   "a773e2be7cd5ee1befcfc2fc349d43ad"

// MARK: - SK Weather Planet API
public let skWPSixDaysAPI                       =   "https://apis.openapi.sk.com/weather/forecast/6days"
public let skWPThreeDaysAPI                     =   "https://apis.openapi.sk.com/weather/forecast/3days"

// MARK: - SK Weather Planet App Key
// TODO: - 걷어내야 함..5월말 서비스 종료 예정
public let skPublicAppKey                  =   ["6ebc2338-3b54-4ad2-a92c-55dddb172a5a", "l7xx2cfb4793438c4e3a998a64de9fd0bc35", "l7xx0cdff2e5ded248f99ebdf01d919a97c9", "l7xx71e44e191b1a43349329fa37709c87c8", "l7xx58f2c99840cc44a5935ab6409eb57411", "l7xxad48ba72974c4787bd162b5209f99633", "l7xxfc6cf2f52e9c496da4d1d9a7f9d1a506", "l7xx741e97f0e03e44c980995ffeae8d9153", "l7xx50caea38dc184c6fac59abb6256f7c82", "l7xx80207c6ed8674b28a1259ba6e399839f", "73f51154-b4cc-485c-b9ce-85130eac089d", "l7xx17ff4fedacf84adeb1192646071938c3", "l7xx04758b9a2bc2480cb6671b5080239420", "l7xx9da60a1ad7784612a36e1e843923ae7f", "l7xx46714c108c084ed0ac600d245ed13ad3", "l7xx03f04a79d8984fb39d5166db578bfbed", "l7xx772fe6ada5e24b3686143e0211a63c22", "l7xx7816e348aeea466cbae103a16a3451e5", "l7xx9ca76dccb56f4012a9132cae7444125f", "l7xx0105114ef488451c9876ed6deb01dea1", "l7xx551098d68254454786cd02277eeface5", "l7xxc80c0ff07a0f46e1bfa55cb747af78db", "l7xxc0196ad4c61e48709cfaac8b0c12d56f"]
public let skDebugAppKey                        =   ["cd0c9c72-6e32-4181-9291-9340adb8d0dc"]

#if DEBUG
let skAppKeys = skDebugAppKey
#else
var skAppKeys = skPublicAppKey
#endif
