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
  }
  
  private var dataSource = [PhotoSection]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // photoDescription이 nil이면 photo section으로,
    // nil이 아니면 dscription section으로
    self.view.addSubview(self.tableView)
    self.tableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    self.tableView.dataSource = self
    
    API.getPhotos { photo in
      print(photo.map { $0.description })
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
      return 0
    }
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch self.dataSource[indexPath.section] {
    case .image(let photos):
      let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
      cell.prepare(urlString: photos[indexPath.row].url)
      return cell
    case .description(let photos):
      let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
      cell.prepare(title: photos[indexPath.row].url)
      return cell
    case .loading:
      let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
      cell.prepare(mode: .loading)
      return cell
    }
  }
}
