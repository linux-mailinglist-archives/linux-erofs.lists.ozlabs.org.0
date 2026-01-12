Return-Path: <linux-erofs+bounces-1829-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D83D13E5D
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jan 2026 17:09:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqclD497dz2xHP;
	Tue, 13 Jan 2026 03:09:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.68
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768234168;
	cv=none; b=Htp2pXomQMivu2Ta9MtHiNTtBbytobWqzKOKyd3m/Umrm322gbwWsan/SUDmIz8yGNeRCdZD+agLbj+MrLWeZ0ursE2Xr9LMoyC9Z8zWfOHJviwbxuwAVypuekYu4X5hAKlzJhCEWvHLp29kqgE9WW/QKLwz0YEM/ynrbOj6IW1JwMRin3EgTmf00Dzqh8eWeugVTsZIoxLOMis63hZ3b3kKg9d/2BH+mqyAQurSyQT+biM/saN8/n2SwOwDOOuXTu0rMLsO0/QXRTrB9iHWEYQKAYkDXXrXg6iL2Vy1raGSdjInNPF6xrMoM3ic2zUE0PonxK8g5rUjZ5EHbxefMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768234168; c=relaxed/relaxed;
	bh=rhL4JNvGH/Ad37oTzLQ5PqwjNlackbvAhbcxlZaqeQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+CCcC77hxs5i0iqpupjpiObA4zBRHlB3HfZ1ZfHlan1Rj4FkcKu7w5wS0Wt+6pJqLnYGl7EigqEIPE1+XAh3JEMIc1igmXkmor03eBkcAIDkbN1w6LFAP82JgyPH2W1CWSeq14+xGBEOrqKNP8G84h73et4MsH4iecIPM7N0Ukc7cqJe66L3XahUGbGKf2w8PNgR6tbcDq3Smir53h6AksaIKu51XAoFpVeqT4VhJKxo6dlNsvYkDKa2d1a9VD+mzpoQKa9Qhl2JQVziCZRwRZT/EUQkRvZ8LPyJ42mreOjlnn45pUjTrCEB+wlMVpOHKluyYEfCwsII5BRqAdLOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dhTEptxr; dkim-atps=neutral; spf=pass (client-ip=209.85.208.68; helo=mail-ed1-f68.google.com; envelope-from=officialnaumansabir@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dhTEptxr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.68; helo=mail-ed1-f68.google.com; envelope-from=officialnaumansabir@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqclB2wNjz2xFn
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 03:09:25 +1100 (AEDT)
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b560e425eso9313661a12.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jan 2026 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768234102; x=1768838902; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhL4JNvGH/Ad37oTzLQ5PqwjNlackbvAhbcxlZaqeQI=;
        b=dhTEptxrYiSViOMn3OI/iWUKDBuC6hyMBE/EHtpHg92s9PcMOFj/45vPg0aotdqnJc
         nhvwi1CVXFKCKUuTceXVlPQjxo96mc0QUt5TqAi1XDPxyhW6bRArKHsWzODf06SzE1vV
         ygDyiyvPL86BrlDaxA/MWBrmX/qtcjH6go3zA2S/mPiK1jeTt4TJciK/4FagxDH+Auxh
         QIe8A4/dda4kjSLxRX1sb+fHbUI5HP9Kf8pHAITplTiaAhuPoHyBNxF55nfkz+rCMqe5
         KJtOkAuxpjWKxhiqQHojtWaiWi5EZ8g3Cr2BC3+HkAt/enlajAFc/8OAUumY5Nk5m/RK
         cPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768234102; x=1768838902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhL4JNvGH/Ad37oTzLQ5PqwjNlackbvAhbcxlZaqeQI=;
        b=KZ0r5RbTtx4o/W4IzJWEmiNkf8x0tegtPvSaJTZ9oAlu5UEeLc4o9bcXkhiSXaz1ah
         7okzGODCkUIO6PEJHI7xtwGnVhxVF9lCmtzM5WvZ/peGlOu1V8m1lb8PHfy7+zLu8ftI
         r70jCFmM67l9auRwC0UZGHup7U6N6UU7yVuNR0Vm4vQB5z13dlrFa5oeuY42lzOFMqGr
         QefHfT0rHuoxx5wMQkBZgaZyMuX1iX49xXVYMu9LkqkXo4HYyYT5nP0MRj/6s6dpFll6
         RheuGseVbNJuA6ZuGTWwQEBwSJAU04lY4iGMicdqvf+na+oY2iApW5BmZuHM2FSZw0is
         F1AA==
X-Forwarded-Encrypted: i=1; AJvYcCWNetnF6AgUMj91wmIqh2XldsV3y1RwH34QEEj06Bt/Tw8lfWvquMIK72m2ht69KAJB8Oj7feDnYtLDuw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7U89PNfN44YD5GQAK7xkjaXSRw90gZiZCpTQE8uSLNotfs7Z0
	DPsH/7nC7FPatgfQxkokt1gN2P/fx9hkxfQ44mlHOx8xdP79SluT6Gvz
X-Gm-Gg: AY/fxX5iKdWJNlFej1x4dBsTL1b2XAjdwSFP2kbgME1WVjdvuRTdbwfcLj8xlXWbsYL
	9elSSqTJ3phs+DpWQMxnlAj9nFOL01U0aBkb8j9h60SMJY/LFIsykiFxsAldn+OQX2bnpGKlmvA
	GlEeF0FkU4VRT5EWR+tqwNaM+u4Um3gyDjn4IIG09og1R868i0zfES8ykVRzZ8RotJxhVCwW6F5
	T7czJ1GohLvkZthg+sNlohFeenqf3/L+EYqcDXZuLREVYqr7YhZPjeURLUypaHsArMRqDyM+qb7
	XKZUuxBgyF6YK4VDWUZ9ztcHGS7bu5+z7nrQU3PoK4kpG00Fg7XRFJX661E4/zk4NUfOIz3Moc2
	EnAzOVPhQOYkBCoIPQR5aqMMes7LSD5dr4E8OCaXKXwSKNpmN4dDBbvwLISAZEKhSzN6qOCc35I
	gLSwBL7YgBR6EVT/6gFMR+6pqcRDBVgQrvKA3cImIySOg=
X-Google-Smtp-Source: AGHT+IFazFrD0ua/D+OyOxZV/TILTiOYzJ/3DUB89wm9e5Xuy/h95OK98M827+C0BmLeSL4ZrMLPsQ==
X-Received: by 2002:a17:907:1b1d:b0:b73:6c97:af4b with SMTP id a640c23a62f3a-b84453eb56amr1811673766b.45.1768234101567;
        Mon, 12 Jan 2026 08:08:21 -0800 (PST)
Received: from MacBookPro ([2a02:8071:2186:3703:6de9:eb98:99c8:7af2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4c15sm17955883a12.4.2026.01.12.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:08:21 -0800 (PST)
From: Nauman Sabir <officialnaumansabir@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	linux-kbuild@vger.kernel.org,
	Nauman Sabir <officialnaumansabir@gmail.com>
Subject: [PATCH v3 3/3] Documentation: Fix typos and grammatical errors
Date: Mon, 12 Jan 2026 17:08:20 +0100
Message-ID: <20260112160820.19075-1-officialnaumansabir@gmail.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Fix various typos and grammatical errors across documentation files:

- Fix missing preposition 'in' in process/changes.rst
- Correct 'result by' to 'result from' in admin-guide/README.rst
- Fix 'before hand' to 'beforehand' in cgroup-v1/hugetlb.rst
- Correct 'allows to limit' to 'allows limiting' in hugetlb.rst,
  cgroup-v2.rst, and kconfig-language.rst
- Fix 'needs precisely know' to 'needs to precisely know'
- Correct 'overcommited' to 'overcommitted' in hugetlb.rst
- Fix subject-verb agreement: 'never causes' to 'never cause'
- Fix 'there is enough' to 'there are enough' in hugetlb.rst
- Fix 'metadatas' to 'metadata' in filesystems/erofs.rst
- Fix 'hardwares' to 'hardware' in scsi/ChangeLog.sym53c8xx

Signed-off-by: Nauman Sabir <officialnaumansabir@gmail.com>
---
 Documentation/admin-guide/README.rst           |  2 +-
 .../admin-guide/cgroup-v1/hugetlb.rst          | 18 +++++++++---------
 Documentation/admin-guide/cgroup-v2.rst        |  2 +-
 Documentation/filesystems/erofs.rst            |  2 +-
 Documentation/kbuild/kconfig-language.rst      |  2 +-
 Documentation/process/changes.rst              |  2 +-
 Documentation/scsi/ChangeLog.sym53c8xx         |  2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index 05301f03b717..77fec1de6dc8 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -53,7 +53,7 @@ Documentation
    these typically contain kernel-specific installation notes for some
    drivers for example. Please read the
    :ref:`Documentation/process/changes.rst <changes>` file, as it
-   contains information about the problems, which may result by upgrading
+   contains information about the problems which may result from upgrading
    your kernel.
 
 Installing the kernel source
diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
index 493a8e386700..b5f3873b7d3a 100644
--- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
+++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
@@ -77,7 +77,7 @@ control group and enforces the limit during page fault. Since HugeTLB
 doesn't support page reclaim, enforcing the limit at page fault time implies
 that, the application will get SIGBUS signal if it tries to fault in HugeTLB
 pages beyond its limit. Therefore the application needs to know exactly how many
-HugeTLB pages it uses before hand, and the sysadmin needs to make sure that
+HugeTLB pages it uses beforehand, and the sysadmin needs to make sure that
 there are enough available on the machine for all the users to avoid processes
 getting SIGBUS.
 
@@ -91,23 +91,23 @@ getting SIGBUS.
   hugetlb.<hugepagesize>.rsvd.usage_in_bytes
   hugetlb.<hugepagesize>.rsvd.failcnt
 
-The HugeTLB controller allows to limit the HugeTLB reservations per control
+The HugeTLB controller allows limiting the HugeTLB reservations per control
 group and enforces the controller limit at reservation time and at the fault of
 HugeTLB memory for which no reservation exists. Since reservation limits are
-enforced at reservation time (on mmap or shget), reservation limits never causes
-the application to get SIGBUS signal if the memory was reserved before hand. For
+enforced at reservation time (on mmap or shget), reservation limits never cause
+the application to get SIGBUS signal if the memory was reserved beforehand. For
 MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
 limit, enforcing memory usage at fault time and causing the application to
 receive a SIGBUS if it's crossing its limit.
 
 Reservation limits are superior to page fault limits described above, since
 reservation limits are enforced at reservation time (on mmap or shget), and
-never causes the application to get SIGBUS signal if the memory was reserved
-before hand. This allows for easier fallback to alternatives such as
+never cause the application to get SIGBUS signal if the memory was reserved
+beforehand. This allows for easier fallback to alternatives such as
 non-HugeTLB memory for example. In the case of page fault accounting, it's very
-hard to avoid processes getting SIGBUS since the sysadmin needs precisely know
-the HugeTLB usage of all the tasks in the system and make sure there is enough
-pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommited
+hard to avoid processes getting SIGBUS since the sysadmin needs to precisely know
+the HugeTLB usage of all the tasks in the system and make sure there are enough
+pages to satisfy all requests. Avoiding tasks getting SIGBUS on overcommitted
 systems is practically impossible with page fault accounting.
 
 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..098d6831b3c0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2816,7 +2816,7 @@ DMEM Interface Files
 HugeTLB
 -------
 
-The HugeTLB controller allows to limit the HugeTLB usage per control group and
+The HugeTLB controller allows limiting the HugeTLB usage per control group and
 enforces the controller limit during page fault.
 
 HugeTLB Interface Files
diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index 08194f194b94..e61db115e762 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -154,7 +154,7 @@ to be as simple as possible::
   0 +1K
 
 All data areas should be aligned with the block size, but metadata areas
-may not. All metadatas can be now observed in two different spaces (views):
+may not. All metadata can be now observed in two different spaces (views):
 
  1. Inode metadata space
 
diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index abce88f15d7c..7067ec3f0011 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -216,7 +216,7 @@ applicable everywhere (see syntax).
 
 - numerical ranges: "range" <symbol> <symbol> ["if" <expr>]
 
-  This allows to limit the range of possible input values for int
+  This allows limiting the range of possible input values for int
   and hex symbols. The user can only input a value which is larger than
   or equal to the first symbol and smaller than or equal to the second
   symbol.
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 62951cdb13ad..0cf97dbab29d 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -218,7 +218,7 @@ DevFS has been obsoleted in favour of udev
 Linux documentation for functions is transitioning to inline
 documentation via specially-formatted comments near their
 definitions in the source.  These comments can be combined with ReST
-files the Documentation/ directory to make enriched documentation, which can
+files in the Documentation/ directory to make enriched documentation, which can
 then be converted to PostScript, HTML, LaTex, ePUB and PDF files.
 In order to convert from ReST format to a format of your choice, you'll need
 Sphinx.
diff --git a/Documentation/scsi/ChangeLog.sym53c8xx b/Documentation/scsi/ChangeLog.sym53c8xx
index 3435227a2bed..6bca91e03945 100644
--- a/Documentation/scsi/ChangeLog.sym53c8xx
+++ b/Documentation/scsi/ChangeLog.sym53c8xx
@@ -3,7 +3,7 @@ Sat May 12 12:00 2001 Gerard Roudier (groudier@club-internet.fr)
 	- Ensure LEDC bit in GPCNTL is cleared when reading the NVRAM.
 	  Fix sent by Stig Telfer <stig@api-networks.com>.
 	- Backport from SYM-2 the work-around that allows to support 
-	  hardwares that fail PCI parity checking.
+	  hardware that fails PCI parity checking.
 	- Check that we received at least 8 bytes of INQUIRY response 
 	  for byte 7, that contains device capabilities, to be valid.
 	- Define scsi_set_pci_device() as nil for kernel < 2.4.4.
-- 
2.52.0


