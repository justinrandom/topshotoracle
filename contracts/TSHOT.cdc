import FungibleToken from "FungibleToken"

pub contract TSHOT: FungibleToken {

    pub var totalSupply: UFix64

    pub resource Vault: FungibleToken.Provider, FungibleToken.Receiver, FungibleToken.Balance {
        pub var balance: UFix64

        init(balance: UFix64) {
            self.balance = balance
        }

        pub fun withdraw(amount: UFix64): @FungibleToken.Vault {
            self.balance = self.balance - amount
            return <-create Vault(balance: amount)
        }

        pub fun deposit(from: @FungibleToken.Vault) {
            self.balance = self.balance + from.balance
            destroy from
        }

        pub fun getBalance(): UFix64 {
            return self.balance
        }
    }

    pub fun createVault(initialBalance: UFix64): @Vault {
        return <-create Vault(balance: initialBalance)
    }

    init() {
        self.totalSupply = 0.0
    }
}
