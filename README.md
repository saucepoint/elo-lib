# elo-lib
Calculate changes in ELO after a result between *two* players. Enables storing ELO on-chain (and consequently allowing for trustless leaderboards & prize pools)

Add to your project (requires [foundry](https://book.getfoundry.sh/)):

```bash
forge install saucepoint/elo-lib
```

---

# Usage

```solidity
import {Elo} from "elo-lib/Elo.sol";

contract MyContract {
    // maps 
    mapping(address => uint256) elos;
}

```
