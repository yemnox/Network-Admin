import matplotlib
import matplotlib.pyplot as plt
import matplotlib.animation as animation

matplotlib.use('TKAgg')
# Create figure and axis for the plot
fig, ax = plt.subplots()

def animate(i):
    # Read data from the file
    with open("debit.txt", "r") as file:
        data = file.read().split('\n')

    xar = []
    yar = []
    for idx, line in enumerate(data):
        try:
            # Assuming the format is "timestamp - value"
            yar.append(float(line.split(' - ')[1].split()[0]))
            xar.append(idx)
        except (IndexError, ValueError):
            continue

    ax.clear()
    ax.plot(xar, yar)
    ax.set_xlabel('Time (index)')
    ax.set_ylabel('Bit Rate (bits/sec)')
    ax.set_title('Real-time Network Traffic')

# Set up the animation (updates every 1 second)
ani = animation.FuncAnimation(fig, animate, interval=1000) 

# Display the plot
plt.show()