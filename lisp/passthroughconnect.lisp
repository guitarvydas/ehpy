(in-package "EH")

(defclass PassThroughConnect (Connector) ())

(defmethod guarded-deliver ((self PassThroughConnect) inmessage)
  (cond ((match (sender self) (from inmessage) (port inmessage))
	 (let ((receiver (receiver self)))
	   (let ((sender (sender self)))
	     (format *standard-output* "PASSTHROUGH ~a .... ~a -> ~a" inmessage (name sender) (name receiver))
	     (let ((mappedMessage (make-instance 'OutputMessage :from self :port (port receiver) :data (data inmessage) :trail inmessage)))
	       (enqueue-output receiver mappedMessage)))))
	(t nil)))

