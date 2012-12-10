class BuildingDetailsController < UIViewController
  attr_accessor :building, :image, :image_view, :description_view

  def viewDidLoad
    super
    self.image_view = UIImageView.alloc.initWithFrame(CGRectMake(10, 25, 300, 200))
    self.image_view.backgroundColor = "#EEEDE4".to_color
    self.image_view.layer.setBorderColor("#B0B0B0".to_color.CGColor)
    self.image_view.layer.setBorderWidth(2.0)
    self.image_view.layer.mask = custom_mask_layer
    load_image

    self.description_view = UITextView.alloc.initWithFrame(CGRectMake(10, 223, 300, 200))
    self.description_view.setEditable(false)
    self.description_view.font = UIFont.fontWithName("TimesNewRomanPSMT", size:12)
    self.description_view.setTextColor("#636363".to_color)
    self.description_view.contentInset = UIEdgeInsetsMake(10.0, 25.0, 0.0, 25.0)
    self.description_view.layer.setBorderColor("#B0B0B0".to_color.CGColor)
    self.description_view.layer.setBorderWidth(2.0)
    load_info
    

    self.view.backgroundColor = "#EEEDE4".to_color
    self.title = self.building.name
  end

  def load_info
    self.description_view.text = self.building.history
    self.view.addSubview(self.description_view)
  end

  def load_image
    unless self.image
      self.image_view.image = nil
      image_data = NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(self.building.image))
      if image_data
        self.image = UIImage.alloc.initWithData(image_data)
        self.image_view.image = self.image
        self.view.addSubview(self.image_view)
      else
        UIAlertView.alloc.initWithTitle("Error", message:"Error loading image",
          delegate: nil, cancelButtonTitle: "ok", otherButtonTitles: nil).show
      end
    else
      self.image_view.image = self.image
    end
  end

  def custom_mask_layer
    maskPath = UIBezierPath.bezierPathWithRoundedRect(self.image_view.bounds, 
      byRoundingCorners: (UIRectCornerTopLeft | UIRectCornerTopRight), cornerRadii: CGSizeMake(5.0, 5.0))
    maskLayer = CAShapeLayer.alloc.init
    maskLayer.frame = self.image_view.bounds
    maskLayer.path = maskPath.CGPath
    maskLayer
  end
end
