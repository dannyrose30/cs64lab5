a)In the README.txt please explain what you think the “secret formula” file is doing (in one
paragraph, 3+ lines).

I think the "secret formula" file is taking an input series of numbers (an array) and providing a secure way to encrypt/decrypt them.
No one else knows the relations between encrypting and decrypting besides those who directly have the code. These relationsn are the functions 
secret_formula_apply and secret_formula_remove. By encrypting them with a mathematical equivalence, the secret_formula file encrypts then decrypts
to get the original series of numbers back.

b)Given arrays u = [0x03, 0x05 0x01] and t = [0x07, 0x03, 0x15] and given x, y are the same values as the above sample code. What happens if:
(i) c[i]=secret_formula_apply(u[i]), f[i]=secret_formula_apply(t[i]), then does u[i]*t[i] = secret_formula_remove(c[i]*f[i]) hold for all entries in both arrays? (2.5 points)
(ii) c[i]=secret_formula_apply(u[i]), f[i]=secret_formula_apply(t[i]), then does u[i]+t[i] = secret_formula_remove(c[i]+f[i]) hold for all entries in both arrays? (2.5 points)

Work:
u=[3, 5, 1], t=[7, 3, 21]
u*t = [21, 15, 21]
u+t = [10, 8, 22]

Test:
Encrypted u: c[i] = 9, 14, 1
Encrypted t: f[i] = 28, 9, 21
c[i]*f[i] = [252, 126, 21]
c[i] + f[i] = [37, 23, 22]
Decrypted[c[i]*f[i]] = 21, 15, 21 IT WORKED
Decrypted[c[i]+f[i]] = 31, 23, 22 IT DID NOT WORK


(i) c[i]=secret_formula_apply(u[i]), f[i]=secret_formula_apply(t[i]), then does u[i]*t[i] = secret_formula_remove(c[i]*f[i]) hold for all entries in both arrays? (2.5 points)
    Thus, the equation holds for all entries in both arrays. There is some sort of equivalance for multiplying the intial series' and the encrypted ones then feeding them into the decrypter.
(ii) c[i]=secret_formula_apply(u[i]), f[i]=secret_formula_apply(t[i]), then does u[i]+t[i] = secret_formula_remove(c[i]+f[i]) hold for all entries in both arrays? (2.5 points)
    This equation does not hold for all values of the array. It happens to hold for one but the others it does not. There appears to be no similar equivalence.