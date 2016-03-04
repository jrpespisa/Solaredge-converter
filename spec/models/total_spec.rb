require "rails_helper"

describe Total do

  it { should belong_to :user}

  it { should have_valid(:kwh_generated).when(435.01) }
  it { should_not have_valid(:kwh_generated).when(nil, "", "String") }

  it { should have_valid(:kwh_consumed).when(321.71) }
  it { should_not have_valid(:kwh_consumed).when(nil, "", "String") }

  it { should have_valid(:savings_consumed).when(0.76) }
  it { should_not have_valid(:savings_consumed).when(nil, "", "String") }

  it { should have_valid(:sent_to_grid).when(1.05) }
  it { should_not have_valid(:sent_to_grid).when(nil, "", "String") }

  it { should have_valid(:credit_grid).when(23.2) }
  it { should_not have_valid(:credit_grid).when(nil, "", "String") }

  it { should have_valid(:savings_before_distribution).when(34.3) }
  it { should_not have_valid(:savings_before_distribution).when(nil, "", "String") }

  it { should have_valid(:distribution_charge).when(34.3) }
  it { should_not have_valid(:distribution_charge).when(nil, "", "String") }

  it { should have_valid(:total_savings).when(34.3) }
  it { should_not have_valid(:total_savings).when(nil, "", "String") }

end
