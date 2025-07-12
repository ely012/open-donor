;; OpenDonor - Transparent Donation Ledger Contract

;; Tracks total donations and individual donor history

(define-data-var total-donated uint u0)

(define-map donor-records
  {donor: principal}
  {amount: uint})

(define-data-var donation-log (list 1000 (tuple
  (donor principal)
  (amount uint)
  (timestamp uint)
  (message (optional (buff 80))))) (list))

;; -------------------------------
;; Public: Make a donation in STX
;; -------------------------------
(define-public (donate (amount uint) (message (optional (buff 80))))
  (let ((transferred (stx-transfer? amount tx-sender (as-contract tx-sender))))
    (begin
      (asserts! (> amount u0) (err u100))

      ;; Update donor's cumulative amount
      (let ((prev (default-to { amount: u0 } (map-get? donor-records {donor: tx-sender}))))
        (map-set donor-records {donor: tx-sender} 
          {amount: (+ amount (get amount prev))}))

      ;; Increment total donation amount
      (var-set total-donated (+ amount (var-get total-donated)))

      ;; Log donation entry
      (var-set donation-log
        (unwrap! (as-max-len? (append (var-get donation-log)
          (tuple
            (donor tx-sender)
            (amount amount)
            (timestamp stacks-block-height)
            (message message))) u1000) (err u101)))

      (ok true))))

;; -------------------------------
;; Read-only: Get donor amount
;; -------------------------------
(define-read-only (get-donor-amount (who principal))
  (ok (get amount (default-to { amount: u0 } (map-get? donor-records {donor: who})))))

;; -------------------------------
;; Read-only: Get total donations
;; -------------------------------
(define-read-only (get-total-donated)
  (ok (var-get total-donated)))
