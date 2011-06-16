      EXTERNAL FEX, GEX
      DOUBLE PRECISION ATOL, RTOL, RWORK, T, TOUT, Y
      DIMENSION Y(3), ATOL(3), RWORK(76), IWORK(23), JROOT(2)
      NEQ = 3
      Y(1) = 1.
      Y(2) = 0.
      Y(3) = 0.
      T = 0.
      TOUT = .4
      ITOL = 2
      RTOL = 1.D-4
      ATOL(1) = 1.D-6
      ATOL(2) = 1.D-10
      ATOL(3) = 1.D-6
      ITASK = 1
      ISTATE = 1
      IOPT = 0
      LRW = 76
      LIW = 23
      JT = 2
      NG = 2
      DO 40 IOUT = 1,12
  10    CALL DLSODAR(FEX,NEQ,Y,T,TOUT,ITOL,RTOL,ATOL,ITASK,ISTATE,
     1     IOPT,RWORK,LRW,IWORK,LIW,JDUM,JT,GEX,NG,JROOT)
        WRITE(6,20)T,Y(1),Y(2),Y(3)
  20    FORMAT(' At t =',D12.4,'   Y =',3D14.6)
        IF (ISTATE .LT. 0) GO TO 80
        IF (ISTATE .EQ. 2) GO TO 40
        WRITE(6,30)JROOT(1),JROOT(2)
  30    FORMAT(5X,' The above line is a root,  JROOT =',2I5)
        ISTATE = 2
        GO TO 10
  40    TOUT = TOUT*10.
      WRITE(6,60)IWORK(11),IWORK(12),IWORK(13),IWORK(10),
     1   IWORK(19),RWORK(15)
  60  FORMAT(/' No. steps =',I4,'  No. f-s =',I4,'  No. J-s =',I4,
     1   '  No. g-s =',I4/
     2   ' Method last used =',I2,'   Last switch was at t =',D12.4)
      STOP
  80  WRITE(6,90)ISTATE
  90  FORMAT(///' Error halt.. ISTATE =',I3)
      STOP
      END
 
      SUBROUTINE FEX (NEQ, T, Y, YDOT)
      DOUBLE PRECISION T, Y, YDOT
      DIMENSION Y(3), YDOT(3)
      YDOT(1) = -.04*Y(1) + 1.D4*Y(2)*Y(3)
      YDOT(3) = 3.D7*Y(2)*Y(2)
      YDOT(2) = -YDOT(1) - YDOT(3)
      RETURN
      END
 
      SUBROUTINE GEX (NEQ, T, Y, NG, GOUT)
      DOUBLE PRECISION T, Y, GOUT
      DIMENSION Y(3), GOUT(2)
      GOUT(1) = Y(1) - 1.D-4
      GOUT(2) = Y(3) - 1.D-2
      RETURN
      END
