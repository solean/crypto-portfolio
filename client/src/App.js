import React, { Component } from 'react';
import './App.css';
import Api from './api.js';
import { Select, Table } from 'antd';

const Option = Select.Option;
const api = new Api();

const TRADE_COLUMNS = [{
  title: 'Date',
  dataIndex: 'date',
  key: 'date'
}, {
  title: 'Buy/Sell',
  dataIndex: 'type',
  key: 'type'
}, {
  title: 'Price',
  dataIndex: 'price',
  key: 'price'
}, {
  title: 'Amount',
  dataIndex: 'amount',
  key: 'amount'
}, {
  title: 'Total',
  dataIndex: 'total',
  key: 'total'
}, {
  title: 'Fee',
  dataIndex: 'fee',
  key: 'fee'
}];

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pairs: [],
      trades: []
    };
    this.buidPairOption = this.buildPairOption.bind(this);
    this.buidTradeRow = this.buildTradeRow.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  async componentDidMount() {
    const trades = await api.getTrades();
    const pairs = await api.getPairs();
    this.setState({
      pairs,
      trades
    });
  }

  buildPairOption(pair) {
    return (
      <Option value={ pair } key={ arguments[1] }>{ pair }</Option>
    );
  }

  buildTradeRow(trade, i) {
    return {
      key: i,
      date: trade[0],
      type: trade[2],
      price: trade[3],
      amount: trade[4],
      total: trade[5],
      fee: trade[6]
    };
  }

  async handleChange(item) {
    const trades = await api.getTrades(item);
    console.log(trades);
    this.setState({ trades });
  }

  render() {
    return (
      <div className='App'>
        <header className='App-header'>
          <Select onChange={ this.handleChange }
                  placeholder='Trading Pair'
                  allowClear={ true }
                  style={{ width: 200 }}>
            { this.state.pairs.map(this.buildPairOption)  }
          </Select>
        </header>
        <Table
          columns={ TRADE_COLUMNS }
          dataSource={ this.state.trades.map(this.buildTradeRow) } />
      </div>
    );
  }
}

