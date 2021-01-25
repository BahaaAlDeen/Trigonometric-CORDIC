# Trignometric-CORDIC
Iterative discrete mathematical method to achieve an accurate trigonometric output. This code was used in the paper titled ["Analysis and FPGA of semi-fractal shapes based on complex Gaussian map"](https://doi.org/10.1016/j.chaos.2020.110493) 

# Mathematical Concept(MATLAB)

The trigonometric system is realized by using the CORDIC system achieving an iterative mathematical approximation given by [[1]](https://doi.org/10.1016/j.chaos.2020.110493) :

<img src="https://user-images.githubusercontent.com/44608585/105712967-3a355580-5f23-11eb-990c-2801856c35f0.png" width="200">

where A is the input angle, B is the cosine of the angle, C is the sine of the input angle. The index ζ is the iteration index and the variable ζ is either 1 or -1 depending on the value of  from the previous iteration where:

<img src="https://user-images.githubusercontent.com/44608585/105713342-b3cd4380-5f23-11eb-8788-6f1a3c931683.png" width="120">


The mathematical statement is realized in the architecture shown in Fig. 6, where the initial value for B amount to a scaling factor estimated to be B=0.6072 , the value of C and ζ are initialized at C=0 and ζ=1. As shown in Fig. 6 the index μ is bounded by a limit (μ≤a) defined as a comparator, where (a) is estimated optimally as (a=13)[[1]](https://doi.org/10.1016/j.chaos.2020.110493) . 

<img src="https://user-images.githubusercontent.com/44608585/105723646-af0e8c80-5f2f-11eb-9a10-868e32c566e4.png" width="500">

## How to use
To use this function simply clone the function file 'Mathematical Concept(MATLAB).m', and run the matlab script. See the comments within this file for more details on how to experiment with the different variables in this function. 

    Fractional Order Derivative/Integral using "Grunwald letnikov" formula to compute Differentiation/Integration at a certain order.

    input: 	'a' is the order of Differentiation/Integration.
		'h' is the accuraccy of the operation presented as an increment where the smaller value the better accuracy (Best value is 0.1) and 'y1' is the input discrete vector to be Differented/Integrated.
    out: 	 a discrete vector representing the Differentiation/Integration at order 'a'.




# FPGA Hardware Architecture(VERILOG)

To optimize the architecture, the values of <img src="https://user-images.githubusercontent.com/44608585/105716962-348e3e80-5f28-11eb-9324-511173801623.png" width="80"> and <img src="https://user-images.githubusercontent.com/44608585/105719993-9308ec00-5f2b-11eb-9070-2a1c28cc0cc0.png" width="30"> are stated in LUTs as shown in Fig. 6, selected by the state of the μ index . Eventually, the final value of B and C should give the cosine and the sine of the given angle, respectively, after a number of iterations (μ = a). The values set for the designed architecture variables and their initial conditions are depicted in the given Table. A comprehensive repository is realized with a software for the trigonometric CORDIC mathematical expression and hardware architecture.



<img src="https://ars.els-cdn.com/content/image/1-s2.0-S0960077920308857-gr6.jpg" width="400">
Fig.1 (source: creativecommons.org BY-SA 3.0)







The function gives more degree of freedome in the order domain, represented in the swept area between different integer orders.

<img src="https://user-images.githubusercontent.com/44608585/81625915-3dee6f80-93c8-11ea-9107-a52782b9211c.gif" width="250">


## How to use
To use this function simply clone the function file 'fogl.py', and run the main python script after adding the header 'from fogl import fogl' for the fogl function or 'from fogl import loopfogl' to use the loopfogl function.  See the comments within this file for more details on how to experiment with the different variables in this function. 

## fogl

    Fractional Order Derivative/Integral using "Grunwald letnikov" formula to compute Differentiation/Integration at a certain order.

    input: 	'a' is the order of Differentiation/Integration.
		'h' is the accuraccy of the operation presented as an increment where the smaller value the better accuracy (Best value is 0.1) and 'y1' is the input discrete vector to be Differented/Integrated.
    out: 	 a discrete vector representing the Differentiation/Integration at order 'a'.



## loopfogl

    Looping action for the Fractional Order Derivative/Integral using "Grunwald letnikov" at several orders.

    input: 	'y2' is the input matrix to be Differented/Integrated of size(N x width).
    		'N' is the number of signals. 'order' is a two element vector, where order[0] is the starting order and order[1] is the last order.'height' is the number of orders.
    		'width' is the length of each signal.
    out: 	a 3d matrix of N x width x height, where 'height' representing the Differentiation/Integration from order 'order[0]' to 'order[1]'.

    Shown in Fig.1 the code output of many fractional order Differentiation of a sin finction (shown in blue) at different orders (shown in red).

Fig.2

![Figure_1](https://user-images.githubusercontent.com/44608585/81622880-2ca16500-93c0-11ea-8f4e-6bbd677a9051.png) 

 



# FRFT Function (Fractional Order Fourier Transform)

A function that gets the Fractional Fourier Transform at a certain integer or fractional order, where the output is considered in the domain (u) between the time (x) and frequency domain (ξ), with a rotation angle (α) from the time domain.

<img src="https://user-images.githubusercontent.com/44608585/81695061-18954c00-9430-11ea-8682-659b56c89056.png" width="500">

This domain can be interpreted as linear combination of both coordinates (x, ξ) where, 

<img src="https://user-images.githubusercontent.com/44608585/81680963-f98fbd80-9421-11ea-9478-f4736ebe38b2.png" width="100">

<img src="https://user-images.githubusercontent.com/44608585/81681077-11674180-9422-11ea-8a87-0c773fc97ae4.png" width="100">

Therefore,

<img src="https://user-images.githubusercontent.com/44608585/81680609-5dfe4d00-9421-11ea-85da-7d87a36a97c8.png" width="100">

<img src="https://user-images.githubusercontent.com/44608585/81680718-8d14be80-9421-11ea-93bf-49fab397c2f9.png" width="100">

Then the fractional Fourier transform can be written as:

<img src="https://user-images.githubusercontent.com/44608585/81682193-b2ee9300-9422-11ea-879e-46db627e12a3.png" width="540">

The output of set operaton should mainly consists of a real and an imaginary component, but in the presented usage of the function only the real value is utilized.
The function can be used to input a discrete vector and output a single vector, or input a matrix and get a 3d matrix where the 3d dimension is Fractional Fourier Transform of each raw.



<img src="https://user-images.githubusercontent.com/44608585/81625725-ba348300-93c7-11ea-9c90-83f29661c21e.gif" width="350">
Fig.3 (source: creativecommons.org BY-Gblama)

## How to use
To use this function simply clone the function file 'frft.py', and run the main python script after adding the header 'from frft import frft' for the frft function or 'from frft import loopfrft' to use the loopfrft function.  See the comments within this file for more details on how to experiment with the different variables in this function. 

## frft

    Fractional Order Fourier Transform to compute the Fractional Fourier Transform at a certain integer or fractional order, where the output is considered in a
    domain between the time and frequency domain.

    input: 	'a' is the order of Fractional Order(a>0 for Fourier Transform, a<0 for Inverse Fourier Transform).
		'f' is the input discrete vector to be Transformed to frequency or time domain.
    out: 	a discrete vector representing the Fractional Order (Fourier/inv.Fourier) Transform at order 'a'.

## loopfrft

    Looping action for the Fractional Order Fourier Transform at several orders.

    input: 	'y2' is the input matrix to be Transformed of size(N x width).
    		'N' is the number of signals. 'order' is a two element vector, where order[0] is the starting order and order[1] is the last order.
		'height' is the number of orders.
    		'width' is the length of each signal.
    out: 	a 3d matrix of N x width x height, where 'height' representing the Fractional Order (Fourier/inv.Fourier) Transform from order 'order[0]' to 'order[1]'.
