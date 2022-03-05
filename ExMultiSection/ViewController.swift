//
//  ViewController.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {
  private let tableView = UITableView().then {
    $0.register(PhotoCell.self, forCellReuseIdentifier: "PhotoCell")
    $0.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
    $0.register(LoadingCell.self, forCellReuseIdentifier: "LoadingCell")
    $0.rowHeight = UITableView.automaticDimension
    $0.estimatedRowHeight = 1000
    $0.tableFooterView = UIView()
    $0.separatorStyle = .none
  }
  
  private var dataSource = [PhotoSection]()
  private var isRefreshing = false
  private var page = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.refresh()
  }
  private func refresh() {
    self.isRefreshing = true
    self.page += 1
    API.getPhotos(page: self.page) { [weak self] photos in
      guard let ss = self else { return }
      ss.isRefreshing = false
      let photoDataSource = photos.filter { $0.description == nil }
      let descriptionDataSource = photos.filter { $0.description != nil }
      if !ss.dataSource.isEmpty {
        ss.dataSource.remove(at: ss.dataSource.count - 1)
      }
      ss.dataSource.append(
        contentsOf: [
          .image(photoDataSource),
          .description(descriptionDataSource),
          .loading
        ]
      )
      ss.tableView.reloadData()
    }
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    self.dataSource.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch self.dataSource[section] {
    case let .image(photos):
      return photos.count
    case let .description(photos):
      return photos.count
    case .loading:
      return 1
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch self.dataSource[indexPath.section] {
    case .image(let photos):
      let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
      cell.prepare(urlString: photos[indexPath.row].url)
      cell.updateImagesSubejct
        .bind {
          tableView.beginUpdates()
          tableView.endUpdates()
        }
        .disposed(by: cell.disposeBag)
      return cell
    case .description(let photos):
      let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
      cell.prepare(title: photos[indexPath.row].url)
      return cell
    case .loading:
      let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
      cell.prepare(mode: self.isRefreshing ? .refreshing : .more)
      return cell
    }
  }
}

extension ViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    guard case .loading = self.dataSource[indexPath.section] else { return }
    self.refresh()
  }
}
