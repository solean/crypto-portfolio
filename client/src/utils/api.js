import axios from 'axios'

export default class Api {
  _makeRequest(url, params={}, { method='GET', ...options }={}) {
    const reqOptions = {
      ...{ url, method, params },
      ...options
    };
    return new Promise((resolve, reject) => {
      axios(reqOptions)
        .then(res => { resolve(res.data) })
        .catch(reject);
    });
  }

  getTrades(pair) {
    const endpoint = pair ? `/trades/pair/${pair}` : '/trades';
    return this._makeRequest(endpoint);
  }
 
  getTotalTradeVolume() {
    return this._makeRequest('/volume');
  }

}
