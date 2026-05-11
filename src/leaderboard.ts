import { ethers } from "ethers";
export async function fetchLeaderboard(contractAddress: string, provider: ethers.JsonRpcProvider, topN = 10) {
  const abi = ["event PointsEarned(address indexed user, uint256 amount, string reason)", "function points(address) view returns (uint256)", "function getTierName(address) view returns (string)"];
  const contract = new ethers.Contract(contractAddress, abi, provider);
  const logs = await provider.getLogs({ address: contractAddress, topics: [ethers.id("PointsEarned(address,uint256,string)")], fromBlock: 0, toBlock: "latest" });
  const users = [...new Set(logs.map(l => "0x" + l.topics[1].slice(26)))];
  const entries = await Promise.all(users.map(async u => ({
    address: u, points: await contract.points(u), tier: await contract.getTierName(u)
  })));
  return entries.sort((a, b) => Number(b.points - a.points)).slice(0, topN);
}
