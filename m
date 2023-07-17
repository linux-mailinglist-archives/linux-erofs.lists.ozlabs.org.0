Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E9755D0F
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jul 2023 09:36:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4DQl0xl3z2yGl
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Jul 2023 17:35:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4DQd6fq8z2yFF
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Jul 2023 17:35:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VnXfYEB_1689579334;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnXfYEB_1689579334)
          by smtp.aliyun-inc.com;
          Mon, 17 Jul 2023 15:35:41 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: support GNUTYPE_LONGNAME for tarerofs
Date: Mon, 17 Jul 2023 15:35:31 +0800
Message-Id: <20230717073531.43203-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The 'L' entry is present in a header for a series of 1 or more 512-byte
tar blocks that hold just the filename for a file or directory with a
name over 100 chars.

Following that series is another header block, in the traditional form:
   A header with type '0' (regular file) or '5' (directory), followed by
   the appropriate number of data blocks with the entry data.

In the header for this series, the name will be truncated to the 1st 100
characters of the actual name.

Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 8edfe75..b62e562 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -570,6 +570,14 @@ restart:
 		if (ret)
 			goto out;
 		goto restart;
+	} else if (th.typeflag == 'L') {
+		free(eh.path);
+		eh.path = malloc(st.st_size + 1);
+		if (st.st_size != erofs_read_from_fd(tar->fd, eh.path,
+						     st.st_size))
+			goto invalid_tar;
+		eh.path[st.st_size] = '\0';
+		goto restart;
 	} else if (th.typeflag == 'K') {
 		free(eh.link);
 		eh.link = malloc(st.st_size + 1);
-- 
2.24.4

