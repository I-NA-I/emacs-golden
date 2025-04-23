;;; golden.el --- A simple package manager           -*- lexical-binding: t; -*-

;; Copyright (C) 2025 Peter Kilian

;; Author: Peter Kilian
;; URL: https://github.com/I-NA-I/emacs-golden
;; Created: Apr 23, 2025
;; Keywords: tools, lisp
;; Package-Requires: ((emacs "27.1"))
;; Version: 0.0.1

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(defgroup golden nil
  "Dead simple package manager manipulation"
  :group 'applications)

(defcustom golden-enabled t
  "Whether the package is enabled."
  :type 'boolean
  :group 'golden)

(defvar golden--collecting nil
  "Non-nil when packages are being collected.")

(defvar golden--pending-packages nil
  "List of packages collected between `golden-init` and `golden-deinit`.")

(defvar golden-package-list nil
  "List of all registered packages.")

(defun golden-init ()
  "Start collection of packages."
  (interactive)
  (setq golden--collecting t)
  (setq golden--package-list nil))

(defmacro g-package (pkg)
  "Register a package while collecting."
  `(when golden--collecting
     (add-to-list 'golden--pending-packages ',pkg)))

(defun golden-deinit ()
  "Finish collecting and register packages."
  (interactive)
  (when golden--collecting
    (setq golden-package-list
	  (append golden--pending-packages golden-package-list))
    (setq golden--collecting nil)
    (message "Golden registered %d packages." (length golden--pending-packages))))

(defun golden-toggle ()
  "Toggle whether the package manager is enabled."
  (interactive)
  (setq golden-enabled (not golden-enabled))
  (message "Golden package manager is %s"
           (if golden-enabled "enabled" "disabled")))

(defun golden-load ()
  "Install all packages registered with Golden."
  (interactive))

(provide 'golden)
;;; golden.el ends here
