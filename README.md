# base-points-system

> On-Chain Points & Loyalty System for Base L2

Reward users for interacting with your Base protocol. Issue non-transferable points, define earning rules, and run loyalty campaigns — fully on-chain and transparent.

## Features
- 🏆 Non-transferable ERC-20 points (soulbound)
- 📏 Rule engine: earn points for swaps, deposits, referrals
- 🎖️ Tier system (Bronze, Silver, Gold, Diamond)
- 🗓️ Seasonal campaigns with multipliers
- 📊 Leaderboard (on-chain + off-chain Merkle)
- 🔗 API for off-chain point queries

## Points Earning Rules
| Action | Points |
|--------|--------|
| First deposit | 100 pts |
| Each $100 traded | 10 pts |
| Referral signup | 50 pts |
| Daily active use | 5 pts |
| NFT holder bonus | 2x multiplier |

## Installation
```bash
git clone https://github.com/fabt31/base-points-system
forge install && forge build
```

## License
MIT