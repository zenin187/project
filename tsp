Initialization
Let dp[pos][visited] store the minimum cost to visit all cities in visited starting at city pos.
Let parent[pos][visited] store the next city to move to for optimal path.
Initialize all dp[pos][visited] = ∞ and parent[pos][visited] = -1.
Set dp[0][1] = 0 (starting at city 0 with only city 0 visited).
Iterate over all subsets of cities
For each visited in 1 .. (1 << n) - 1 (all subsets of cities):
For each pos in 0 .. n-1:
If pos is included in visited:
For each next_city in 0 .. n-1:
If next_city is not in visited:
Compute new cost: cost = dp[pos][visited] + graph[pos][next_city]
If cost < dp[next_city][visited | (1 << next_city)]:
Update dp[next_city][visited | (1 << next_city)] = cost
Update parent[next_city][visited | (1 << next_city)] = pos
Compute minimum tour cost
Initialize min_cost = ∞ and last_city = -1.
For each city i in 1 .. n-1:
Compute total_cost = dp[i][(1 << n) - 1] + graph[i][0] (return to start)
If total_cost < min_cost:
Update min_cost = total_cost
Update last_city = i
Reconstruct optimal path
Initialize path = [0]
Let visited = (1 << n) - 1
While last_city != -1:
Append last_city to path
prev = parent[last_city][visited]
visited = visited ^ (1 << last_city) (remove last_city from visited)
last_city = prev
Reverse path and append 0 to return to start
Return
min_cost
path



def tsp(graph):
    n = len(graph)
    dp = [[-1] * (1 << n) for _ in range(n)]
    parent = [[-1] * (1 << n) for _ in range(n)]
    def solve(pos, visited):
        if visited == (1 << n) - 1:
            return graph[pos][0] 
        if dp[pos][visited] != -1:
            return dp[pos][visited]
        min_cost = float('inf')
        for city in range(n):
            if not (visited & (1 << city)):
                cost = graph[pos][city] + solve(city, visited | (1 << city))
                if cost < min_cost:
                    min_cost = cost
                    parent[pos][visited] = city
        dp[pos][visited] = min_cost
        return min_cost
    min_cost = solve(0, 1)
    path = [0]
    visited = 1
    pos = 0
    while True:
        next_city = parent[pos][visited]
        if next_city == -1:
            break
        path.append(next_city)
        visited |= (1 << next_city)
        pos = next_city
    path.append(0)
    return min_cost, path
n = int(input("Enter number of cities: "))
print("Enter cost matrix:")
graph = []
for i in range(n):
    row = list(map(int, input().split()))
    graph.append(row)
cost, path = tsp(graph)
print("\nMinimum cost:", cost)
print("Optimal path:", " -> ".join(map(str, path)))
