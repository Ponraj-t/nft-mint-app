import Web3 from 'web3';

import { abi } from './MyNFT.json';

const contractAddress = '0x123...'; // Replace with contract address

async function mintNFT() {

const web3 = new Web3(window.ethereum);

await window.ethereum.enable(); // Request permission to connect to the Ethereum network

const contract = new web3.eth.Contract(abi, contractAddress);

const accounts = await web3.eth.getAccounts();

const account = accounts[0];

try {

  await contract.methods.mintNFT('https://example.com/nft-metadata.json').send({ from: account });
  
  const tokenId = await contract.methods.tokenOfOwnerByIndex(account, 0).call();
  
  const tokenURI = await contract.methods.tokenURI(tokenId).call();
  
  // Display the NFT image from the metadata using tokenURI
  
  console.log(tokenURI);
  
} catch (error) {

  // Handle error
  
  console.error(error);
  
}
}
