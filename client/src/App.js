import React, { Component } from 'react';
import { Route, Switch } from 'react-router-dom';
import TradesDataTable from './components/TradesDataTable/TradesDataTable.js';
import './App.css';
import 'react-select/dist/react-select.css';

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
          <span className='App-title'>{ this.getTitle() }</span>
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
