import React, { Component } from 'react';
import { Table } from 'antd';

export default class Grid extends Component {
  constructor(props) {
    super(props);
    this.state = {
      data: []
    };
  }

  componentWillReceiveProps(props) {
    this.setState({
      data: props.data
    });
  }

  render() {
    return (
      <div>
        <Table
          columns={ this.props.columns }
          dataSource={ this.state.data.map(this.props.buildRow) }
        />
      </div>
    );
  }

}