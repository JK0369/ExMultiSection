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
    case more
    case refreshing
    
    var text: String? {
      switch self {
      case .more:
        return "더 보기..."
      case .refreshing:
        return nil
      }
    }
  }
  
  private let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 24)
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  
  var tapObservable: Observable<Void> {
    self.contentView.rx.tapGesture()
      .map { _ in Void() }
      .asObservable()
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.backgroundColor = .systemBlue
    self.contentView.addSubview(self.titleLabel)
    
    self.titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(mode: .more)
  }
  func prepare(mode: Mode) {
    self.titleLabel.text = mode.text
  }
}
