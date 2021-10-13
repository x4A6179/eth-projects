import React, { useState } from 'react';
//import styled from 'styled-components';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { ethers } from 'ethers';
import './fontawesome';
import './Quote.css';

const Quote = () => {

  const [quote, setQuote] = useState(quotes[Math.floor(Math.random() * quotes.length)]);

  const randomQuote = () => {
    return quotes[Math.floor(Math.random() * quotes.length)]
  }

  const genRandomQuote = () => {
    let newRandom = randomQuote();
    let prevQuote = quote;
    while (newRandom === prevQuote) {
      newRandom = randomQuote();
    }
    setQuote(newRandom);
  }

    return(
      <div id='quote-box'>
        <div className='quote-text'>
          <p id='text'>{quote.quote}</p>
        </div>
        <div className='quote-author'>
          <span id='author'>-{quote.author}</span>
        </div>
        <div className='buttons'>
          <button className='button' id='mint' onClick={callContract}>Mint</button>
          <button className='button' id='new-quote' onClick={() => genRandomQuote()}>New Quote</button>
          <a className='button' id='tweet-quote' target="_blank" href='twitter.com/intent/tweet'><FontAwesomeIcon icon='twitter'/>Tweet Quote</a>
        </div>
      </div>
    )
  }

  const quotes = [
    {author: "Test", quote: "This is a test"},
    {author: "Test2", quote: "This is another test"},
    {author: "test3", quote: "Test 3 coming in"},
    {author: "Test4", quote: "Here lies test 4"}
  ];


export default Quote;
