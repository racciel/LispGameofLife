(setq *print-case* :capitalize)

(defun createArray(rows cols)
    (make-array (list rows cols))
)

(defvar *numrows*)
(defvar *numcolumns*)

(defun start ()
    (print "Enter the number of rows: ")
    (setf *numrows* (read))

    ;;(setf *numrows* 50)

    (print "Enter the number of columns: ")
    
    ;;(setf *numcolumns* 50)
    (setf *numcolumns* (read))
    
    (defparameter *grid* (createArray *numrows* *numcolumns*))

    (dotimes (i *numrows*)
        (dotimes (j *numcolumns*)
            (if (= (round (/ (random 1.0) 1.8)) 1)
                (setf (aref *grid* i j) 'X)
                (setf (aref *grid* i j) '-)
            )
        )
    )

    (defparameter *newGrid* (createArray *numrows* *numcolumns*))
    (dotimes (x 9999999)
        ;;(print *grid*)
        (dotimes (i *numrows*)
            (dotimes (j *numcolumns*)
                (format t "~a" (aref *grid* i j))
            )
            (terpri)
        )
        (format t "                                    ")
        (nextGen *newGrid* *grid*)
        (setf *grid* *newGrid*)
        (sleep 0.2)
        (terpri)
        
    )
)

(defun nextGen(new old)
    (defvar current 0)
    (dotimes (i *numrows*)
        (dotimes (j *numcolumns*)
            (setf current (countNeighbors old i j))
            (setf (aref new i j) (aref old i j))
            (if (and (= current 3) (STRING= (aref old i j) '-))
                (setf (aref new i j) 'X)
                ;;(continue ())
            )
            (if (and (STRING= (aref old i j) 'X) (or (< current 2) (> current 3)))
                (setf (aref new i j) '-)
                ;;(continue ())
            )

            #| (if (STRING= (aref old i j) 'X)
                (
                    (if (or (< current 2) (> current 3))
                        (setf (aref new i j) '-)
                    )
                )
                (
                    (if (= current 3)
                        (setf (aref new i j) 'X)
                    )
                )
            ) |#
            ;;(print current)
            #| (if (and (STRING= (aref old i j) 'X) (or (= current 2) (= current 3)))
                (setf (aref new i j) 'X)
                (setf (aref new i j) '-)
            )
            (if (and (STRING= (aref old i j) '-) (= current 3))
                (setf (aref new i j) 'X)
                (setf (aref new i j) '-)
            ) |#

        )
    )
    ;;(terpri)
    ;;(print new)
)

(defun countNeighbors (grid x y)
    (defvar count 0)
    (setf count 0)
    (loop for i from (- x 1) to (+ x 1) by 1 do
        (if (< i 0)
            (setq i (+ i 1))
            (continue ())
        )
        (if (= i *numrows*)
            (return)
        )
        (loop for j from (- y 1) to (+ y 1) by 1 do
            (if (or (< j 0) (and (= j 0) (= i 0)))
                (setq j (+ j 1))
                (continue ())
            )
            (if (= j *numcolumns*)
                (return)
            )
            (if (STRING= (aref grid i j) 'X)
                (setq count (+ count 1))
            )
        )
    )
    (if (STRING= (aref grid x y ) 'X)
        (setf count (- count 1))
    )
    (return-from countNeighbors count)
)

(start)
