class MenusController < UIViewController
  attr_accessor :table_view, :venue

  def viewDidLoad
    super
    self.view.addSubview(table_view)
    self.title = "#{venue.name}"
  end

  def table_view
    @table_view ||= begin
      table_view = UITableView.alloc.initWithFrame(self.view.bounds, style:UITableViewStyleGrouped)
      table_view.dataSource = table_view.delegate = self
      table_view.backgroundView = nil
      table_view.backgroundColor = "#EEEDE4".to_color
      table_view.separatorColor = "#9C9C9C".to_color
      table_view
    end
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    @reuseIdentifier ||= "CELL_IDENTIFIER"

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) || begin
      UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    end

    cell.textLabel.text = self.venue.menus[indexPath.row]["name"]
    cell.textLabel.textColor = "#7F7F7F".to_color
    cell.textLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 14)
    cell.contentView.backgroundColor = "#F4F5F6".to_color
    cell.accessoryView = UIImageView.alloc.initWithImage(UIImage.imageNamed("arrow.png"))
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    self.venue.menus.size
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    open_menu_details(self.venue.menus[indexPath.row])
  end

  private

  def open_menu_details(menu)
    details_controller = MenuDetailsController.alloc.initWithNibName(nil, bundle: nil)
    details_controller.image_url = menu["image"]
    details_controller.name = menu["name"]
    self.navigationController.pushViewController(details_controller, animated: true)
  end
end
