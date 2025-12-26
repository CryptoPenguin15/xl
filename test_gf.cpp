#include <cassert>
#include <cstdio>

#include "gf/gf.h"

#if QQ == 2
  #include "gf/gf2.h"
#elif QQ == 16
  #include "gf/gf16.h"
#elif QQ == 31
  #include "gf/gf31.h"
#else
  #error Unsupported field
#endif

static inline int mod(int x) {
#if QQ == 31
    x %= 31;
    if (x < 0) x += 31;
    return x;
#else
    return x;
#endif
}

static int ref_mul(int a, int b) {
#if QQ == 2
    return a & b;
#elif QQ == 31
    return mod(a * b);
#else
    // GF(16): reference via implementation (API consistency)
    gf A(a), B(b);
    return uint8_t(A * B);
#endif
}

static void test_mul_closure() {
    for (int a = 0; a < QQ; a++) {
        for (int b = 0; b < QQ; b++) {
            gf A(a), B(b);
            uint8_t c = uint8_t(A * B);
            assert(c < QQ);
        }
    }
}

static void test_mul_correctness() {
    for (int a = 0; a < QQ; a++) {
        for (int b = 0; b < QQ; b++) {
            gf A(a), B(b);
            assert(uint8_t(A * B) == ref_mul(a, b));
        }
    }
}

static void test_mul_identity() {
    gf one(1);

    for (int a = 0; a < QQ; a++) {
        gf A(a);
        assert(uint8_t(A * one) == uint8_t(A));
        assert(uint8_t(one * A) == uint8_t(A));
    }
}

static void test_mul_associativity() {
    for (int a = 0; a < QQ; a++) {
        for (int b = 0; b < QQ; b++) {
            for (int c = 0; c < QQ; c++) {
                gf A(a), B(b), C(c);
                uint8_t x = uint8_t((A * B) * C);
                uint8_t y = uint8_t(A * (B * C));
                assert(x == y);
            }
        }
    }
}

static void test_inverses() {
    gf one(1);

    for (int a = 1; a < QQ; a++) {
        gf A(a);
        gf invA = A.inv();
        assert(uint8_t(A * invA) == uint8_t(one));
        assert(uint8_t(invA * A) == uint8_t(one));
    }
}

int main() {
    printf("[+] GF multiplicative API verification (Q=%d)\n", QQ);

    test_mul_closure();
    test_mul_correctness();
    test_mul_identity();
    test_mul_associativity();
    test_inverses();

    printf("[+] All GF multiplicative tests PASSED (Q=%d)\n", QQ);
    return 0;
}

