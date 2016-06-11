import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';

var renderQueries = function() {
  ReactDOM.render(
    <Queries url="api/v1/queries"/>,
    document.getElementById("queryList")
  )
}

var Queries = React.createClass({
  loadQueries: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data})
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    })
  },
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    this.loadQueries();
  },
  render: function() {
    return (
      <div>
        <h2>Monthly Records</h2>
      </div>
    )
  }
});

renderQueries();
