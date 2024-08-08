import NFTStorefrontV2 from 0x3cdbb3d569211ff3

pub fun main(): {String: AnyStruct} {
    let storefrontAddress: Address = 0x1adda8b67f032725

    // Borrow the public storefront capability
    let storefront = getAccount(storefrontAddress)
        .getCapability<&NFTStorefrontV2.Storefront{NFTStorefrontV2.StorefrontPublic}>(
            NFTStorefrontV2.StorefrontPublicPath
        )
        .borrow()
        ?? panic("Could not borrow Storefront from provided address")

    // Get all listing IDs
    let listingIDs = storefront.getListingIDs()
    var filteredListings: [NFTStorefrontV2.ListingDetails] = []
    let priceCriteria: UFix64 = 1.40

    // Iterate over listing IDs and fetch details
    for listingID in listingIDs {
        let listing = storefront.borrowListing(listingResourceID: listingID)
            ?? panic("Could not borrow listing with ID: ".concat(listingID.toString()))

        let details = listing.getDetails()
        
        // Filter based on your criteria, e.g., price ≤ 30 cents (0.3 Flow)
        if details.salePrice <= priceCriteria {
            filteredListings.append(details)
        }
    }

    let summary = {
        "totalListings": listingIDs.length,
        "filteredListingsCount": filteredListings.length,
        "criteria": {"priceUnder": priceCriteria},
        "filteredListings": filteredListings
    }

    return summary
}
