//
//  IndividualValueCell.swift
//  CompetitiveDex
//
//  Created by Thai Do on 5/3/20.
//  Copyright © 2020 Thai Do. All rights reserved.
//

import UIKit

class ValueCell: UITableViewCell {
  static let reuseIdentifier = "ValueCell"
  
  var delegate: UITextFieldDelegate?
  
  let inputField: UITextField = {
    let field = UITextField()
    field.backgroundColor = .systemBackground
    field.keyboardType = .numberPad
    field.borderStyle = .roundedRect
    field.textColor = .label
    field.layer.borderColor = UIColor.label.cgColor
    field.layer.borderWidth = 1
    field.translatesAutoresizingMaskIntoConstraints = false
    return field
  }()
  
   // MARK: - Initializers
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public func configure(withDelegate delegate: UITextFieldDelegate, value: String) {
    self.delegate = delegate
    inputField.placeholder = value
  }
  
  private func setupViews() {
    self.selectionStyle = .none
    self.backgroundColor = .systemBackground
    contentView.addSubview(inputField)
    setupConstraints()
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      inputField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      inputField.widthAnchor.constraint(equalToConstant: 48),
      inputField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
      inputField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
    ])
  }
  
}
