 OpenDonor Smart Contract

**OpenDonor** is a Clarity smart contract for accepting, recording, and managing STX-based donations on the Stacks blockchain. It ensures full **transparency**, **on-chain tracking**, and optional **admin withdrawal** of the collected funds.

---

 Features

-  Accept STX donations from anyone
-  Track individual and total donation amounts
-  Read-only views for donation transparency
-  Admin-only withdrawal of collected funds
-  Decentralized and censorship-resistant

---

Use Cases

- Community-driven fundraising
- Decentralized charity organizations
- Web3 public goods and social impact projects
- Donation analytics and donor accountability

---

 Contract Functions

| Function | Access | Description |
|---------|--------|-------------|
| `donate` | Public | Accepts and records STX donations from any principal |
| `withdraw` | Public (Admin only) | Withdraws specified amount of funds to an address |
| `get-donation-of` | Read-only | Returns total STX donated by a specific address |
| `get-total-donated` | Read-only | Returns the total STX donated to the contract |

---

 Example Usage

```clarity
;; User donates 50000 micro-STX
(donate)

;; Admin withdraws 1000000 micro-STX to treasury address
(withdraw u1000000 'ST123...admin)
