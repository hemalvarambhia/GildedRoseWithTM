require './gilded_rose.rb'
require "rspec"

describe GildedRose do
  describe "Aged Brie" do
    before :each do
      @aged_brie = "Aged Brie"
    end

    it "should increase in quality" do
      subject.update_quality

      item_called(@aged_brie).quality.should == 1
    end

    describe "Quality Constraints" do
      it "should not go above 50" do
        51.times do
          subject.update_quality
        end

        item_called(@aged_brie).quality.should == 50
      end
    end

    describe "when it is pass its sell by date" do
      before :each do
        3.times do
          subject.update_quality
        end
      end

      it "increases in quality twice as fast" do
        lambda do
          subject.update_quality
        end.should change(item_called(@aged_brie), :quality).by(2)
      end
    end
  end

  describe "Sulfuras" do
    before :each do
      @sulfranas = "Sulfuras, Hand of Ragnaros"
    end

    it "is never sold" do
      subject.update_quality

      item_called(@sulfranas).sell_in.should == 0
    end

    it "should always have a quality of 80" do
      subject.update_quality

      item_called(@sulfranas).quality.should == 80
    end

    it "should not alter in quality" do
      lambda do
        subject.update_quality
      end.should_not change(item_called(@sulfranas), :quality)
    end
  end

  describe "Backstage passes to a TAFKAL80ETC concert" do
    before :each do
      @backstage_passes = "Backstage passes to a TAFKAL80ETC concert"
    end

    it "has no quality after the concert has finished" do
      16.times do
        subject.update_quality
      end

      item_called(@backstage_passes).quality.should == 0
    end

    describe "with more than 10 days remaining to sell" do
      it "increases in quality by 1" do
        lambda do
          subject.update_quality
        end.should change(item_called(@backstage_passes), :quality).by(1)
      end
    end

    describe "with fewer than 10 days remaining to sell" do
      before :each do
        5.times do
          subject.update_quality
        end
      end

      it "increases in quality by 2" do
        lambda do
          subject.update_quality
        end.should change(item_called(@backstage_passes), :quality).by(2)
      end
    end

    describe "with fewer than 3 days remaining to sell" do
      before :each do
        12.times do
          subject.update_quality
        end
      end

      it "increases in quality by 3" do
        lambda do
          subject.update_quality
        end.should change(item_called(@backstage_passes), :quality).by(3)
      end
    end
  end

  ["Elixir of the Mongoose", "+5 Dexterity Vest"].each do |name_of_item|
    describe name_of_item do
      before :each do
        @item = item_called name_of_item
      end

      describe "Before the sell by date" do
        it "reduces in quality by 1" do
          lambda do
            subject.update_quality
          end.should change(@item, :quality).by(-1)
        end

        it "decreases the sell by date" do
          lambda do
            subject.update_quality
          end.should change(@item, :sell_in).by(-1)
        end
      end

      describe "After the sell by date" do
        before :each do
          @item.sell_in.times do
            subject.update_quality
          end
        end

        it "degrades in quality twice as fast" do
          lambda do
            subject.update_quality
          end.should change(@item, :quality).by(-2)
        end
      end

      describe "Long after the sell by date" do
        before :each do
          (2 * @item.sell_in).times do
            subject.update_quality
          end
        end

        it "has a no quality" do
          @item.quality.should == 0
        end

        it "has an unchanging quality measure" do
          lambda do
            subject.update_quality
          end.should_not change(@item, :quality)
        end
      end
    end
  end
=begin
  describe "Conjured Manacake" do
    before :each do
      @conjured_manacake = "Conjured Mana Cake"
    end

    it "reduces in quality at twice the rate of normal items" do
      lambda {
        subject.update_quality
      }.should change(item_called(@conjured_manacake), :quality).by(-2)
    end

    describe "Long past its sell by date" do
      before :each do
        3.times do
          subject.update_quality
        end
      end

      it "does not change in quality" do
        lambda {
          subject.update_quality
        }.should_not change(item_called(@conjured_manacake), :quality)
      end
    end

  end
=end
  def item_called(name)
    subject.items.select{|item| item.name == name}.first
  end
end