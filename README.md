🚀 Foundry Journey

This repository documents my hands-on journey of learning Smart Contract Development, Testing, Deployment, and Security using Foundry.

Instead of simply following tutorials, the goal of this repository is to rebuild concepts from scratch, question architectural decisions, write tests independently, and understand how production-grade Solidity projects are structured.


⚙️ Smart Contract Development

Built a complete FundMe smart contract featuring:

ETH funding
Minimum USD contribution using Chainlink Price Feeds
Owner-restricted withdrawals
Custom Solidity errors
Immutable and constant variables
Storage optimization
Mapping of funders
Array of contributors

🌐 Working with External Contracts

Learned how to interact with external protocols using:

Chainlink AggregatorV3Interface
Live ETH/USD Price Feed
Network-dependent configurations
🔧 Deployment

Successfully deployed contracts using:

Forge deployment commands
Solidity deployment scripts
Local Anvil blockchain
Sepolia Testnet

Learned how deployment differs across local and public networks.

🌍 Fork Testing

Learned how to test contracts against a real blockchain state by forking Sepolia.

Compared:

Local mock testing
Fork testing
Real Chainlink price feeds

and understood the advantages and trade-offs of each approach.

🎯 Mock Contracts

Implemented local testing using:

MockV3Aggregator

This allowed deterministic testing without relying on live oracle data.

⚙️ Network Configuration

Implemented a reusable HelperConfig pattern to automatically switch between:

Local Anvil configuration
Sepolia configuration

using the current chain ID.

📊 Test Coverage

Generated coverage reports using:

forge coverage

Achieved approximately:

92% Line Coverage
96% Statement Coverage
80% Branch Coverage
83% Function Coverage

for the main FundMe contract.