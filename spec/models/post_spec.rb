require 'spec_helper'

describe Post do
  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :link }
  end
end
