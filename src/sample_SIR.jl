function updateSIR(popnvector)
    susceptible = popnvector[1]
    infected = popnvector[2]
    removed = popnvector[3]

    newS = susceptible - lambda*susceptible*infected*dt
    newI = infected + lambda*susceptible*infected*dt - gam*infected*dt
    newR = removed + gam*infected*dt

    return [newS newI newR]
end

dt, lambda, gam = 0.5, 1/20000, 1/10
s, i, r = 10000., 4., 0.
vec = [s i r]
# updateSIR(vec)

tfinal = 610
nsteps = round(Int64, tfinal/dt)
resultvals = Array{Float64}(undef, nsteps+1, 3)
timevec = Array{Float64}(undef, nsteps+1)

resultvals[1, :] = vec
timevec[1] = 0.

for step = 1:nsteps
    resultvals[step+1, :] = updateSIR(resultvals[step, :])
    timevec[step+1] = timevec[step] + dt
end

using Plots
gr()

plot(
    timevec,
    resultvals,
    title = "Sample SIR Model",
    xlabel = "Epidemic day",
    ylabel = "Population size",
    label = ["Susceptible" "Infected" "Removed"]
)
savefig("plots/sample_SIR.png")
