require 'spec_helper'

describe Report do

  before(:each) do
    @reports1 = [@r1, @r2]
    @reports2 = [@r3, @r4]

    [@r1, @r2].each do |r|
      FactoryGirl.create(
        :report,
        :site => @site,
        :site_id => @site.object_id
      )
    end

    [@r3, @r4].each do |r|
      FactoryGirl.create(
        :report,
        :site => @site,
        :site_id => @site.object_id
      )
    end
  end

  context 'counting' do
    it "needs site_id before creating new report" do
      expect { Report.create }.to change(Report, :count).by(+0)
    end
  end

  context 'CRUD operations' do
    it "should insert 4 reports" do
      @reports2.insert(2, @r3, @r4)
      @reports2.count.should == 4

      @reports2.push(@r3, @r4)
      @reports2.count.should == 6
    end

    it "should delete added report" do
      precount = @reports1.count
      @reports1.delete_at(1)
      @reports1.count.should == precount - 1
    end

    it "should find report by id" do
      @r1 = Report.find(1)
      @r1.id.should eq(1)
    end

    it "should not insert invalid reports" do
      r = Report.new
      r.should be_valid

      @r5 = Report.create
      expect { @reports2 << @r5 }.to change(Report, :count).by(0)
    end
  end

  context 'scopes' do
    it "should ony return reports needing attention" do
      Report.needs_attention.where_values_hash.should ==
        { 'status' => 'needs_attention' }
    end

    it "should ony return completed reports" do
      Report.completed.where_values_hash.should ==
        { 'status' => 'completed' }
    end
  end

  describe 'file attachments' do
    before do
      Report.any_instance.stub(:save_attached_files).and_return(true) 
      Report.any_instance.stub(:destroy_attached_files).and_return(true) 
      @attachment = FactoryGirl.create :report
    end
    describe "#attachment" do
      it "returns correct url" do
        @attachment.attachment.url.should_not be_nil
      end
    end
  end
end
