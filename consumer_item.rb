class ConsumerItem
  def initialize(rose, item)
    @item = item
    @rose = rose
  end

  def passed_sell_by_date?
    @item.sell_in < 0
  end

  def degrade_quality
    degrade_quality_of @item
  end

  def increment_quality
    increment_quality_of @item
  end

  def update_sell_by_date
    update_sell_by_date_of(@item)
  end

  def update_sell_by_date_of(item)
    item.sell_in = item.sell_in - 1;
  end

  def degrade_quality_of(item)
    if (item.quality > 0)
      item.quality = item.quality - 1
    end
  end

  def increment_quality_of(item)
    if (item.quality < 50)
      item.quality = item.quality + 1
    end
  end

  def update
    #noop
  end
end