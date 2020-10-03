function updateSIR(popnvector)
    susceptible = popnvector[1]
    infected = popnvector[2]
    removed = popnvector[3]

    newS = susceptible - lambda*susceptible*infected*dt
    newI = infected + lambda*susceptible*infected*dt - gam*infected*dt
    newR = removed + gam*infected*dt

    return [newS newI newR]
end

using DelimitedFiles
EVD_clean = DelimitedFiles.readdlm("data/wikiEVD_clean.csv", ',')
epidays = EVD_clean[:, 1]
allcases = EVD_clean[:, 2]

dt, lambda, gam = 0.5, 1.47*10^-6, 0.125
s, i, r = 10^5, 20., 0.
vec = [s i r]
tfinal = 610.

nsteps = round(Int64, tfinal/dt)
resultvals = Array{Float64}(undef, nsteps+1, 3)
timevec = Array{Float64}(undef, nsteps+1)

resultvals[1, :] = vec
timevec[1] = 0.

for step = 1:nsteps
    resultvals[step+1, :] = updateSIR(resultvals[step, :])
    timevec[step+1] = timevec[step] + dt
end

# Make plots
ivals = resultvals[:, 2]
rvals = resultvals[:, 3]
cvals = ivals + rvals

using Plots
gr()

plot(
    timevec,
    cvals,
    label = "Model Values",
    xlabel = "Epidemic day",
    ylabel = "Number of cases to date",
    title = "Model vs Data"
)

plot!(
    epidays,
    allcases,
    legend = :right,
    line = :scatter,
    label = "Reported number of cases"
)
savefig("plots/EVD_model.png")
