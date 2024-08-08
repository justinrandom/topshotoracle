# TopShot Badges and Tiers

This project is designed to help find the tier and badges of NBA Top Shot moments on-chain.

## Tiers Status

Under review/testing. Will deploy to mainnet soon.
[Reference](./TIERS.md)

## Badges Status

The following are implemented:

- Rookie Mint
- Rookie of the Year
- MVP Year
- Rookie Year
- Championship Year

The following are in-progress:

- Rookie Premiere
- Top Shot Debut
- Challenge Reward
- Crafting Challenge Reward
- Leaderboard Reward

## Setup on Emulator

1. Deploy TopShotLocking, TopShot, TopShotTiers, TopShotBadges
   flow-c1 project deploy

2. create_set (string)
   flow-c1 transactions send ./topshot/transactions/create_set.cdc "First Set!"

3. create_plays (metadata found inside transaction)
   flow-c1 transactions send ./topshot/transactions/create_plays.cdc

4. mint_moment
   flow-c1 transactions send ./topshot/transactions/mint_moment.cdc

5. getTier (setId, playId)
   flow scripts execute ./tiers/scripts/getTier.cdc 2 11

6. getAllBadges (account)
   flow scripts execute ./badges/scripts/getAllBadges.cdc 0xf8d6e0586b0a20c7

7. flow accounts create

8. flow transactions send .\topshot\transactions\setupCollection.cdc --signer=justin

9. flow transactions send .\topshot\transactions\sendMoments.cdc 0x01cf0e2f2f715450 [1,2,3,4,5]

10. setupVault

11. mintTSHOT

## Tiers Admin Commands

flow transactions send ./tiers/transactions/addOrUpdateDefaultTier.cdc
flow transactions send ./tiers/transactions/addOrUpdateMixedTierSet.cdc
flow transactions send ./tiers/transactions/removePlayIDFromMixedTierSet.cdc

## Useful Repos

They are actively updating the content for C1. You can dig through some of the branches for the latest C1 code (e.g., [NBA-2865-upgrade-flow-sdk branch](https://github.com/dapperlabs/nba-smart-contracts/tree/judez/NBA-2865-upgrade-flow-sdk/transactions/admin)).

- [Dapper Labs NBA Smart Contracts](https://github.com/dapperlabs/nba-smart-contracts)
- [TopShot Explorer by rrrkren](https://github.com/rrrkren/topshot-explorer)

## Other Useful Resources

- **Recent Deployments**:

  - Dapper team's most recent deployment to Previewnet for C1: [Previewnet Deployment](https://previewnet.flowdiver.io/account/0x31c25c145e66dbe9)
  - More recent NFT contract on Previewnet: [Previewnet NFT Contract](https://previewnet.flowdiver.io/contract/A.002bb351357cf238.NonFungibleToken?tab=deployments)

- **Tools**:
  - [Contract Browser](https://contractbrowser.com/)
  - [Migration ChatGPT Bot](https://chatgpt.com/g/g-lt4a6jvfj-flow-cadence-1-0-migration-helper)
  - [Current TopShot Wallet](https://flow-view-source.com/mainnet/account/0x0b2a3299cc857e29/contract/TopShot)
  - [Media Gateway Documentation](https://developers.nbatopshot.com/docs/Media%20Gateway/index.html)
  - [Flow Developer Documentation](https://developers.flow.com/)
  - [Flow NFT Catalog](https://www.flow-nft-catalog.com/)
  - [Graffle](https://www.graffle.io/)
  - [ECDAO Documentation](https://docs.ecdao.org/)
  - [ECDAO Links](https://link.ecdao.org/)
  - [Dapper Labs Developer Portal](https://developers.dapperlabs.com/)

## Data Sources

- [FlowDiver Analytics](https://www.flowdiver.io/analytics?interval=1Y)
- FindLabs is working on a new API, but the historical API 1.1.0 should work: [FindLabs API](https://findonflow.github.io/findlabs-api/)
- [Flipside Crypto Flow Models](https://flipsidecrypto.github.io/flow-models/#!/overview/flow_models)
