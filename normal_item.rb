require './consumer_item.rb'
class NormalItem < ConsumerItem
  def update
    degrade_quality

    update_sell_by_date

    if (passed_sell_by_date?)
      degrade_quality
    end
  end


end