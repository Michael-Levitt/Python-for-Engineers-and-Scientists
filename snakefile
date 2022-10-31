
rule sum:
    output:
        "test/{n}_sum.txt"
    run:
        with open(output[0], 'w') as file:
            file.write(str(sum(2**k for k in range(int(wildcards.n)))))
            
rule product:
    input:
        "test/{n}_sum.txt"
    output:
        "test/{n}_product.txt"
    run:
        import sympy
        
        s = int(open(input[0], 'r').read())
        
        with open(output[0], 'w') as file:
            if sympy.isprime(s):
                file.write(str(s * 2**(int(wildcards.n) - 1)))
            else:
                file.write('0')
            
rule find:
    input:
        expand("test/{n}_product.txt", n=range(1,21))
    output:
        "test/perfect.txt"
    run:
        with open(output[0], 'w') as file:
            for inputfile in input:
                p = int(open(inputfile, 'r').read())
                
                if p != 0:
                    file.write(f'{p}\n')
