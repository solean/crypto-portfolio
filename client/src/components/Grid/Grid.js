import React, { Component } from 'react';
import ReactTable from 'react-table';
import 'react-table/react-table.css';

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
        <ReactTable
          columns={ this.props.columns }
          data={ this.state.data.map(this.props.buildRow) }
          showPageSizeOptions={ false }
          showPageJump={ false }
          nextText='+'
          previousText='-'
        />
      </div>
    );
  }

}