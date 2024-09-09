Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCD1971654
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 13:13:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2PMm5bk2z2yRG
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 21:13:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725880402;
	cv=none; b=O0JcADt5dKwr3S1saC3lapYSeL2GrDerwnNDvbc3KsgVshmdhKW63n/67OMRe04CquIBvzzGqf+xr4YtCtjSoYtX3VL6nYm5CQjoIRDm+AUp4Mtpno8eroHfWcSO5Wz4YY89BrJ42Gdw8mm1GqcTXeAnjYGMLFmNlZ7HxupUMG7L/Ep1SwufoUxA5DZrERHAHK4nfzdSQmnDpnwiDFBxu4i20nEJhIBXkprSQ5NnFL9y3hOT4y/CvuQtxew3KyE/i5v6i7rA5zX8mwS9Kkrj7jmV0Yrg+Gs65U25W/3YaldeTSXz4j9RuFcMWk9NE2mIy4I23Ohp1kYIQUV1vbaWiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725880402; c=relaxed/relaxed;
	bh=kYr49lRJp5sbEdwXCWTfGo8Q+UHdL6oIqNngXneo4FE=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=fs8P69fHnJ3rPKzzyjhBgL/dgPi5hyIRyOKHdmfu6ldvkph6g0NxSvu+6upI3AOK0LCQieeGB3B01SObjHh1rbCBR6OrK0/rwRlolTBowQm7NL6UscB5mydyey7j7ikpqmBOZQg+PaHZ0yonmRMVaphha+hXT4+kgu1tLCcRxfedMYZIQcXHdsMSYzLz1kiLC4ena+XY93sWXZ7sxOluT4wfox8oeWQaPcQHVtOqFB9RbVdCwPQf0H3V30QX3/kXe6Huou6O0Lxzy7U9npWVaxvVYW3EnRzWEJmjtWgUXumK/hZQxvgV8BaX15j2RYr55oJESTxLAkjB5WK+OAx7VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Aojd3XR0; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Aojd3XR0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2PMh3Jf8z2yN4
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 21:13:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725880394; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kYr49lRJp5sbEdwXCWTfGo8Q+UHdL6oIqNngXneo4FE=;
	b=Aojd3XR0Qfa2mcm67gp2NwEu3UjeFiOFB+8jxxxDfL7hQMNlFtVdDwcjrS+J1b2nUycLAIPn8+ktAWgKdVcHzVLPWorlyAaUm/iv1VF3F9yl8iDqzxE60EeFxN+jfhQOPwlXBFXvXp/XmNNsK9Or0IPw8WWrCGQim5xXXwu0cIg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEcfS4D_1725880389)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 19:13:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix inaccurate assertion of hardlinks in rebuild mode
Date: Mon,  9 Sep 2024 19:13:05 +0800
Message-ID: <20240909111305.1850391-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

`erofs_parent_inode(inode) == dir` is only true for non-hardlink
inodes and directories.

Only debug builds are impacted.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index d464bc6..bc3cb76 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1744,7 +1744,8 @@ static int erofs_mkfs_dump_tree(struct erofs_inode *root, bool rebuild,
 				continue;
 
 			if (!erofs_inode_visited(inode)) {
-				DBG_BUGON(rebuild &&
+				DBG_BUGON(rebuild && (inode->i_nlink == 1 ||
+					  S_ISDIR(inode->i_mode)) &&
 					  erofs_parent_inode(inode) != dir);
 				erofs_mark_parent_inode(inode, dir);
 
-- 
2.43.5

