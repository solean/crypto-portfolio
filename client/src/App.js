import React, { Component } from 'react';
import './App.css';
import Api from './api.js';

const api = new Api();

class App extends Component {
  async componentDidMount() {
    const trades = await api.getTrades('NEOBTC');
    console.log(trades);
    const vol = await api.getTotalTradeVolume();
    console.log(vol);
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">Trades</h1>
        </header>
        
      </div>
    );
  }
}

export default App;
