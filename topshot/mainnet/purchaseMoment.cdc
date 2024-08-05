import DapperUtilityCoin from 0xead892083b3e2c6c
import FungibleToken from 0xf233dcee88fe0abe
import NonFungibleToken from 0x1d7e57aa55817448
import MetadataViews from 0x1d7e57aa55817448
import NFTCatalog from 0x49a7cda3a1eecc29
import NFTStorefrontV2 from 0x3cdbb3d569211ff3
import HybridCustody from 0xd8a7e05a7ac670c0
import TopShot from 0x0b2a3299cc857e29

/// Transaction facilitates the purcahse of listed NFT.
/// It takes the storefront address, listing resource that need
/// to be purchased & a address that will takeaway the commission.
///
/// Buyer of the listing (,i.e. underling NFT) would authorize and sign the
/// transaction and if purchase happens then transacted NFT would store in
/// buyer's collection.

transaction(storefrontAddress: Address, listingResourceID: UInt64, commissionRecipient: Address, collectionIdentifier: String, nftReceiverAddress: Address) {
    let paymentVault: @FungibleToken.Vault
    let collection: &AnyResource{NonFungibleToken.CollectionPublic}
    let collectionCap: Capability<&AnyResource{NonFungibleToken.CollectionPublic}>
    let storefront: &NFTStorefrontV2.Storefront{NFTStorefrontV2.StorefrontPublic}
    let listing: &NFTStorefrontV2.Listing{NFTStorefrontV2.ListingPublic}
    var commissionRecipientCap: Capability<&{FungibleToken.Receiver}>?
    let balanceBeforeTransfer: UFix64
    let mainPaymentVault: &DapperUtilityCoin.Vault
    let listingAcceptor: &NFTStorefrontV2.Storefront{NFTStorefrontV2.PrivateListingAcceptor}

    prepare(dapper: AuthAccount, buyer: AuthAccount) {
        if buyer.borrow<&NFTStorefrontV2.Storefront>(from: NFTStorefrontV2.StorefrontStoragePath) == nil {
            // Create a new empty Storefront
            let storefront <- NFTStorefrontV2.createStorefront() as! @NFTStorefrontV2.Storefront
            // save it to the account
            buyer.save(<-storefront, to: NFTStorefrontV2.StorefrontStoragePath)
            // create a public capability for the Storefront, first unlinking to ensure we remove anything that's already present
            buyer.unlink(NFTStorefrontV2.StorefrontPublicPath)
            buyer.link<&NFTStorefrontV2.Storefront{NFTStorefrontV2.StorefrontPublic}>(NFTStorefrontV2.StorefrontPublicPath, target: NFTStorefrontV2.StorefrontStoragePath)
        }

        self.listingAcceptor = buyer.borrow<&NFTStorefrontV2.Storefront{NFTStorefrontV2.PrivateListingAcceptor}>(from: NFTStorefrontV2.StorefrontStoragePath) ?? panic("Buyer storefront is invalid")

        let value = NFTCatalog.getCatalogEntry(collectionIdentifier: collectionIdentifier) ?? panic("Provided collection is not in the NFT Catalog.")

        self.commissionRecipientCap = nil
        // Access the storefront public resource of the seller to purchase the listing.
        self.storefront = getAccount(storefrontAddress)
            .getCapability<&NFTStorefrontV2.Storefront{NFTStorefrontV2.StorefrontPublic}>(
                NFTStorefrontV2.StorefrontPublicPath
            )!
            .borrow()
            ?? panic("Could not borrow Storefront from provided address")

        // Borrow the listing
        self.listing = self.storefront.borrowListing(listingResourceID: listingResourceID)
            ?? panic("Listing not found")
        let listingDetails = self.listing.getDetails()
        let nftRef = self.listing.borrowNFT() ?? panic("nft not found")

        if nftReceiverAddress == buyer.address {
            self.collectionCap = buyer.getCapability<&AnyResource{NonFungibleToken.CollectionPublic}>(value.collectionData.publicPath)
            // unlink and relink first, if it still isn't working, then we will try to save it!
            if !self.collectionCap.check() {
                if buyer.borrow<&AnyResource>(from: value.collectionData.storagePath) == nil {
                    // pull the metdata resolver for this listing's nft and use it to configure this account's collection
                    // if it is not already configured.
                    let collectionData = nftRef.resolveView(Type<MetadataViews.NFTCollectionData>())! as! MetadataViews.NFTCollectionData
                    buyer.save(<-collectionData.createEmptyCollection(), to: value.collectionData.storagePath)
                }

                buyer.unlink(value.collectionData.publicPath)
                if nftRef.getType() == Type<@TopShot.NFT>() {
                    buyer.link<&TopShot.Collection{TopShot.MomentCollectionPublic, NonFungibleToken.CollectionPublic, NonFungibleToken.Receiver, MetadataViews.ResolverCollection}>(value.collectionData.publicPath, target: value.collectionData.storagePath)
                } else {
                    buyer.link<&AnyResource{NonFungibleToken.CollectionPublic, NonFungibleToken.Receiver, MetadataViews.ResolverCollection}>(value.collectionData.publicPath, target: value.collectionData.storagePath)
                }
            }
        } else {
            // signer is the parent account and nftProvider is child Account
            // get the manager resource and borrow proxyAccount
            let manager = buyer.borrow<&HybridCustody.Manager>(from: HybridCustody.ManagerStoragePath)
                ?? panic("manager does not exist")
            let childAcct = manager.borrowAccount(addr: nftReceiverAddress) ?? panic("nft receiver address is not a child account")
            self.collectionCap = getAccount(nftReceiverAddress).getCapability<&AnyResource{NonFungibleToken.CollectionPublic}>(value.collectionData.publicPath)
            // We can't change child account links in any way
        }

        // Access the buyer's NFT collection to store the purchased NFT.
        self.collection = self.collectionCap.borrow() ?? panic("Cannot borrow NFT collection receiver from account")

        let price = listingDetails.salePrice

        // Access the vault of the buyer to pay the sale price of the listing.
        self.mainPaymentVault = dapper.borrow<&DapperUtilityCoin.Vault>(from: /storage/dapperUtilityCoinVault)
            ?? panic("Cannot borrow DapperUtilityCoin vault from buyer storage")
        self.balanceBeforeTransfer = self.mainPaymentVault.balance
        self.paymentVault <- self.mainPaymentVault.withdraw(amount: price)

        // Fetch the commission amt.
        let commissionAmount = self.listing.getDetails().commissionAmount

        if commissionRecipient != nil && commissionAmount != 0.0 {
            // Access the capability to receive the commission.
            let _commissionRecipientCap = getAccount(commissionRecipient!).getCapability<&{FungibleToken.Receiver}>(/public/dapperUtilityCoinReceiver)
            assert(_commissionRecipientCap.check(), message: "Commission Recipient doesn't have DapperUtilityCoin receiving capability")
            self.commissionRecipientCap = _commissionRecipientCap
        } else if commissionAmount == 0.0 {
            self.commissionRecipientCap = nil
        } else {
            panic("Commission recipient can not be empty when commission amount is non zero")
        }

    }

    execute {
        // Purchase the NFT
        let item <- self.listing.purchase(
            payment: <-self.paymentVault,
            commissionRecipient: self.commissionRecipientCap,
            privateListingAcceptor: self.listingAcceptor
        )
        // Deposit the NFT in the buyer's collection.
        self.collection.deposit(token: <-item)
    }

    post {
        self.mainPaymentVault.balance == self.balanceBeforeTransfer: "DapperUtilityCoin leakage"
    }

}