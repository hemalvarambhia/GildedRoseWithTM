require './item.rb'

class GildedRose

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality

    @items.each do |item|

      item_delegate = get_item_delegate_for item

      if item_delegate

      else
        update_quality_of(item)
      end
    end
  end

  def update_quality_of(item)
    if (item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert")
      increment_quality_of item
      if (item.name == "Backstage passes to a TAFKAL80ETC concert")
        if (item.sell_in < 11)
          increment_quality_of item
        end
        if (item.sell_in < 6)
          increment_quality_of item
        end
      end
    else
      degrade_quality_of item
    end

    update_sell_by_date_of item

    if (passed_sell_by_date?(item))
      if (item.name == "Aged Brie")
        increment_quality_of item
      elsif (item.name == "Backstage passes to a TAFKAL80ETC concert")
        item.quality = 0
      else
        degrade_quality_of item
      end
    end
  end

  def items
    @items.clone.freeze
  end

  private
  def get_item_delegate_for(item)
    nil
  end

  def passed_sell_by_date?(item)
    item.sell_in < 0
  end

  def update_sell_by_date_of(item)
    if (item.name != "Sulfuras, Hand of Ragnaros")
      item.sell_in = item.sell_in - 1;
    end
  end

  def degrade_quality_of(item)
    if (item.name != "Sulfuras, Hand of Ragnaros")
      if (item.quality > 0)
        item.quality = item.quality - 1
      end
    end
  end

  def increment_quality_of(item)
    if (item.quality < 50)
      item.quality = item.quality + 1
    end
  end
end