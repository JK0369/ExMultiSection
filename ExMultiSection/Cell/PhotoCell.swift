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
    $0.contentMode = .scaleAspectFill
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.contentView.addSubview(self.photoImageView)
    self.photoImageView.snp.makeConstraints {
      $0.size.equalTo(50)
    }
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.prepare(urlString: nil)
  }
  func prepare(urlString: String?) {
    guard let urlString = urlString else {
      self.photoImageView.image = nil
      return
    }
    self.photoImageView.kf.setImage(
      with: URL(string: urlString),
      placeholder: UIImage(named: "placeholder"),
      options: [
        .processor(DownsamplingImageProcessor(size: CGSize(width: 50, height: 50))),
        .progressiveJPEG(ImageProgressive(isBlur: false, isFastestScan: true, scanInterval: 0.1))
      ],
      completionHandler: { result in
        print(result)
      }
    )
  }
}
