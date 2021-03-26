# Combustion simulation of solid rocket motor

# References
Nakka's website


# Burn rate r 
```
> burnrate
```
Burn rate r was calculated by the following formula.

![](misc/r.png)

I obtained the experimental value from Nakka's website.

![burnrate.png](misc/burnrate.png)


# Steady state pressure P0

```
> steady_state
```
Combustion pressure at the steady-state is the following.

![](misc/p0.png)

The both sides of the above formula is the function of P0. To find P0, I solved the follwing equation by the **bisection method**.
 
![](misc/f.png)


![burnrate.png](misc/steady_state.png)





