//
//  SceneDelegate.swift
//  ListApp
//
//  Created by Afsal on 02/05/2024.
//

import UIKit
import CoreData
import Core
import ModuleA

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  private lazy var httpClient: HTTPClient = {
    URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
  }()

  private lazy var store: ListStore = {
    try! CoreDataListStore(
      storeURL: NSPersistentContainer
      .defaultDirectoryURL()
      .appendingPathComponent("feed-store.sqlite"))
  }()
  
  private lazy var localFeedLoader: LocalFeedLoader = {
    LocalFeedLoader(store: store)
  }()
  
  private lazy var listViewController: ListViewController = {
    let listLoader = FeedLoaderWithFallbackComposite(
      primary: FeedLoaderCacheDecorator(
        decoratee: makeRemoteFeedLoader(),
        cache: localFeedLoader),
      fallback: localFeedLoader)

    return ListUIComposer.listComposedWith(
      with: listLoader,
      selection: showDetailView)
  }()
  
  private lazy var navigationController: UINavigationController = {
    return UINavigationController(rootViewController: listViewController)
  }()

  convenience init(httpClient: HTTPClient, store: ListStore) {
    self.init()
    self.httpClient = httpClient
    self.store = store
  }

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    
    configureWindow(with: scene)
  }
   
  func configureWindow(with scene: UIWindowScene) {
    window = UIWindow(windowScene: scene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  private func makeRemoteFeedLoader() -> RemoteFeedLoader {
    let remoteURL = URL(string: "http://universities.hipolabs.com/search?country=United%20Arab%20Emirates")!
    return RemoteFeedLoader(url: remoteURL, client: httpClient)
  }
  
  private func showDetailView(for model: University) {
    let controller = DetailUIComposer.detailComposed(with: model)
    let nav = UINavigationController(rootViewController: controller)
    nav.modalPresentationStyle = .fullScreen
    navigationController.present(nav, animated: true)
  }
}

