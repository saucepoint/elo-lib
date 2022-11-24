# elo-lib
Calculate ELO after a result between *two* players. Enables storing ELO on-chain (and consequently allows for trustless leaderboards & prize pools)

Add to your project (requires [foundry](https://book.getfoundry.sh/)):

```bash
forge install saucepoint/elo-lib
```

---

# Usage

```solidity
import {Elo} from "elo-lib/Elo.sol";

contract MyContract {
    // maps player to their ELO
    mapping(address => uint256) elos;
    
    function updateElo() external {
        // read the results from somewhere
        uint256 result = 100; // player 1 won
        uint256 kFactor = 20; // development factor (established players have lower kFactors)

        (uint256 change, bool negative) = Elo.ratingChange(elos[player1], elos[player2], result, kFactor);

        // update the elos
        if (negative) {
            // add your own overflow checks
            // be aware that change is 2 decimal places (1501 = 15.01 ELO change)
            elos[player1] -= change;
            elos[player2] += change;
        } else {
            elos[player1] += change;
            elos[player2] -= change;
        }
    }
}

```
