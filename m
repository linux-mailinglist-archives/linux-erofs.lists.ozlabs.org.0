Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BD42887DD72
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Mar 2024 15:41:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TyLK12NC1z3dDn
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Mar 2024 01:41:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TyLJw0w1Zz3cM5
	for <linux-erofs@lists.ozlabs.org>; Mon, 18 Mar 2024 01:41:18 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id BE0941008DC98
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 22:41:13 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 2D2A937C921
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Mar 2024 22:41:12 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/2] erofs-utils: mkfs: introduce inter-file multi-threaded compression
Date: Sun, 17 Mar 2024 22:41:10 +0800
Message-ID: <20240317144112.1445017-1-zhaoyifan@sjtu.edu.cn>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patchset introduces inter-file multi-threaded compression.

Yifan Zhao (2):
  erofs-utils: lib: split function logic in inode.c
  erofs-utils: mkfs: introduce inter-file multi-threaded compression

 include/erofs/compress.h |  16 ++
 include/erofs/internal.h |   3 +
 include/erofs/list.h     |   8 +
 include/erofs/queue.h    |  22 +++
 lib/Makefile.am          |   2 +-
 lib/compress.c           | 323 +++++++++++++++++++++++++--------------
 lib/inode.c              | 311 +++++++++++++++++++++++++++++++++----
 lib/queue.c              |  64 ++++++++
 8 files changed, 607 insertions(+), 142 deletions(-)
 create mode 100644 include/erofs/queue.h
 create mode 100644 lib/queue.c

-- 
2.44.0

