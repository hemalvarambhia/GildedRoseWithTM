require './consumer_item.rb'
class AgedBrie < ConsumerItem
  def update
    update_sell_by_date

    increment_quality
    if passed_sell_by_date?
      increment_quality
    end
  end
end