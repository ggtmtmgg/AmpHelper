require 'spec_helper'

describe AmpHelper do
  it 'has a version number' do
    expect(AmpHelper::VERSION).not_to be nil
  end

  describe 'amp_link_to' do
    before :all do
      @view = ActionView::Base.new
    end
  end
end
