# 04. Halo Doping Optimization

## Parameter Splits

The project evaluates three halo parameters:

- Dose: `1e13`, `2e13`, `5e13 cm^-2`
- Energy: multiple split values around the selected `20 keV`
- Tilt: `15°`, `20°`, `25°`

## Dose Trend

With Energy and Tilt fixed for comparison:

- `1e13`: insufficient pocket concentration → weaker punch-through suppression
- `2e13`: selected balance between leakage suppression and channel conduction
- `5e13`: excessive channel-region doping → reported Ion reduction and SS degradation

**Selected Dose: `2e13 cm^-2`**

## Energy Trend

The selected energy was `20 keV`. The report interprets this as placing the P-pocket at a useful depth below the gate edge and maintaining strong channel control.

**Selected Energy: `20 keV`**

## Tilt Trend

The report states that increasing Tilt from `15° → 20° → 25°` slightly reduces Ion but substantially reduces Ioff, while SS remains near `68–69 mV/dec`.

At `25°`:

- `Ioff = 1.465e-15 A/µm`
- `Ion/Ioff = 1.41e12`

**Selected Tilt: `25°`**
