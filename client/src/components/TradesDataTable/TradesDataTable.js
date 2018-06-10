import React, { Component } from 'react';
import { Select } from 'antd';
import moment from 'moment';
import Grid from '../Grid/Grid.js';
import Api from '../../utils/api.js';
import './TradesDataTable.css';

const api = new Api();
const Option = Select.Option;
const TRADE_COLUMNS = [{
  title: 'Pair',
  dataIndex: 'pair',
  key: 'pair'
}, {
  title: 'Date',
  dataIndex: 'date',
  key: 'date'
}, {
  title: 'Exchange',
  dataIndex: 'exchange',
  key: 'exchange'
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


export default class TradesDataTable extends Component {
  constructor(props) {
    super(props);

    this.state = {
      pairs: [],
      trades: [],
      volume: {}
    }

    this.buidPairOption = this.buildPairOption.bind(this);
    this.buidTradeRow = this.buildTradeRow.bind(this);
    this.handlePairChange = this.handlePairChange.bind(this);
    this.buildVolumeInfo = this.buildVolumeInfo.bind(this);
  }

  async componentDidMount() {
    const [trades, volume] = await Promise.all([
      api.getTrades(),
      api.getVolume()
    ]);

    let pairs = trades.map(t => t.pair);
    pairs = Array.from(new Set(pairs));


    this.setState({
      pairs,
      trades,
      volume
    });
  }

  buildPairOption(pair) {
    return <Option value={ pair } key={ arguments[1] }>{ pair }</Option>;
  }

  async handlePairChange(pair) {
    const [trades, volume] = await Promise.all([
      api.getTrades(pair),
      api.getVolume(pair)
    ]);

    this.setState({
      trades,
      volume
    });
  }

  buildTradeRow(trade, i) {
    // This will break if I start trading in DOGE pairs :)
    const baseCoin = trade.pair.slice(-3);
    const mainCoin = trade.pair.slice(0, -3);

    return {
      key: i,
      pair: mainCoin + '/' + baseCoin,
      date: moment(trade.date).format('LLL'),
      exchange: trade.exchange,
      type: trade.buy_or_sell,
      price: trade.price + ' ' + baseCoin,
      amount: trade.amount + ' ' + mainCoin,
      total: trade.total + ' ' + baseCoin,
      fee: trade.fee + ' ' + trade.fee_coin
    };
  }

  buildVolumeInfo() {
    return (
      <div>
        <h3>Trade Volume</h3>
        <div>
          {
            Object.keys(this.state.volume).map((baseCoin, i) => {
              return <div key={ i }>{ baseCoin }: { this.state.volume[baseCoin] }</div>
            })
          }
        </div>
      </div>
    );
  }

  render() {
    return (
      <div className='tradesDataTableContainer'>
        <div className='tradesFilterContainer'>
          <Select onChange={ this.handlePairChange }
                  placeholder='Trading Pair'
                  allowClear={ true }
                  style={{ width: 200 }}>
            { this.state.pairs.map(this.buildPairOption)  }
          </Select>
        </div>
        <div className='tradesInfoContainer'>
          { this.buildVolumeInfo() }
        </div>
        <div className='tradesGridContainer'>
          <Grid
            columns={ TRADE_COLUMNS }
            data={ this.state.trades }
            buildRow={ this.buildTradeRow }
          />
        </div>
      </div>
    );
  }
}