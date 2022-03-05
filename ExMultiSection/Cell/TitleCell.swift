//
//  TitleCell.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import SnapKit
import Then

final class TitleCell: UITableViewCell {
  private let informationLabel = UILabel().then {
    $0.textColor = .systemGray
    $0.font = .systemFont(ofSize: 16)
    $0.textAlignment = .center
    $0.text = "< Description >"
  }
  private let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 18)
    $0.numberOfLines = 0
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    self.contentView.addSubview(self.informationLabel)
    self.contentView.addSubview(self.titleLabel)
    
    self.informationLabel.snp.makeConstraints {
      $0.top.left.right.equalToSuperview().inset(12)
    }
    self.titleLabel.snp.makeConstraints {
      $0.top.equalTo(self.informationLabel.snp.bottom).offset(12)
      $0.left.right.bottom.equalToSuperview()
    }
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    self.prepare(title: nil)
  }
  func prepare(title: String?) {
    self.titleLabel.text = title
  }
}
