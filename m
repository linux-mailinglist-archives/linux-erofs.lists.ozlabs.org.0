Return-Path: <linux-erofs+bounces-1422-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B92C79A07
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Nov 2025 14:47:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCc2x0mXrz302l;
	Sat, 22 Nov 2025 00:47:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763732825;
	cv=none; b=dSkx92K68YYbuN0HA5ThV/FTlVhzTgiDPKsvjsx8dP0fP76W2wMvsSPuC2KMJtpwNEitJ/FBx9nWloLXdJDILzKDd20b40GpC36Me3fgqIiwcSOjcFpYKUoGm4n5d013mJmsNhsgS7YChPkmzT4m6afXRtD3puXlDMfvCqATTy726yyAppIX/KV86XO/X0u//9PwUsfdnJwvAeMXxlv4t9KhVdsagHkuw6BICAY37/K81aKrmKi+YBedkbrNpNsrX5yY3Cfinyh3TQzgElS9ofisAzz8hJZPOz2mmBgCe0/3R2cflblC9WS0ehXHJQP2g3ZeB/izsIJleq6bdIBvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763732825; c=relaxed/relaxed;
	bh=VKBiilkgZg/0HYkeoJzPUZ4zUqJFiuQQlGJ8QWzSh0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4AfW1O4PCRfdNY+cVC1DDMrKumzKj5leKUN68TFA6DOq+E2DoCcRBsHfOoIxX/9gclElOsU/rc/8FL7qW3tpn107A0PMYS73lr+9dxo6C7EwQEj97i8U5fD24urnFrAOIejjhkXTRHcjB8YKS7FWHX/U4PSsevRAc+vCyjdx7BD8RBfNVSd4eE5hmOpI67CR0O1U1gKMNJkRFEMeh0mOSXu82aqP1UW82MSTs94u7zmbl/Rdn8NWgJ1uCok1N3oJnLh/D+8yYSQwbCP30EdkhVKfdYUwLvIojz9wbXfLFeJulZRLcnUGBkU/QNcyE7nZ9KwI1VhJDQNeGWslPjK8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rP/43Vl+; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=rP/43Vl+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dCc2t0qnSz2yrQ
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Nov 2025 00:47:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1763732815; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VKBiilkgZg/0HYkeoJzPUZ4zUqJFiuQQlGJ8QWzSh0c=;
	b=rP/43Vl+WWHvtZwUvny7np62vDAjfPRnN89QApMoW8EBtmQpVKw5ksGdZB5WbqOp+nD/YKwtIu3v3EnMBAftC7aHRE6q7Ww2Jdcr/aKq7g04zrhYeFTCcTerpL0ko3AEuMFuweUCoqaFvwYCQS8MAWm1d3bcdvEaQM6SoXqLudw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wt0FHJz_1763732808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Nov 2025 21:46:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: limit the level of fs stacking for file-backed mounts
Date: Fri, 21 Nov 2025 21:46:47 +0800
Message-ID: <20251121134647.104354-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Otherwise, it could cause potential kernel stack overflow (e.g., EROFS
mounting itself).

Fixes: fb176750266a ("erofs: add file-backed mount support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index f3f8d8c066e4..d408921d74d0 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -639,6 +639,22 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (!sb->s_bdev) {
+		/*
+		 * (File-backed mounts) EROFS claims it's safe to nest other
+		 * fs contexts (including its own) due to self-controlled RO
+		 * accesses/contexts and no side-effect changes that need to
+		 * context save & restore so it can reuse the current thread
+		 * context.  However, it still needs to bump `s_stack_depth` to
+		 * avoid kernel stack overflow from nested filesystems.
+		 */
+		if (erofs_is_fileio_mode(sbi)) {
+			sb->s_stack_depth =
+				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
+			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
+				erofs_err(sb, "maximum fs stacking depth exceeded");
+				return -EINVAL;
+			}
+		}
 		sb->s_blocksize = PAGE_SIZE;
 		sb->s_blocksize_bits = PAGE_SHIFT;
 
-- 
2.43.5


