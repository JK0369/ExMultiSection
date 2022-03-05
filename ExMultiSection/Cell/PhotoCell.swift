//
//  PhotoCell.swift
//  ExMultiSection
//
//  Created by Jake.K on 2022/03/04.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class PhotoCell: UITableViewCell {
  private let photoImageView = UIImageView().then {
    $0.layer.masksToBounds = true
  }
  
  private var heightConstraint: Constraint?
  var cellHeight = nil as CGFloat? {
    didSet {
      self.heightConstraint?.update(offset: self.cellHeight ?? 0)
      self.layoutIfNeeded()
    }
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(self.photoImageView)
    self.photoImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      self.heightConstraint = $0.height.equalTo(0).priority(999).constraint
    }
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(urlString: nil)
    self.cellHeight = nil
  }
  func prepare(urlString: String?) {
    self.photoImageView.kf.cancelDownloadTask()
    self.photoImageView.image = nil
    guard let urlString = urlString else { return }
    
    self.photoImageView.kf.setImage(
      with: URL(string: urlString),
      placeholder: UIImage(named: "placeholder"),
      options: [
        .processor(DownsamplingImageProcessor(size: CGSize(width: 300, height: 500))),
        .progressiveJPEG(ImageProgressive(isBlur: false, isFastestScan: true, scanInterval: 0.1)),
        .transition(.fade(0.3))
      ],
      completionHandler: { [weak self] result in
        switch result {
        case .success(let response):
          self?.cellHeight = response.image.size.height
        case .failure:
          break
        }
      }
    )
  }
}
