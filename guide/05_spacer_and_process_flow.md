# 05. Spacer & Process Flow

## Implemented Process Sequence

1. Silicon region / background doping initialization
2. channel background Boron implant and anneal
3. interfacial Oxide deposition
4. HfO₂ deposition
5. TiN + PolySilicon gate deposition
6. gate patterning
7. four-direction Boron halo implantation
8. Arsenic LDD implantation
9. Nitride sidewall spacer deposition / anisotropic etch
10. deep Arsenic Source/Drain implantation
11. 1050 °C activation anneal
12. Aluminum contact layer and device contacts

## Spacer

The code uses:

```text
deposit Nitride thickness = 0.030
etch Nitride thickness = 0.035
```

The spacer therefore acts as part of junction engineering between LDD and deep Source/Drain formation. The submitted result deck does not show an independent spacer-thickness sweep, so the repository describes it as an implemented fixed process step rather than an optimized variable.
