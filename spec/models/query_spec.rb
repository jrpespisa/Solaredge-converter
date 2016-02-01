describe Query do

  it { should have_valid(:kwh_rate).when(0.76) }
  it { should_not have_valid(:kwh_rate).when(nil, "") }

  it { should have_valid(:kwh_credit).when(1.05) }
  it { should_not have_valid(:kwh_credit).when(nil, "") }

  it { should have_valid(:kwh_generated).when(3246.554) }
  it { should_not have_valid(:kwh_generated).when(nil, "") }

  it { should have_valid(:consumed).when(432.43) }
  it { should_not have_valid(:consumed).when(nil, "") }

  it { should have_valid(:sent_to_grid).when(23.2) }
  it { should_not have_valid(:sent_to_grid).when(nil, "") }

  it { should have_valid(:savings_consumed).when(32.22) }
  it { should_not have_valid(:savings_consumed).when(nil, "") }

  it { should have_valid(:credit_grid).when(34.3) }
  it { should_not have_valid(:credit_grid).when(nil, "") }

  it { should have_valid(:savings_before_distribution).when(34.5) }
  it { should_not have_valid(:savings_before_distribution).when(nil, "") }

  it { should have_valid(:distribution_charge).when(34.3) }
  it { should_not have_valid(:distribution_charge).when(nil, "") }

  it { should have_valid(:total_savings).when(431.5) }
  it { should_not have_valid(:total_savings).when(nil, "") }

end
