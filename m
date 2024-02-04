Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC41848CDD
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 11:33:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TSQpc36CLz3bsd
	for <lists+linux-erofs@lfdr.de>; Sun,  4 Feb 2024 21:33:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TSQpS3pgmz30PH
	for <linux-erofs@lists.ozlabs.org>; Sun,  4 Feb 2024 21:33:34 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 08F8B1008880A;
	Sun,  4 Feb 2024 18:33:22 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 87312381F2D;
	Sun,  4 Feb 2024 18:33:16 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/7] erofs-utils: mkfs: introduce multi-threaded compression
Date: Sun,  4 Feb 2024 18:33:10 +0800
Message-ID: <20240204103310.141249-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: hsiangkao@linux.alibaba.com, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, xin_tong@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

Currently, mkfs.erofs is single-threaded and the time-consuming process
of creating EROFS images has emerged as a critical factor. Let's introduce
multi-threaded compression to speed up the process. This patchset is based
on the previous work of Gao Xiang and the multi-threading framework has
been introduced in the first two patches. The following patches introduce
inner-file and inter-file multi-threaded compression.

The inner-file multi-threaded compression is implemented by dividing the
input file into multiple segments and compressing them in parallel.

The inter-file multi-threaded compression is implemented by compressing
multiple files in parallel, and we let the main thread reaps the compressed
files and writes them to the output image to ensure the reproducibility of
the output image.

This patchset is only a basic implementation without support for dedupe,
(all-)fragments and ztailpacking features. We will add support for them
in the future.

The performance of the multi-threaded compression is tested on a Dell r740
server with 2 Intel Xeon Gold 5215M CPUs (10 cores per CPU). We test the
compression time of serveral workloads with lzma algorithm. The results are
as follows:

workload: enwik9 (1GB)

| # of threads | Time (s) | Speedup |
|--------------|----------|---------|
| 1            |  216.08  | 1.00x   |
| 2            |  110.15  | 1.96x   |
| 4            |  57.22   | 3.78x   |
| 8            |  31.4    | 6.88x   |
| 16           |  16.99   | 12.72x  |

workload: Linux-6.7-rc4 source (1.55GB)

| # of threads | Time (s) | Speedup |
|--------------|----------|---------|
| 1            |  288.65  | 1.00x   |
| 2            |  140.66  | 2.05x   |
| 4            |  79.64   | 3.62x   |
| 8            |  54.74   | 5.27x   |
| 16           |  47.08   | 6.13x   |

workload: Arch container with Xfce desktop (4.19GB)

| # of threads | Time (s) | Speedup |
|--------------|----------|---------|
| 1            |  834.26  | 1.00x   |
| 2            |  430.73  | 1.94x   |
| 4            |  267.96  | 3.11x   |
| 8            |  205.67  | 4.06x   |
| 16           |  183.26  | 4.55x   |

Gao Xiang (2):
  erofs-utils: introduce multi-threading framework
  erofs-utils: add a helper to get available processors

Yifan Zhao (5):
  erofs-utils: mkfs: add --worker=# parameter
  erofs-utils: mkfs: optionally print warning in erofs_compressor_init
  erofs-utils: extend multi-threading framework for per-thread fields
  erofs-utils: mkfs: introduce inner-file multi-threaded compression
  erofs-utils: mkfs: introduce inter-file multi-threaded compression

 configure.ac                |  17 +
 include/erofs/compress.h    |  18 +
 include/erofs/config.h      |   5 +
 include/erofs/internal.h    |   6 +
 include/erofs/list.h        |   8 +
 include/erofs/queue.h       |  22 +
 include/erofs/workqueue.h   |  48 +++
 lib/Makefile.am             |   4 +
 lib/compress.c              | 819 +++++++++++++++++++++++++++++-------
 lib/compressor.c            |   7 +-
 lib/compressor.h            |   5 +-
 lib/compressor_deflate.c    |  10 +-
 lib/compressor_libdeflate.c |   6 +-
 lib/compressor_liblzma.c    |   9 +-
 lib/compressor_lz4.c        |   2 +-
 lib/compressor_lz4hc.c      |   2 +-
 lib/config.c                |  16 +
 lib/inode.c                 | 346 ++++++++++++---
 lib/queue.c                 |  64 +++
 lib/workqueue.c             | 222 ++++++++++
 mkfs/main.c                 |  38 ++
 21 files changed, 1442 insertions(+), 232 deletions(-)
 create mode 100644 include/erofs/queue.h
 create mode 100644 include/erofs/workqueue.h
 create mode 100644 lib/queue.c
 create mode 100644 lib/workqueue.c

-- 
2.43.0

