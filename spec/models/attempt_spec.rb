require 'spec_helper'

describe Attempt do
  context "Fields" do
    it { should have_field(:increase_count).of_type(Integer)}
    it { should have_field(:solved).of_type(Boolean)}
    it { should have_field(:cookies).of_type(Integer)}
  end

  context "Validations" do
    it { should validate_numericality_of(:increase_count).to_allow(:only_integer => true)}
    it { should validate_numericality_of(:cookies).to_allow(:only_integer => true)}
  end

  context "Associations" do
    it { should belong_to(:user)}
    it { should belong_to(:question)}
  end
end
