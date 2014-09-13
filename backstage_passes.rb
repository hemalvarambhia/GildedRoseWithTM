require './consumer_item.rb'
class BackstagePasses < ConsumerItem
  def update
    update_sell_by_date
    if (passed_sell_by_date?)
      @item.quality = 0 and return
    end

    increment_quality

    if (@item.sell_in < 11)
      increment_quality
    end
    if (@item.sell_in < 6)
      increment_quality
    end

  end

end