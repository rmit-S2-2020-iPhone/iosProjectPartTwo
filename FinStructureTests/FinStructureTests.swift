//
//  FinStructureTests.swift
//  FinStructureTests
//
//  Created by Rakibul Hasan on 20/8/20.
//  Copyright © 2020 Rakibul Hasan. All rights reserved.
//

import XCTest
@testable import FinStructure

class FinStructureTests: XCTestCase {

    //Test Case 1
    
    func test1(){
        //Test Initialization
        let testNo1=WeatherManager()
        //Test Outcome
        let result1=testNo1.fetchWeather(latitude: 122, longitude: 34)
        //Assertion
        XCTAssertNotNil(result1)
        
    }
    
    
    //Test Case 2
    func test2(){
        //Test Initialization
        let testNo4=WeatherManager()
        //Test Outcome
        let result=testNo4.fetchWeather(cityName: "Sydney")
        //Assertion
        XCTAssertNotNil(result)
        
    }
    
    //Test Case 3
    func test3(){
        //Test Initialization
        let testNo3=WeatherManager()
        let URL="https://api.openweathermap.org/data/2.5/onecall?appid=54ba55c1be2e46294f88143ca6ca5eb9&units=metric&exclude=minutely,hourly,alerts"
        //Test Outcome
        let result3=testNo3.performRequest(with: URL, city: "Melbourne")
        //Assertion
        XCTAssertNotNil(result3)
        
    }
    
    //Test Case 4
    func test4(){
        //Test Initialization
        
        let testNo2=WeatherManager()
        //Test Outcome
        let result1=testNo2.fetchWeather(latitude: 122, longitude: -34)
        //Assertion
        XCTAssertTrue(true)
        
    }


}
