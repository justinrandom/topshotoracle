import TopShot from "TopShot"
import FungibleToken from "FungibleToken"
import FlowToken from "FlowToken"

pub contract FlowSwapV1 {

    // Event emitted when a swap is executed
    pub event SwapExecuted(from: Address, momentID: UInt64, amount: UFix64, swapType: String)

    // Event emitted when swapping is toggled
    pub event SwappingToggled(isEnabled: Bool)

    // Struct to store swap configuration
    pub struct SwapConfig {
        pub(set) var rate: UFix64
        pub(set) var isSwappingEnabled: Bool

        init(rate: UFix64, isSwappingEnabled: Bool) {
            self.rate = rate
            self.isSwappingEnabled = isSwappingEnabled
        }
    }

    // Admin resource for managing the contract
    pub resource Admin {

        // Function to update the swap rate
        pub fun updateRate(newRate: UFix64) {
            FlowSwapV1.swapConfig.rate = newRate
        }

        // Function to enable or disable swapping
        pub fun toggleSwapping(isEnabled: Bool) {
            FlowSwapV1.swapConfig.isSwappingEnabled = isEnabled
            emit SwappingToggled(isEnabled: isEnabled)
        }
    }

    // Swap configuration for NBA Top Shot
    pub var swapConfig: SwapConfig

    // Public resource for swapping
    pub resource Swap {

        pub fun swap(moment: @TopShot.NFT, recipient: Address) {
            // Check if swapping is enabled
            if !FlowSwapV1.swapConfig.isSwappingEnabled {
                panic("Swapping is currently disabled.")
            }

            // Determine the amount of Flow tokens to give for the moment
            let amount: UFix64 = FlowSwapV1.swapConfig.rate

            // Withdraw the amount from the vault
            let vaultRef = getAccount(FlowSwapV1.account.address).getCapability(/public/flowTokenVault)!.borrow<&FlowToken.Vault{FungibleToken.Provider}>()
                ?? panic("Could not borrow reference to Flow Vault")
            let tokens <- vaultRef.withdraw(amount: amount)

            // Deposit tokens into the recipient's account
            let recipientVault = getAccount(recipient).getCapability(/public/flowReceiver)!.borrow<&FlowToken.Vault{FungibleToken.Receiver}>()
                ?? panic("Could not borrow recipient's Flow token receiver")

            recipientVault.deposit(from: <-tokens)

            // Emit the SwapExecuted event
            emit SwapExecuted(from: recipient, momentID: moment.id, amount: amount, swapType: "TopShot")

            // Destroy the received moment (or send it to a specific address)
            destroy moment
        }
    }

    // Create and link the Admin and Swap resources
    init() {
        // Initialize swap configuration with default values
        self.swapConfig = SwapConfig(rate: 10.0, isSwappingEnabled: true) // Set default rate to 10.0

        // Create and save the Admin resource
        let admin <- create Admin()
        self.account.save(<-admin, to: /storage/flowSwapAdminV1)

        // Create and save the Swap resource if it doesn't exist
        if self.account.borrow<&FlowSwapV1.Swap>(from: /storage/flowSwap) == nil {
            let swap <- create Swap()
            self.account.save(<-swap, to: /storage/flowSwap)
            self.account.link<&FlowSwapV1.Swap>(/public/flowSwap, target: /storage/flowSwap)
        }
    }
}
