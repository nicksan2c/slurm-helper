;;; slurm-mode.el --- Show SBATCH options in special font
;;--------------------------------------------------------------------
;;
;; Copyright (C) 2012, Damien François <damien.francois@uclouvain.be>
;;
;; This file is NOT part of Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA
;;
;; To use, save slurm-mode.el to a directory in your load-path.
;;
;; (require 'slurm-mode)
;; (add-hook 'sh-mode-hook 'turn-on-slurm-mode)
;;
;; Derived from fic-mode.el by Trey Jackson

(defcustom slurm-foreground-color "Blue"
  "Font foreground colour"
  :group 'slurm-mode)

(defcustom font-lock-slurm-face 'font-lock-slurm-face
  "variable storing the face for slurm mode"
  :group 'slurm-mode)

(make-face 'font-lock-slurm-face)
(modify-face 'font-lock-slurm-face slurm-foreground-color
             nil nil nil nil nil nil nil)

(defvar slurm-search-list-re "SBATCH --\\(constraint\\|account\\|acctg-freq\\|extra-node-info\\|socket-per-node\\|cores-per-socket\\|threads-per-core\\|begin\\|checkpoint\\|checkpoint-dir\\|comment\\|constraint\\|contiguous\\|cpu-bind\\|cpus-per-task\\|dependency\\|workdir\\|error\\|exclusive\\|nodefile\\|get-user-env\\|get-user-env\\|gid\\|hint\\|immediate\\|input\\|job-name\\|job-id\\|no-kill\\|licences\\|distribution\\|mail-user\\|mail-type\\|mem\\|mem-per-cpu\\|mem-bind\\|mincores\\|mincpus\\|minsockets\\|minthreads\\|nodes\\|ntasks\\|network\\|nice\\|nice\\|no-requeue\\|ntasks-per-core\\|ntasks-per-socket\\|ntasls-per-node\\|overcommit\\|output\\|open-mode\\|partition\\|propagate\\|propagate\\|quiet\\|requeue\\|reservation\\|share\\|signal\\|time\\|tasks-per-node\\|tmp\\|uid\\|nodelist\\|wckey\\|wrap\\|exclude\\).*$")


(defun slurm-in-doc/comment-region (pos)
  (memq (get-char-property pos 'face)
	(list font-lock-comment-face)))

(defun slurm-search-for-keyword (limit)
  (let ((match-data-to-set nil)
	found)
    (save-match-data
      (while (and (null match-data-to-set)
		  (re-search-forward slurm-search-list-re limit t))
	(if (and (slurm-in-doc/comment-region (match-beginning 0))
		 (slurm-in-doc/comment-region (match-end 0))) 
	    (setq match-data-to-set (match-data)))))
    (when match-data-to-set
      (set-match-data match-data-to-set)
      (goto-char (match-end 0)) 
      t)))

;;;###autoload
(define-minor-mode slurm-mode "highlight FIXMEs in comments and strings (as well as TODO BUG and KLUDGE"
  :lighter " FIC" :group 'slurm-mode
  (let ((kwlist '((slurm-search-for-keyword (0 'font-lock-slurm-face t)))))
    (if slurm-mode
        (font-lock-add-keywords nil kwlist)
      (font-lock-remove-keywords nil kwlist))))

(defun turn-on-slurm-mode ()
  "turn slurm-mode on"
  (interactive)
  (slurm-mode 1))

(provide 'slurm-mode)
