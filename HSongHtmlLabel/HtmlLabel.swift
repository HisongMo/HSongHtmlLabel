//
//  HtmlLabel.swift
//  YaoYaoDemo
//
//  Created by Wanglei on 2024/4/17.
//

import UIKit
import DTCoreText
///
public class HTMLLabel: UIView, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate {
    
    //MARK: - 声明区
    //-----UI-----
    var htmlLabel = DTAttributedLabel()
    var normalLabel = UILabel()
    //-----Block-----
    
    //-----Data-----
    /* 外部参数(从外部传入的数据) */
    private var htmlText = String()
    private var normalText = String()
    var numberOfLines = Int() {
        didSet {
            self.normalLabel.numberOfLines = self.numberOfLines
        }
    }
    /* 内部参数(从接口获取的数据以及其他内部数据) */
    // 必须先设置text，才能自动计算出height
    private(set) var thisHeight = CGFloat()
    private var thisWidth = CGFloat()
    
    //MARK: - 逻辑区
    func setUI() {
        self.addSubview(htmlLabel)
        self.addSubview(normalLabel)
        // 对于 htmlLabel
        htmlLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            htmlLabel.topAnchor.constraint(equalTo: self.topAnchor),
            htmlLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            htmlLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            htmlLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        htmlLabel.delegate = self

        // 对于 normalLabel
        normalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            normalLabel.topAnchor.constraint(equalTo: self.topAnchor),
            normalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            normalLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            normalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        htmlLabel.backgroundColor = .clear
        normalLabel.backgroundColor = .clear
    }
    
    func setHtmlText(htmlText: String, labelWidth: CGFloat = UIConfigure.Width - UIConfigure.SizeScale * 120 - UIConfigure.SizeScale * 24) {
    
        self.htmlLabel.isHidden = false
        self.normalLabel.isHidden = true
        self.htmlText = htmlText
        self.thisWidth = labelWidth
        self.htmlLabel.attributedString = HtmlLabelTools.getAttributedString(withHtml: htmlText)
        self.thisHeight = HtmlLabelTools.getAttributedTextHeightHtml(htmlText, with_viewMaxRect: HtmlLabelTools.getAuxRect(withWidth: labelWidth))
        print(self.thisHeight)
    }
    
    func setNormalText(normalText: String, labelWidth: CGFloat = UIConfigure.Width - UIConfigure.SizeScale * 120 - UIConfigure.SizeScale * 24, font: UIFont, lineSpacing: CGFloat = 0) {
        self.htmlLabel.isHidden = true
        self.normalLabel.isHidden = false
        self.normalText = normalText
        self.thisWidth = labelWidth
        self.normalLabel.font = font
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        let attributedText = NSAttributedString(string: normalText, attributes: attributes)
        normalLabel.attributedText = attributedText
//        self.thisHeight = normalText.attrHeight(withFont: font, andWidth: labelWidth)
        self.thisHeight = normalText.getHeight(withWidth: labelWidth, font: font, lineSpacing: lineSpacing)
    }
    
    // DTAttributedTextContentViewDelegate
    public func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment is DTImageTextAttachment {
            let imageURL = attachment.contentURL.absoluteString
            let imageView = DTLazyImageView(frame: frame)
            imageView.delegate = self
            imageView.contentMode = .scaleAspectFit
            imageView.image = (attachment as! DTImageTextAttachment).image
            imageView.url = attachment.contentURL
            
            if imageURL.contains("gif") {
                DispatchQueue.global(qos: .default).async {
                    let gifData = try? Data(contentsOf: attachment.contentURL)
                    DispatchQueue.main.async {
                        imageView.image = DTAnimatedGIFFromData(gifData)
                    }
                }
            }
            return imageView
        }
        return nil
    }
    //根据a标签，自定义响应按钮，处理点击事件
//    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewForLink url: URL!, identifier: String!, frame: CGRect) -> UIView! {
//        let button = ZSDTCoreTextButton.getButtonWithURL(url.absoluteString, withIdentifier: identifier, frame: frame)
//        button.backgroundColor = UIColor.purple
//        button.alpha = 0.5
//        return button
//    }
    
    // DTLazyImageViewDelegate

    
    //MARK: - 跳转区
    
    //MARK: - 生命区
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension String {
    func getHeight(withWidth width: CGFloat, font: UIFont, lineSpacing: CGFloat) -> CGFloat {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle
        ]
        
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let rect = self.boundingRect(with: size, options: options, attributes: attributes, context: nil)
        
        return ceil(rect.height)
    }
}
