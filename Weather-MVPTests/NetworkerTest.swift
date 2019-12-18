//
//  NetworkerTest.swift
//  WeatherTests
//
//  Created by Godwin Olorunshola on 15/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import XCTest
@testable import Weather-MVP

class NetworkerTest: XCTestCase {

    var testURLSession : URLSession!

    override func setUp() {
        testURLSession = URLSession(configuration: URLSessionConfiguration.default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   func testValidURL(){
        let url = URL(string: String(format : URLConstants.getCurrentForcast, String(37.7953), String(37.9161)))!
        let promise = expectation(description: "Status Code : 200")
        
        testURLSession!.dataTask(with: url) { (data, response, error) in
            if error != nil{
                XCTFail(error?.localizedDescription ?? "")
                return
            }
            
            if let url = (response as? HTTPURLResponse)?.url{
                XCTAssertEqual(String(format : URLConstants.getCurrentForcast, String(37.7953), String(37.9161)), url.absoluteString)
                promise.fulfill()
            }
        }.resume()
        
        
        waitForExpectations(timeout: 10, handler: nil)
     
    }
    
    
    func testCallToApiReturns200(){
        
        let url = URL(string: String(format : URLConstants.getCurrentForcast, String(37.7953), String(37.9161)))!
        let promise = expectation(description: "Status Code : 200")
        
        testURLSession!.dataTask(with: url) { (data, response, error) in
            if error != nil{
                XCTFail(error?.localizedDescription ?? "")
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 200{
                    promise.fulfill()
                }else{
                    XCTFail("Status Code \(statusCode)")
                }
            }
        }.resume()
        
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    func testReturnDataIsValid(){
        
        let promise = expectation(description: "waiting for Movie Response")
        let url = String(format : URLConstants.getCurrentForcast, String(37.7953), String(37.9161))
        Networker.shared.makeGetRequest(session : testURLSession, url: url, completion: { (result : Result<Forecast, APIError>) in
            switch result{
                case .success(let forecast):
                   XCTAssertNotNil(forecast)
                    promise.fulfill()
                case .failure(let reason):
                    XCTFail(reason.localizedDescription)
            }
            
        })
        
        waitForExpectations(timeout: 20, handler: nil)

    }
    
    
    func testFailure(){
        
        
        let promise = expectation(description: "waiting for Movie Response")
            
        // testing the url without supplying lat and long
        Networker.shared.makeGetRequest(session : testURLSession, url: URLConstants.getCurrentForcast, completion: { (result : Result<Forecast, APIError>) in
                switch result{
                case .success( _):
                       XCTFail()
                    case .failure(let reason):
                        promise.fulfill()
                }
        
          })
            waitForExpectations(timeout: 10, handler: nil)
        }

}
