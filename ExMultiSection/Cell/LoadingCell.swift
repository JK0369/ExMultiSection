//
//  LoadingCell.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture

final class LoadingCell: UITableViewCell {
  enum Mode {
    case loading
    case refreshing
    
    var text: String? {
      switch self {
      case .loading:
        return "더 보기"
      case .refreshing:
        return nil
      }
    }
  }
  
  private let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 24)
  }
  
  var tapObservable: Observable<Void> {
    self.contentView.rx.tapGesture()
      .map { _ in Void() }
      .asObservable()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(self.titleLabel)
    
    self.titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(mode: .loading)
  }
  func prepare(mode: Mode) {
    self.titleLabel.text = mode.text
  }
}
