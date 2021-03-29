# Combustion simulation of solid rocket motor

# References
Nakka's website


# Burn rate r 
```
> burnrate
```
Burn rate r is calculated by the following formula.

![](misc/r.png)

Where the constant a and n are dependent on the combustion pressure. I obtained the experimental value of (a,n) from Nakka's website. Here below is the theoretical burnrate using the experimental value of (a,n).

![burnrate.png](misc/burnrate.png)


# Steady state pressure P0

```
> steady_state
```
Combustion pressure at the steady-state is the following.

![](misc/p0.png)

The both sides of the above formula is the function of P0 (That is like, y = f(y)). To find P0, I solved the follwing equation by the [**bisection method**](https://en.wikipedia.org/wiki/Bisection_method). (the following equation is like, g(y)=y-f(y)=0)
 
![](misc/f.png)

Note that Klemmung Kn and burn area Ab was calculated as follows.
The formula is for BATES, where the outer surface is inhibited.

![](misc/Kn.png)

![](misc/Ab.png)

![burnrate.png](misc/steady_state.png)

# Start-up pressure P0
The derivative of the combustion pressure P0 is calcuated by the following equation.
![](misc/dpdt.png)

where T0 is the AFT (adiabatic flame temperature), v0/rho0 is the volume/density of the product gas (mixture of several molecules).

The product gas volume v_0 can be found as follows.
![](misc/v0_draw.jpg)

![](misc/v0.png)



