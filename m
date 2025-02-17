Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764ABA379E7
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 03:49:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx6ZG6TRbz305X
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 13:49:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739760581;
	cv=none; b=WVIOxiOag5aAm3QeFfiHDgFzMGu7edkZV0T1EzJqDcXNzBDAU52iGVLTz2utl2UusWLas+08ok2MMoK6SoxJDwwSDIhslVxqcN6A/UXq2BTykvLdxqjPh7Y03bhD664l5rJfFF+kls///O7c82ApN20bY/cEEhATi142c4YAsIwVUp4SDIQQX0QwqVONp4qcRZ5cQoxYd8YqVHEKuyuvjBuY+U4hKlt2YZlFyw/olxbGVYNkAJG70KqH9+vFswfFKN4/X7diCQfJxY1CWf3Bq1bipIQBWTXaZAvnaMTZvu78zX+mYXMhKuHvZi7lQK+qiSGvqk8q2EQy09k8+NNFVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739760581; c=relaxed/relaxed;
	bh=95nivfKSdK00TJfYQLKs17yh9hFl6ZV9nWt9WdLKh1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ka0L7RF+9dIQCUmZuvX/mlnZj/s8+NNlX0Lu67fsHt+EtT5/YgwrLCiuc5+28zEUKH+AVZ3OoNxQr+k/oKNb084XiFk19hFASwU7GTJBQERKBNb3+e5OH/AoVUi5XYMdB+SmowIeF0HZr8G0abOdU8A4eIdEr1Vl7nVcojnxe4w/YWyUhtWLZQ0MeqWF3w1TKFG9CBnQuK1eas3P7d8jb0j9EDRAiYfBM+tZ9BmcuCOV5jAbadIKTukMRp80C8d1WAagWoWxZFQUpc0YQRnP1ZWHYUWFdJNY2dzgcymdZtTPpWxXEBIviYMXC+FAaDtghKaM8GVm+Cg/R0pIRjhZ5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZmBPLnXb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ZmBPLnXb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yx6ZC6wNmz2yy9
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 13:49:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739760575; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=95nivfKSdK00TJfYQLKs17yh9hFl6ZV9nWt9WdLKh1I=;
	b=ZmBPLnXbFPp6LnrxT9tx6mXlgRGPtn8cnDG6ABwP63fwfx7uC+MSQziV51NLS/m7M7s67+qCAUb9l0X2vlzvn4r79EFcg5Yae9cA/xXgrpK1QfkmAPc+NYed1TxXQMMDhwrGhZZiqsm3HvtYhzfS2s4byuwTOZ+rias8OBoV6+Y=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPYAONI_1739760570 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 10:49:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fix potential buffer overrun in __erofs_io_write()
Date: Mon, 17 Feb 2025 10:49:28 +0800
Message-ID: <20250217024929.66658-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

.. due to short write, but it's almost impossible for most fses.

Coverity-id: 541575
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index b6eb22a..5c3d263 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -31,7 +31,7 @@ ssize_t __erofs_io_write(int fd, const void *buf, size_t len)
 	ssize_t ret, written = 0;
 
 	do {
-		ret = write(fd, buf, len);
+		ret = write(fd, buf, len - written);
 		if (ret <= 0) {
 			if (!ret)
 				break;
-- 
2.43.5

