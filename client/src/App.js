import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';
import TradesDataTable from './components/TradesDataTable/TradesDataTable.js';
import './App.css';

export default class App extends Component {
  getTitle() {
    const endpoint = window.location.pathname;
    switch(endpoint) {
      case '/trades':
        return 'Trades';
      default:
        return '';
    }
  }

  render() {
    return (
      <div className='App'>
        <header className='App-header'>
          <h2 className='App-title'>{ this.getTitle() }</h2>
        </header>
        <div className='outerContainer'>
          <Switch>
            <Route path='/trades' component={ TradesDataTable } />
          </Switch>
        </div>
      </div>
    );
  }
}
