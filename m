Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FA5A3222C
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 10:31:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtCjt2QzKz3bTf
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 20:31:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739352673;
	cv=none; b=ZHr3H+/tVuB2z9gR26q82sTg8umvAfOeWiEGmRD1+sZ1CahB/OX3ZfGuMjpO5XbJPEYn+eSN5p7I+ndLY+R0ei1ywkIKyqe51ksax8cLzusTR41HnM2nprqI5Pqnaah4946raMcgK4XJfNvNXd1+EQ6H0APhjoMv8Ya3J7PXhVabh1nWQpTYMM4+UoVQ5FiRvifU3WYm1eFRO95jD1D1xCP5sEwn1K6OjBYxIcN5iI2aQUWFmTFyKnCXJS/z69RXoLc3UgCyhy39KKEeDu8vyB7P+DOSZ/vcN/MTE89u2T52Xy6PwEJxJQaWRa8ldpKfjLda6eep5Kk9+INQGHA3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739352673; c=relaxed/relaxed;
	bh=E8WMrc8CQSyxiS+r52TioZQT/liBI0SbkCd2WU6UocE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXb/nHz2sm7FEOyOGuv3U7q85vIKHCWdJWrKumY5nHCvOuIoqc7IaKZKM5FWkNn5q4MNnUzAU1G0T95mE8b49FQz5Ezy9C33tbqJ36BQeuU9Jyfwb1lC5PDIjYsaNDjui8tAnzQRBd1CtVybY4r5tqPpJ4EEuuQAtq0oyTG68zGV0+3OVt6OhiaMGIImJsiFEjEfBkJrTq46WKpxZwZJDjogmUbS23+nvXdPdzqFRztFCgi4Dpi3S1ylWYgSTr+dc1/t87hkYK7wSTl+/RMGUCiNoa9WdDtTaAQSoBJjpZxvaoeeSu5aNC2uBSiREi+kPyham/SXJ8cww8arlkY0dQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bBtKQYAy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=bBtKQYAy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtCjn66LCz2x9M
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 20:31:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739352664; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=E8WMrc8CQSyxiS+r52TioZQT/liBI0SbkCd2WU6UocE=;
	b=bBtKQYAy0XnMiZEUTWVJTmITSWXjw6Ss2tF+QLrFxALSAbVwryHu+/Bj4J39aUTyK2xD/B8z5fw+V0QpU361ncdkwX0jurjAC8N2y5VeLnqoH8LqWxeJiT8NH97I3s1c4CXqnR0NBepsPDwiWeUo64eq69NPXLXklBtM/olh8AI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WPJidS-_1739352658 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 17:31:02 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] fs/erofs: fix an integer overflow in symlink resolution
Date: Wed, 12 Feb 2025 17:30:57 +0800
Message-ID: <20250212093057.3975104-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org, Jonathan Bar Or <jonathanbaror@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

See the original report [1], otherwise len + 1 will be overflowed.

Note that EROFS archive can record arbitary symlink sizes in principle,
so we don't assume a short number like 4096.

[1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
Fixes: 830613f8f5bb ("fs/erofs: add erofs filesystem support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
index 7bd2e8fcfc..64a6c8cad8 100644
--- a/fs/erofs/fs.c
+++ b/fs/erofs/fs.c
@@ -63,6 +63,9 @@ static int erofs_readlink(struct erofs_inode *vi)
 	char *target;
 	int err;
 
+	if (len >= SIZE_MAX)
+		return -EFSCORRUPTED;
+
 	target = malloc(len + 1);
 	if (!target)
 		return -ENOMEM;
-- 
2.43.5

