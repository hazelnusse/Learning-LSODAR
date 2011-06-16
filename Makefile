FC=gfortran
FFLAGS=-g -O0 -Wall

all : opkddemos testlsodar

opkda1.o : opkda1.f
opkda2.o : opkda2.f
opkdmain.o : opkdmain.f
opkddemos.o : opkddemos.f
testlsodar.o : testlsodar.f

opkddemos : opkda1.o opkda2.o opkdmain.o opkddemos.o
	$(FC) $(FFLAGS) opkda1.o opkda2.o opkdmain.o opkddemos.o -o opkddemos

testlsodar : opkda1.o opkda2.o opkdmain.o testlsodar.o
	$(FC) $(FFLAGS) opkda1.o opkda2.o opkdmain.o testlsodar.o -o testlsodar

clean :
	rm -rf *.o opkddemos testlsodar

.PHONY : all clean
