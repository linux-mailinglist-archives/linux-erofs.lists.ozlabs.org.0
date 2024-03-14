Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ADB87BCEC
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Mar 2024 13:38:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TwRkG1gDHz3dH8
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Mar 2024 23:38:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TwRk90w3Nz2xSl
	for <linux-erofs@lists.ozlabs.org>; Thu, 14 Mar 2024 23:38:06 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 8C53C1008DC80;
	Thu, 14 Mar 2024 20:37:58 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 97624380D7D;
	Thu, 14 Mar 2024 20:37:54 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH v6 0/5] erofs-utils: mkfs: introduce multi-threaded compression
Date: Thu, 14 Mar 2024 20:37:49 +0800
Message-ID: <20240314123754.1548878-1-zhaoyifan@sjtu.edu.cn>
X-Mailer: git-send-email 2.44.0
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
Cc: zhaoyifan@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

changelog since v5:
- use memory buffer instead of tmpfile to store intermediate compressed data
- re-strucutre the 5th patch

Gao Xiang (2):
  erofs-utils: add a helper to get available processors
  erofs-utils: lib: introduce atomic operations

Yifan Zhao (3):
  erofs-utils: introduce multi-threading framework
  erofs-utils: mkfs: add --worker=# parameter
  erofs-utils: mkfs: introduce inner-file multi-threaded compression

 configure.ac                |  17 ++
 include/erofs/atomic.h      |  28 ++
 include/erofs/compress.h    |   3 +-
 include/erofs/config.h      |   5 +
 include/erofs/internal.h    |   3 +
 include/erofs/workqueue.h   |  35 +++
 lib/Makefile.am             |   4 +
 lib/compress.c              | 551 +++++++++++++++++++++++++++++-------
 lib/compressor.c            |   2 +
 lib/compressor_deflate.c    |  11 +-
 lib/compressor_libdeflate.c |   6 +-
 lib/compressor_liblzma.c    |   5 +-
 lib/config.c                |  16 ++
 lib/workqueue.c             | 129 +++++++++
 mkfs/main.c                 |  37 +++
 15 files changed, 750 insertions(+), 102 deletions(-)
 create mode 100644 include/erofs/atomic.h
 create mode 100644 include/erofs/workqueue.h
 create mode 100644 lib/workqueue.c

-- 
2.44.0

