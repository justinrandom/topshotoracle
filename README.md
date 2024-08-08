# TopShot Badges and Tiers

This project is designed to help find the tier and badges of NBA Top Shot moments on-chain.

## Tiers Status

Under review/testing. Will deploy to mainnet soon.

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

https://github.com/dapperlabs/nba-smart-contracts
https://github.com/rrrkren/topshot-explorer

## Set Tiers Reference

1. Ultimate
2. Common
3. Ultimate
4. Legendary
5. Rare
6. Rare
7. Rare
8. Legendary
9. Rare
10. Rare
11. Rare
12. Legendary
13. Rare
14. Common
15. Rare
16. Rare
17. Rare
18. Rare
19. Rare
20. Legendary
21. Rare
22. Common
23. Legendary
24. Rare
25. Rare
26. Common
27. Ultimate
28. Legendary
29. Rare
30. Rare
31. Legendary
32. Common
33. Common
34. Common
35. Rare
36. Common
37. Hustle and Show
38. Rare
39. Common
40. Rare
41. Legendary
42. Ultimate
43. Fandom
44. Common
45. Fandom
46. Rare
47. Rare
48. Common
49. Fandom
50. Legendary
51. Common
52. Ultimate
53. Legendary
54. Rare
55. Rare
56. Fandom
57. Legendary
58. Common
59. Common
60. Common
61. Legendary
62. Fandom
63. Rare
64. Rare
65. Common
66. Fandom
67. Common
68. Rare
69. Legendary
70. Fandom
71. Rare
72. Common
73. Common
74. Legendary 2648, 2649, 2837
75. Rare 2650, 2651
76. Rare
77. Fandom
78. Fandom
79. Fandom
80. Rare
81. Fandom
82. Rare
83. Legendary
84. Rare
85. Common
86. Rare
87. Fandom
88. Fandom
89. Fandom
90. Rare
91. Common
92. Common
93. Common
94. Rare
95. Rare
96. Rare
97. Legendary
98. Rare
99. Common
100. Rare
101. Legendary 3345, 3919, 5304
102. Rare 4163, 5301
103. Fandom
104. Rare
105. Legendary
106. Common
107. Common
108. Legendary
109. Fandom
110. Common
111. Legendary 3938, 5299
112. Rare 4162, 5300
113. Legendary
114. Common
115. Rare
116. Common
117. Legendary 3938, 5299
118. Rare 4162, 5300
119. Rare
120. Legendary
121. Legendary 4126, 4128, 5305
122. Rare 4124, 4125, 4127, 5306
123. Legendary
124. Common
125. Rare
126. Legendary
127. Legendary
128. Legendary
129. Common
130. Common
131. Common
132. Rare
133. Rare
134. Common
135. Rare
136. Legendary
137. Common
138. Common
139. Rare
140. Rare
141. Rare
142. Common
143. Fandom
144. Legendary
145. Ultimate
146. Fandom 5149, 5150, 5151, 5152, 5153, 5154, 5155, 5156, 5157, 5158, 5159, 5160, 5161, 5162, 5163, 5164, 5165, 5166, 5167, 5168, 5169, 5170, 5171, 5172, 5173, 5174, 5175, 5176, 5194, 5195, 5196, 5197
147. Rare 5177, 5178, 5179, 5180, 5181, 5182, 5183, 5184, 5185, 5186, 5187, 5188, 5189, 5190, 5192, 5193
148. Rare
149. Fandom
150. Common
151. Common
152. Rare
153. Legendary
154. Rare
155. Rare
156. Rare
157. Ultimate
158. Rare
159. Legendary

TSHOT

My goal is to create a $TSHOT fungible token on the flow blockchain. Users are able to exchange 1 NBA Top Shot NFT for 1 $TSHOT. I also want the user to be able to exchange 1 $TSHOT back for 1 NBA Top Shot NFT.

I'd like to adhere to best practices for security and design.

Although not absolutely necessary, I'd prefer if the admin was the one that minted $TSHOT.

I'd also prefer if there was the exchange contract was called TopShotExchange.

I am trying to determine ways this system can be designed, and what mechanics of Cadence can be leveraged to allow this to happen.

I'd also prefer if the exchange could happen in a single transaction initiated by the user.

When a user exchanges an NFT for a fungible token, I am unsure how we can automatically have the contract send or mint the token for the user. I think perhaps when the user sends the NFT to the contract, the admin verifies that it is a Top shot NFT, and then the admin mints the TSHOT coin and sends it to the user.

To-Do

Tiers
-Test update_mixed_tier
-Test remove_play_id_from_mixed_tier_set
