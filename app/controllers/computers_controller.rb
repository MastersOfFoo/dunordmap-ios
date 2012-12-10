class ComputersController < UIViewController
  attr_accessor :table_view, :rooms

  def viewDidLoad
    super
    self.rooms = []
    self.view.addSubview(table_view)
    self.title = "Computer Rooms"
    load_rooms
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

    room = self.rooms[indexPath.row]
    cell.textLabel.text = "#{room.name}: #{room.available}"
    cell.textLabel.textColor = "#7F7F7F".to_color
    cell.textLabel.font = UIFont.fontWithName("Helvetica-Bold", size: 14)
    cell.contentView.backgroundColor = "#F4F5F6".to_color
    cell
  end

  def tableView(tableView, numberOfRowsInSection: section)
    self.rooms.size
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  end

  private

  def load_rooms
    self.rooms.clear
    ComputerRoom.all do |rooms|
      rooms.each do |room|
        self.rooms << room
      end
      table_view.reloadData
    end
  end
end
