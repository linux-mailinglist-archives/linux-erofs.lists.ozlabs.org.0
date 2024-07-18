Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A01A93525F
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 22:22:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721334143;
	bh=vKVaTck8Tnf/dCPbkgm8FvBrYhuAEV3yvd36CSFR1OA=;
	h=Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=m8XiOrffCfN3VKk1x6v7WDei9dh7Fzpq62VXUQJRAcP2pF/U6/yMnGn63+T++P7Ip
	 H8LRpIYdjj5IDKuQJEYnsvpVp6HVo5Ea6Ht3j86qLq+0whzJD/9Hnk9x+eIYRehbs2
	 PoOYMsHalU+69b8NopF13YreF5Vm6GAyZF3snchrZFUx1PIGEvTWpbUDcUKVFbkZFr
	 QMPCx+HdlDX17Ltcttx6RIKkXa3urCLRfgUjKLGD0XegL8rdATOjdPYb8ObSzeVyYO
	 Pnp8MJ3gbhw5eMZADFlV/vGd2FLeNfXNE9yDXVfbGxpNE6Udlj1DoKp9SbIxuwG94G
	 TdZ3z4CN3jUHA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WQ43g6WTwz3fRw
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jul 2024 06:22:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=S3LphYDU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dhavale.bounces.google.com (client-ip=2607:f8b0:4864:20::b4a; helo=mail-yb1-xb4a.google.com; envelope-from=3c3mzzgckcwglpi3itmowwotm.kwutqv25-mzwn0tq010.w7tij0.wzo@flex--dhavale.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WQ43X63Z1z3dXH
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jul 2024 06:22:15 +1000 (AEST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-e05f08adcacso3021956276.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 13:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721334132; x=1721938932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKVaTck8Tnf/dCPbkgm8FvBrYhuAEV3yvd36CSFR1OA=;
        b=nbb+zCgrtCNsvWcd2xkReLICc6tUECMYvZneYwLeb4jVcO3CmK5o83a6vf8LDe6xd6
         UHFXcLBcmthGyjhd59v/noXimzPwBR7ZwQhG3F0moBZPhUQA3+1weuEItu5uG+30mU1u
         ZGp+RB4qm8ARP+4/sKGtfocBpfa4p/MbIev4Fd4c0WKLibi0XYMms6pDfuwJX+1k64YW
         J5JtHq41uAkyHqG1TTTt2fNntnYFmOdEWghiR9UVVm6dsXSdsIeYVjDuXNsCuwz0y7DP
         s7rNb+6IYXu3QM+KpIPC92nK7sBdVg3+x1gcITPB9hLkXD31k0d6hk8w7kNMmhYOgmIk
         ygLw==
X-Gm-Message-State: AOJu0Yzrl72YMcqVC8Hdnmq9++sG6DDtHchHRl38MTkWpd2pD2IOqV5o
	hfLH+hS75H9itjBw4Dk3t0rSJ1/5qQsHZOiJ8nHe56xswf28IMLz76kJvYn8tXUm3zJLZk/OK5W
	QrHLU+TSl36Ya7FdVTliHVHhCbltGHpLkBg/mr9mAiuwuYp+9VxaAqjwLQ4WW70e0eFcn3d+o0w
	TL9RWcaj8vh5pxaWaGoMBu2pXTBozbQHTXx/qeWuWTI4H1oA==
X-Google-Smtp-Source: AGHT+IF2SsMbafLfT2V0XU0sjf4tG9BC8OZOsCtChPEB27QunVTSredk1mCUoAn89HDNUt9RS2J7dEU5svOJ
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:e39:d7df:7805:881c])
 (user=dhavale job=sendgmr) by 2002:a05:6902:b17:b0:e03:2f90:e81d with SMTP id
 3f1490d57ef6-e05fedb1bc9mr31134276.11.1721334131972; Thu, 18 Jul 2024
 13:22:11 -0700 (PDT)
Date: Thu, 18 Jul 2024 13:22:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240718202204.1224620-1-dhavale@google.com>
Subject: [PATCH v1] erofs-utils: misc: Fix potential memory leak in realloc
 failure path
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As realloc returns NULL on failure, the original value will be
overwritten if it is used as lvalue. Fix this by using a temporary
variable to hold the return value and exit with -ENOMEM in case of
failure. This patch fixes 2 of the realloc blocks with similar fix.

Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fsck/main.c | 9 +++++++--
 lib/data.c  | 5 +++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 8ec9486..75950b6 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -508,8 +508,13 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 		if (compressed) {
 			if (map.m_llen > buffer_size) {
 				buffer_size = map.m_llen;
-				buffer = realloc(buffer, buffer_size);
-				BUG_ON(!buffer);
+				char *newbuffer = realloc(buffer, buffer_size);
+
+				if (!newbuffer) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				buffer = newbuffer;
 			}
 			ret = z_erofs_read_one_data(inode, &map, raw, buffer,
 						    0, map.m_llen, false);
diff --git a/lib/data.c b/lib/data.c
index a8402ed..0fc013e 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -338,11 +338,12 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 
 		if (map.m_plen > bufsize) {
 			bufsize = map.m_plen;
-			raw = realloc(raw, bufsize);
-			if (!raw) {
+			char *newraw = realloc(raw, bufsize);
+			if (!newraw) {
 				ret = -ENOMEM;
 				break;
 			}
+			raw = newraw;
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
-- 
2.45.2.1089.g2a221341d9-goog

