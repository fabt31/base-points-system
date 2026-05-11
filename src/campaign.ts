export interface Campaign {
  id: string; name: string; multiplier: number;
  startDate: Date; endDate: Date; rules: string[];
}
export const EXAMPLE_CAMPAIGNS: Campaign[] = [
  { id: "onchain-summer-2025", name: "Onchain Summer 2025", multiplier: 2,
    startDate: new Date("2025-07-01"), endDate: new Date("2025-08-31"),
    rules: ["2x points on all swaps", "Bonus 500 pts for first NFT mint", "Daily check-in: 10 pts"] },
  { id: "defi-week", name: "DeFi Week", multiplier: 1.5,
    startDate: new Date("2025-06-01"), endDate: new Date("2025-06-07"),
    rules: ["1.5x on lending/borrowing", "100 pts for new position"] }
];
