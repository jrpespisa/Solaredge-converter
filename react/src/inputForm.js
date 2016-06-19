import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import Button from 'react-bootstrap/lib/Button';
import FormGroup from 'react-bootstrap/lib/FormGroup';
import ControlLabel from 'react-bootstrap/lib/ControlLabel';
import FormControl from 'react-bootstrap/lib/FormControl';
import Input from 'react-bootstrap/lib/Input';

//Helper method for rendering the Query list and forms
var renderQueries = function() {
  ReactDOM.render(
    <Queries url="api/v1/queries"/>,
    document.getElementById("queryList")
  )
};

// Credits


// Defines the GET request for Queries and displays all Query records for user.
var Queries = React.createClass({
  loadQueries: function() {
    // Ajax call - GET to '/api/v1/queries'
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data})
        this.reloadSavingsCounter();
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    })
  },
  loadCredits: function() {
    $.ajax({
      url: "api/v1/credits",
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({credits: data})
        this.reloadSavingsCounter();
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    })
  },
  // Initialize empty data array as state.
  getInitialState: function() {
    return {
      data: [],
      credits: [],
      credit_type: '',
      tax_credit: '',
      srec_credit: '',
      start_date: '',
      end_date: '',
      kwh_rate: '',
      kwh_credit: '',
      sent_to_grid: '',
      distribution_charge: '',
      savings: this.reloadSavingsCounter()
    };
  },
  // Calls 'loadQueries' once on initial page load.
  componentDidMount: function() {
    this.loadQueries();
    this.loadCredits();
  },
  reloadSavingsCounter: function() {
    var savings = 0
    $(".savings-total").each(function() {
      savings += parseFloat($(this).val());
    });
    this.setState({savings: savings})
  },
  handleCreditTypeChange: function(event) {
    this.setState({credit_type: event.target.value})
  },
  handleCreditInputChange: function(event) {
    if (this.state.credit_type == "Tax Credit") {
      this.setState({tax_credit: event.target.value})
      this.setState({srec_credit: "---"})
    } else if (this.state.credit_type == "Srec Credit") {
      this.setState({srec_credit: event.target.value})
      this.setState({tax_credit: "---"})
    };
  },
  handleStartDateChange: function(event) {
    this.setState({start_date: event.target.value})
  },
  handleEndDateChange: function(event) {
    this.setState({end_date: event.target.value})
  },
  handleKwhRateChange: function(event) {
    this.setState({kwh_rate: event.target.value})
  },
  handleKwhCreditChange: function(event) {
    this.setState({kwh_credit: event.target.value})
  },
  handleSentToGridChange: function(event) {
    this.setState({sent_to_grid: event.target.value})
  },
  handleDistributionChargeChange: function(event) {
    this.setState({distribution_charge: event.target.value})
  },
  handleCreditSubmit: function(event) {
    event.preventDefault();
    $.ajax({
      type: "POST",
      url: "api/v1/credits",
      dataType: 'json',
      cache: false,
      data: {
        credit: {
          tax_credit: this.state.tax_credit,
          srec_credit: this.state.srec_credit,
        }
      },
      success: function(data) {
        console.log(data);
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
    this.loadCredits();
    this.setState({credits: []});
  },
  handleQuerySubmit: function(event) {
    event.preventDefault();
    $.ajax({
      type: "POST",
      url: "api/v1/queries",
      dataType: 'json',
      cache: false,
      data: {
        query: {
          start_date: this.state.start_date,
          end_date: this.state.end_date,
          kwh_rate: this.state.kwh_rate,
          kwh_credit: this.state.kwh_credit,
          sent_to_grid: this.state.sent_to_grid,
          distribution_charge: this.state.distribution_charge
        }
      },
      success: function(data) {
        console.log(data);
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
    this.loadQueries();
    this.setState({data: []});
  },
  // Renders Query list
  render: function() {
    // Queries data iterator. Sets props to be passed down to individual Query.
    var loadQueries = this.loadQueries
    var loadCredits = this.loadCredits
    var savings = this.state.savings
    var creditProps = this.state.credits.map(function(credit) {
      return (
        <Credit
          key = {credit.id}
          id = {credit.id}
          taxCredit = {credit.tax_credit}
          srecCredit = {credit.srec_credit}
          reloadUi = {loadCredits}
        />
      )
    });
    var queryProps = this.state.data.map(function(query) {
      return (
        <Query
          key = {query.id}
          id = {query.id}
          startDate = {query.start_date}
          endDate = {query.end_date}
          kwhRate = {query.kwh_rate}
          kwhCredit = {query.kwh_credit}
          kwhGenerated = {query.kwh_generated}
          consumed = {query.consumed}
          sentToGrid = {query.sent_to_grid}
          savingsConsumed = {query.savings_consumed}
          creditGrid = {query.credit_grid}
          savingsBeforeDistribution = {query.savings_before_distribution}
          distributionCharge = {query.distribution_charge}
          totalSavings = {query.total_savings}
          reloadUi = {loadQueries}
          grandTotal = {savings}
        />
      )
    })
    return (
      <div>
        <h1>Credit Input</h1>
        <form>
          <FormGroup>
            <label for ="credittype">Credit Type</label>
            <Input type="select" defaultValue="select" onChange={this.handleCreditTypeChange}>
              <option>Please Select</option>
              <option>Tax Credit</option>
              <option>Srec Credit</option>
            </Input>
          </FormGroup>
          <FormGroup>
            <label for ="creditval">Credit Value</label>
            <Input
              type='text'
              value={this.state.amount}
              onChange={this.handleCreditInputChange}
              />
          </FormGroup>
          <Button className="btn-primary" type="submit" onClick={this.handleCreditSubmit}>
            Save
          </Button>
        </form>
        <h1>Query Input</h1>
        <form>
          <FormGroup>
            <label for="sdate">Start Date</label>
            <Input
              type='text'
              placeholder="yyyy-mm-dd"
              value={this.state.start_date}
              onChange={this.handleStartDateChange}
              />
          </FormGroup>
          <FormGroup>
            <label for="edate">End Date</label>
            <Input
              type='text'
              placeholder="yyyy-mm-dd"
              value={this.state.end_date}
              onChange={this.handleEndDateChange}
              />
          </FormGroup>
          <FormGroup>
            <label for ="kwhrate">kWh Rate</label>
            <Input
              type='text'
              value={this.state.kwh_rate}
              onChange={this.handleKwhRateChange}
              />
          </FormGroup>
          <FormGroup>
            <label for ="kwhcred">kWh Credit</label>
            <Input
              type='text'
              value={this.state.kwh_credit}
              onChange={this.handleKwhCreditChange}
              />
          </FormGroup>
          <FormGroup>
            <label for ="senttogrid">Sent to Grid</label>
            <Input
              type='text'
              value={this.state.sent_to_grid}
              onChange={this.handleSentToGridChange}
              />
          </FormGroup>
          <FormGroup>
            <label for ="distcharge">Distribution Charge</label>
            <Input
              type='text'
              value={this.state.distribution_charge}
              onChange={this.handleDistributionChargeChange}
              />
          </FormGroup>
          <Button className="btn-primary" type="submit" onClick={this.handleQuerySubmit}>
            Save
          </Button>
        </form>
        <h2>Total Monthly Savings</h2>
        <h3>{this.state.savings}</h3>
        <h2>Credits</h2>
        <table className="table table-striped">
          <th>Tax Credit</th>
          <th>Srec Credit</th>
          <th>Delete</th>
          <tbody>
            {creditProps}
          </tbody>
        </table>
        <h2>Monthly Records</h2>
        <table className="table table-striped">
          <th>Start Date</th>
          <th>End Date</th>
          <th>kWh Generated</th>
          <th>kWh Consumed</th>
          <th>Savings Consumed</th>
          <th>Sent to Grid</th>
          <th>Credit Grid</th>
          <th>Savings Before Distribution</th>
          <th>Distribution Charge</th>
          <th>Total Savings</th>
          <th>Delete</th>
          <tbody>
            {queryProps}
          </tbody>
        </table>
      </div>
    )
  }
});

var Credit = React.createClass({
  handleDelete: function(event) {
    event.preventDefault();
    $.ajax({
      method: 'DELETE',
      url: "/api/v1/credits/" + this.props.id,
      dataType: 'json',
      cache: false,
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
    this.props.reloadUi();
  },
  render: function() {
    return (
      <tr>
        <td>{this.props.taxCredit}</td>
        <td>{this.props.srecCredit}</td>
        <td><Button className="btn-primary" type="submit" onClick={this.handleDelete}>
          Delete
        </Button></td>
      </tr>
    )
  }
});

var Query = React.createClass({
  handleDelete: function(event) {
    event.preventDefault();
    $.ajax({
      method: 'DELETE',
      url: "/api/v1/queries/" + this.props.id,
      dataType: 'json',
      cache: false,
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
    this.props.reloadUi();
  },
  render: function() {
    return (
      <tr>
        <td>{this.props.startDate}</td>
        <td>{this.props.endDate}</td>
        <td>{this.props.kwhGenerated}</td>
        <td>{this.props.consumed}</td>
        <td>{this.props.savingsConsumed}</td>
        <td>{this.props.sentToGrid}</td>
        <td>{this.props.creditGrid}</td>
        <td>{this.props.savingsBeforeDistribution}</td>
        <td>{this.props.distributionCharge}</td>
        <td className="savings-total" value={this.props.totalSavings}>{this.props.totalSavings}</td>
        <td><Button className="btn-primary" type="submit" onClick={this.handleDelete}>
          Delete
        </Button></td>
      </tr>
    )
  }
});

renderQueries();
