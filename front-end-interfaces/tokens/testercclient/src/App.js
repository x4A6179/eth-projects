import React from 'react';
import './App.css';
import { useWeb3 } from '@openzeppelin/network/react';

function App() {
  const web3Context = useWeb3(`wss://rinkeby.infura.io/ws/v3/${infuraProjectId}`);
  const { networkId, networkName, providerName } = web3Context;

  return (
    <div className="App">
      <div>
      <h1>Infure React Dapp with Components.</h1>
      <Web3Data title="Web3 Data" web3Context={web3Context} />
      </div>
    </div>
  );
}

export default App;
