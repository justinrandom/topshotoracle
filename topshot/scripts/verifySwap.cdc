import FlowSwapV1 from "FlowSwapV1"

pub fun main(): Bool {
    let adminAccount = getAccount(0xf8d6e0586b0a20c7) // Replace with the actual FlowSwap contract address
    let swapCap = adminAccount.getCapability(/public/flowSwap)
    return swapCap.check<&FlowSwapV1.Swap>()
}
