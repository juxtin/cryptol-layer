;;; packages.el --- cryptol layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Justin Holguin <justin.h.holguin@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst cryptol-packages
  '(cryptol-mode))

(defun cryptol/init-cryptol-mode ()
  (use-package cryptol-mode
    :defer t
    :config
    (progn
      (defun cryptol-eval-string (str)
        (interactive)
        (let ((fname ".cryptol-mode_repl_eval_temp.cry"))
          (with-temp-file fname
            (insert str))
          (comint-send-string cryptol-repl-process (concat ":l " fname "\n"))))

      (defun cryptol-v2-type-at-point ()
        (interactive)
        (let* ((sym (thing-at-point 'symbol))
               (type-query (concat ":t " sym "\n")))
          (cryptol-eval-buffer)
          (comint-send-string cryptol-repl-process type-query)))

      (defun cryptol-eval-buffer ()
        (interactive)
        (cryptol-eval-string (buffer-string)))

      (spacemacs/set-leader-keys-for-major-mode 'cryptol-mode
        "sb" 'cryptol-repl
        "sr" 'cryptol-eval-buffer
        "st" 'cryptol-v2-type-at-point))))
