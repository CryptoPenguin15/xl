#!/usr/bin/env sage
# -*- coding: utf-8 -*-

"""
mq_instance_gen.sage

Generate MQ Challenge-style quadratic systems over
Q ∈ {2,16,31} with a planted solution.

MQ Challenge format output.
"""

import argparse
from sage.all import (
    GF, PolynomialRing, set_random_seed, vector
)

def build_field(Q):
    if Q == 2:
        return GF(2), "GF(2)"

    if Q == 31:
        return GF(31), "GF(31)"

    if Q == 16:
        Fx = GF(2)['x']
        x = Fx.gen()
        mod = x**4 + x + 1
        F = GF(2**4, name='a', modulus=mod)
        return F, "GF(16)"

    raise ValueError("Q must be one of {2,16,31}")

def monomial_list_quadratic(xs):
    n = len(xs)
    mons = []

    for k in range(n):
        for i in range(k + 1):
            mons.append(xs[i] * xs[k])

    mons.extend(xs)
    mons.append(xs[0].parent()(1))
    return mons

def coeff_to_token(c, Q):
    if Q == 2:
        return str(int(c))

    if Q == 31:
        return str(int(c))

    if Q == 16:
        v = int(c._integer_representation())
        return f"{v:02x}"

    raise ValueError("Bad field")

def generate_system(Q, n, m, seed):
    F, field_hdr = build_field(Q)
    set_random_seed(seed)

    R = PolynomialRing(F, [f"x{i+1}" for i in range(n)],
                       order="degrevlex")
    xs = R.gens()
    mons = monomial_list_quadratic(xs)
    const_idx = len(mons) - 1

    solution = vector(F, [F.random_element() for _ in range(n)])

    polys = []

    for _ in range(m):
        coeffs = [F.random_element() for _ in range(len(mons))]

        val = F(0)
        for j, mon in enumerate(mons[:-1]):
            val += coeffs[j] * mon(*solution)

        coeffs[const_idx] = -val
        polys.append(coeffs)

    return field_hdr, polys, solution

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--Q", type=int, required=True, choices=[2,16,31])
    ap.add_argument("--n", type=int, required=True)
    ap.add_argument("--m", type=int, required=True)
    ap.add_argument("--seed", type=int, required=True)
    ap.add_argument("--out", type=str, default="")
    args = ap.parse_args()

    field_hdr, polys, sol = generate_system(
        args.Q, args.n, args.m, args.seed
    )

    lines = []
    lines.append(f"Galois Field : {field_hdr}")
    lines.append(f"Number of variables (n) : {args.n}")
    lines.append(f"Number of polynomials (m) : {args.m}")
    lines.append(f"Seed : {args.seed}")
    lines.append("Order : graded reverse lex order")
    lines.append("")
    lines.append("*********************")

    for coeffs in polys:
        toks = [coeff_to_token(c, args.Q) for c in coeffs]
        lines.append(" ".join(toks) + " ;")

    sol_tokens = [coeff_to_token(c, args.Q) for c in sol]
    lines.append("")
    lines.append("#" + " ".join(sol_tokens) + "  is sol")

    output = "\n".join(lines) + "\n"

    if args.out:
        with open(args.out, "w") as f:
            f.write(output)
    else:
        print(output, end="")

if __name__ == "__main__":
    main()
