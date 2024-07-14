//
//  LoadFeedFromRemoteUseCaseTests.swift
//  CoreTests
//
//  Created by Afsal on 14/07/2024.
//

import XCTest
import Core

class LoadFeedFromRemoteUseCaseTests: XCTestCase {
  
  func test_init_doesNotRequestsDataFromURL() {
    let (_, client) = makeSUT()
    
    XCTAssertTrue(client.requestedURLs.isEmpty)
  }
  
  func test_load_requestsDataFromURL() {
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)
    
    sut.load { _ in }
    
    XCTAssertEqual(client.requestedURLs, [url])
  }
  
  func test_loadTwice_requestsDataFromURLTwice() {
    let url = URL(string: "https://a-given-url.com")!
    let (sut, client) = makeSUT(url: url)
    
    sut.load { _ in }
    sut.load { _ in }
    
    XCTAssertEqual(client.requestedURLs, [url, url])
  }
  
  func test_load_deliversErrorOnClientError() {
    let (sut, client) = makeSUT()
    
    expect(sut, toExpect: failure(.connectivity), when: {
      let clientError = NSError(domain: "Test", code: 0)
      client.complete(with: clientError)
    })
  }
  
  func test_load_deliversErrorOnNon200HTTPResponse() {
    let (sut, client) = makeSUT()
    
    let samples = [199, 201, 300, 400, 500]
    
    samples.enumerated().forEach { index, code in
      expect(sut, toExpect: failure(.invalidData), when: {
        let json = makeItemsJSON([])
        client.complete(withStatusCode: code, data: json, at: index)
      })
    }
  }
  
  func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
    let (sut, client) = makeSUT()
    
    expect(sut, toExpect: failure(.invalidData), when: {
      let invalidJSON = Data("invalid json".utf8)
      client.complete(withStatusCode: 200, data: invalidJSON)
    })
  }
  
  func test_load_deliversNoItemsOn200HTTPResponseWithEmptyList() {
    let (sut, client) = makeSUT()
    
    expect(sut, toExpect: .success([]), when: {
      let emptyListJSON = makeItemsJSON([])
      client.complete(withStatusCode: 200, data: emptyListJSON)
    })
  }
  
  func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
    let (sut, client) = makeSUT()
    
    let item1 = makeItem(
      name: "name",
      country: "country",
      code: "code",
      state: "state",
      webpage: "webpage")
    
    let item2 = makeItem(
      name: "another name",
      country: "another country",
      code: "another code",
      state: "another state",
      webpage: "another webpage")
    
    let items: [University] = [item1.model, item2.model]
    
    expect(sut, toExpect: .success(items), when: {
      let json = makeItemsJSON([item1.json, item2.json])
      client.complete(withStatusCode: 200, data: json)
    })
  }
  
  func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
    let url = URL(string: "http://any-url.com")!
    let client = HTTPClientSpy()
    var sut: RemoteListLoader? = RemoteListLoader(url: url, client: client)
    
    var capturedResults = [RemoteListLoader.Result]()
    sut?.load { capturedResults.append($0) }
    
    sut = nil
    client.complete(withStatusCode: 200, data: makeItemsJSON([]))
    
    XCTAssertTrue(capturedResults.isEmpty)
  }
  
  // MAKR: - Helpers
  
  private func makeSUT(url: URL = URL(string: "http://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteListLoader, client: HTTPClientSpy) {
    let client = HTTPClientSpy()
    let sut = RemoteListLoader(url: url, client: client)
    trackForMemoryLeaks(sut, file: file, line: line)
    trackForMemoryLeaks(client, file: file, line: line)
    return (sut, client)
  }
  
  private func expect(_ sut: RemoteListLoader, toExpect expectedResult: RemoteListLoader.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
    let exp = expectation(description: "Wait for load completion")
    
    sut.load { receivedResult in
      switch (receivedResult, expectedResult) {
      case let (.success(receivedItems), .success(expectedItems)):
        XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
        
      case let (.failure(receivedError as RemoteListLoader.Error), .failure(expectedError as RemoteListLoader.Error)):
        XCTAssertEqual(receivedError, expectedError, file: file, line: line)

      default:
        XCTFail("Expected result \(expectedResult) got \(receivedResult) instead.")
      }
      
      exp.fulfill()
    }
    
    action()
    
    wait(for: [exp], timeout: 1.0)
  }
  
  private func failure(_ error: RemoteListLoader.Error) -> RemoteListLoader.Result {
    return .failure(error)
  }
  
  private func makeItem(name: String, country: String, code: String, state: String?, webpage: String?) -> (model: University, json: [String: Any]) {
    let model = University(
      name: name,
      country: country,
      code: code,
      state: state,
      webpage: webpage
    )
    
    let json = [
      "name": model.name,
      "country": model.country,
      "alpha_two_code": model.code,
      "state-province": model.state ?? "",
      "web_pages": [model.webpage ?? ""]
    ].compactMapValues { $0 }
    
    return (model, json)
  }
  
  private func makeItemsJSON(_ items: [[String : Any]]) -> Data {
    return try! JSONSerialization.data(withJSONObject: items)
  }
}
