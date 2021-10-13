import React, { useState, useRef } from 'react';
import styled from 'styled-components';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { ethers } from 'ethers';
import './fontawesome';
import './Navbar.css'
import { useWeb3React } from '@web3-react/core';
import { injected } from './wallet/Connectors';


const Navbar = () => {
  const { active, account, library, activate, deactivate } = useWeb3React();

  async function connect() {
    try {
      await activate(injected)
    } catch (er) {
      console.log(er)
    }
  }

  /*
    async function disconnect() {
      try {
        deactivate()
      } catch (er) {
        console.log(er)
      }
    }
  */

  return (
    <div className='top-bar'>
      <div>
        {!active
          ? <div>
            <button className='connect-button' onClick={connect}>Connect To Metamask</button>
          </div>
          : <div>
        <span className='active-acct'>
          Connected: {account.toString().slice(0,6) + "..." + account.toString().slice(-4)}
        </span>
        </div>
        }
        <DropdownMenu />
      </div>
    </div>
  )
}

const DropdownMenu = () => {
  const [isActive, setIsActive] = useState(false);
  const dropdownRef = useRef(null);
  const onClick = () => setIsActive(!isActive);

  return (
    <div className='menu-container'>
      <button className='bar-item menu-button' onClick={onClick}><FontAwesomeIcon icon='bars' transform='grow-5' /></button>
      <nav ref={dropdownRef} className={`menu ${isActive ? 'active' : 'inactive'}`}>
        <ul>
          <li><a href='/'><FontAwesomeIcon icon='home' /> Home</a></li>
          <li><a href='/aboutus'>About the Team</a></li>
        </ul>
      </nav>
    </div>);
}


export default Navbar;
