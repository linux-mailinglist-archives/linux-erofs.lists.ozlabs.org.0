Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46488592B
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 13:34:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4V0lKC5ljbz3dSn
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Mar 2024 23:34:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.232; helo=smtp232.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp232.sjtu.edu.cn (smtp232.sjtu.edu.cn [202.120.2.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4V0lK551Pkz2xTN
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 23:34:47 +1100 (AEDT)
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
	by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 5694E1008DC82
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 20:34:38 +0800 (CST)
Received: from zhaoyf.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
	by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 9959337C955
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Mar 2024 20:34:36 +0800 (CST)
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/2] erofs-utils: mkfs: introduce inter-file multi-threaded compression
Date: Thu, 21 Mar 2024 20:34:34 +0800
Message-ID: <20240321123436.2663318-1-zhaoyifan@sjtu.edu.cn>
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

changelog since v1:
- apply fixes from Jianan's review
- remove misincluded changes in list.h 

Yifan Zhao (2):
  erofs-utils: lib: split function logic in inode.c
  erofs-utils: mkfs: introduce inter-file multi-threaded compression

 include/erofs/compress.h |  16 ++
 include/erofs/internal.h |   3 +
 include/erofs/queue.h    |  22 +++
 lib/Makefile.am          |   2 +-
 lib/compress.c           | 336 +++++++++++++++++++++++++-------------
 lib/inode.c              | 341 ++++++++++++++++++++++++++++++++-------
 lib/queue.c              |  64 ++++++++
 7 files changed, 605 insertions(+), 179 deletions(-)
 create mode 100644 include/erofs/queue.h
 create mode 100644 lib/queue.c

-- 
2.44.0

