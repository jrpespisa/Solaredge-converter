require "rails_helper"

describe Query do

  it { should belong_to :user}

  it { should have_valid(:start_date).when("2016-02-07") }
  it { should_not have_valid(:start_date).when(nil, "", "12-2-2016") }

  it { should have_valid(:end_date).when("2016-02-14") }
  it { should_not have_valid(:end_date).when(nil, "", "27-1-2016") }

  it { should have_valid(:kwh_rate).when(0.76) }
  it { should_not have_valid(:kwh_rate).when(nil, "", "String") }

  it { should have_valid(:kwh_credit).when(1.05) }
  it { should_not have_valid(:kwh_credit).when(nil, "", "String") }

  it { should have_valid(:sent_to_grid).when(23.2) }
  it { should_not have_valid(:sent_to_grid).when(nil, "", "String") }

  it { should have_valid(:distribution_charge).when(34.3) }
  it { should_not have_valid(:distribution_charge).when(nil, "", "String") }

end
