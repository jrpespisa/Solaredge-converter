require "rails_helper"

describe Credit do

  it { should belong_to :user}

  it { should have_valid(:tax_credit).when(0.76) }
  it { should_not have_valid(:tax_credit).when("String") }

  it { should have_valid(:srec_credit).when(1.05) }
  it { should_not have_valid(:srec_credit).when("String") }

end
