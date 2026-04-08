Steps

Define State
Each state encodes:

(mx, my, sx, sy, on_stool, has_banana)
(mx, my) → monkey position
(sx, sy) → stool position
on_stool → whether monkey is on stool
has_banana → whether banana is grabbed

Initialize BFS

queue = deque([(start_state, [])])
visited = set([start_state])
start_state = (0, 0, stool_x, stool_y, False, False)
path keeps track of actions.
BFS Loop
Pop the first state from the queue.
If has_banana is True, return the path.
Otherwise, generate all possible next moves:
Walk if not on stool (within grid bounds)
Push stool if monkey is at the stool (stool moves in 4 directions)
Climb stool if monkey is at the stool
Grab banana if on stool at banana position
Add new states to queue
Only if not visited already.
Append the corresponding action to path.
Return
If BFS ends without grabbing banana → no solution.
Otherwise, return the path of actions.


from collections import deque

def solve_monkey_banana(n, stool_pos, banana_pos):
    start_state = (0, 0, stool_pos[0], stool_pos[1], False, False)
    
    queue = deque([(start_state, [])])
    visited = set([start_state])
    
    while queue:
        (mx, my, sx, sy, on_stool, has_banana), path = queue.popleft()
        
        if has_banana:
            return path
        
        possible_moves = []
        if not on_stool:
            for dx, dy in [(0,1),(0,-1),(1,0),(-1,0)]:
                nmx, nmy = mx + dx, my + dy
                if 0 <= nmx < n and 0 <= nmy < n:
                    possible_moves.append(
                        ((nmx, nmy, sx, sy, False, False),
                         f"Walk to ({nmx},{nmy})")
                    )
        if mx == sx and my == sy and not on_stool:
            for dx, dy in [(0,1),(0,-1),(1,0),(-1,0)]:
                nsx, nsy = sx + dx, sy + dy
                if 0 <= nsx < n and 0 <= nsy < n:
                    possible_moves.append(
                        ((nsx, nsy, nsx, nsy, False, False),
                         f"Push stool to ({nsx},{nsy})")
                    )
        if mx == sx and my == sy and not on_stool:
            possible_moves.append(
                ((mx, my, sx, sy, True, False),
                 "Climb stool")
            )
        if on_stool and mx == banana_pos[0] and my == banana_pos[1]:
            possible_moves.append(
                ((mx, my, sx, sy, True, True),
                 "Grab banana")
            )
        for next_state, action in possible_moves:
            if next_state not in visited:
                visited.add(next_state)
                queue.append((next_state, path + [action]))
    
    return None
n = int(input("Enter grid size (n x n): "))

sx = int(input("Enter stool X position: "))
sy = int(input("Enter stool Y position: "))
stool = (sx, sy)
bx = int(input("Enter banana X position: "))
by = int(input("Enter banana Y position: "))
banana = (bx, by)
steps = solve_monkey_banana(n, stool, banana)
if steps:
    print("\nMinimum steps found:", len(steps))
    for i, step in enumerate(steps, 1):
        print(f"{i}. {step}")
else:
    print("No solution found")


Enter grid size (n x n): 3
Enter stool X position: 1
Enter stool Y position: 1
Enter banana X position: 2
Enter banana Y position: 2
Minimum steps found: 6
1. Walk to (1,0)
2. Walk to (1,1)
3. Climb stool
4. Walk to (2,1)  # if you allow moving on stool
5. Walk to (2,2)
6. Grab banana
