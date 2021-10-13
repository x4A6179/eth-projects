import './App.css';
import Quote from './components/Quote';
import Navbar from './components/Navbar';
import { Web3ReactProvider } from '@web3-react/core';
const ethers = require('ethers');

function getLibrary(provider, connector) {
  return new ethers.providers.Web3Provider(provider)
}

function App() {
  return (
    <Web3ReactProvider getLibrary={getLibrary}>
      <div className="App">
        <div>
          <header className="App-header">
            <Navbar />
          </header>
        </div>
        <div className='quote-container'>
          <body>
            <Quote />
          </body>
        </div>
      </div>
    </Web3ReactProvider>
  );
}

export default App;
