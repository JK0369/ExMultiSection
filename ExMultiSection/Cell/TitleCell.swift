//
//  TitleCell.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import SnapKit
import Then

final class TitleCell: UITableViewCell {
  private let titleLabel = UILabel().then {
    $0.textColor = .black
    $0.font = .systemFont(ofSize: 24)
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
    self.prepare(title: nil)
  }
  func prepare(title: String?) {
    self.titleLabel.text = title
  }
}
