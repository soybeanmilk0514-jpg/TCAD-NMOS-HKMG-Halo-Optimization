# 01. Project Overview

## Problem

Gate length가 60 nm 수준으로 줄어들면서 drain electric field가 channel barrier에 영향을 주어 SCE와 off-state leakage가 커지는 문제를 대상으로 했다.

## Goal

1. 60 nm NMOS baseline에서 SCE 문제 확인
2. HfO₂ 기반 HKMG 적용 효과 평가
3. HKMG 구조에서 남는 punch-through 문제 확인
4. Halo Dose / Energy / Tilt split을 통해 leakage와 switching 특성의 균형점 탐색
5. 최종 공정 조건 선정

## Strategy

`Baseline → HKMG → HKMG + Halo Doping → Final condition`

Sidewall spacer는 Source/Drain junction을 형성하기 위한 실제 공정 흐름에 포함했지만, 제출 발표자료 기준으로 spacer 자체의 독립적인 최적화 sweep은 수행하지 않았다.
