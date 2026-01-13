Return-Path: <linux-erofs+bounces-1838-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C471D17CC8
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jan 2026 10:55:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dr4PH1s5rz2xjK;
	Tue, 13 Jan 2026 20:55:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768298131;
	cv=none; b=aFn2G3NGLSILLguHY6XE++eUAewOBGuUHj3lpHWmJGcn3u1rIuDZUq71XdrcF/tOCq84D8MbKkLbI5376Dk9KdUmTkSZw/+Z0ZR8ApkDXZU4I1sJPYnjiIXo33V84wJnf/FdS4SeawXuD5ls6DQF+sSBCYRm2Be/372T1onOhvurUFwSvg2/C8Ybm5c3ZU5Xcd+M+2cTRXazEVdC2ViQwdLB0u/MPEqk5rsRNm2OXVwn3ls43GAg1mIEJnWStyzzNDMSyZERgPe2yh9ykax3+5OKbFNnnJNv5CZnm0NBo3DZjO0tW0uKcdRsSJlVZlayC8DCrI+J3iUjG+1MsXooqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768298131; c=relaxed/relaxed;
	bh=v4CIDU6DJhgWdot8r9sAui0L76NEaZmab0LJndS/zww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XpnbPp3eC77F1vNERGwDuUE0uCGdjcwbDwBMo7kvm2+04SxTsGGSSfWvxsURKMczqDJdgPxqi47ioGgaIbWFYYjIQz0iOUCOY0xqjxcHCqcKAVwdyBx+uSUjhs3k7wwkvuVRG7VOk1U7jZ1xIKYMDbKBQ89FoTqc7s/WGBtDWrkKXF9vxGnikxl+60n2r9s3J6WjJFE2Ua/wjyMOdnG6/qibl+wbXeCEtcrZCaZbzgH/YSVNyuPqbcis5wbWiHtyaIQJtrM1JWeUvaNf8eQElF072VYyK389OWDhNQefelYkQiQcxHqbbjl9tdlLEm4sH9Qr+FSzluEDEsHbDCNsEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NkHRbEO4; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NkHRbEO4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dr4PG1kQDz2xWP
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jan 2026 20:55:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768298125; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=v4CIDU6DJhgWdot8r9sAui0L76NEaZmab0LJndS/zww=;
	b=NkHRbEO4s5Onz2oTctn5ZuvNbhW9PLRxOt61mfJURPgHmy0i2Ae9Gjrbz7ivU2qRIpvTyPPahTs1snTb7txUgWhW0+vx6tbFgP0hhomRA3JtMzQvB+wHGpx3Ic9jQaR16mpmt0GAoya0aGh+98ZxXKK5Zrd2arthgwxNX8MKCk4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wx-M0HS_1768298119 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Jan 2026 17:55:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: Fix erofs_prepare_xattr_ibody() return value
Date: Tue, 13 Jan 2026 17:55:19 +0800
Message-ID: <20260113095519.363435-1-hsiangkao@linux.alibaba.com>
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

It should return 0 on success, otherwise it breaks
erofs_mkfs_handle_nondirectory().

Fixes: edd57fffa738 ("erofs-utils: lib: delay erofs_prepare_xattr_ibody()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 4 ++--
 lib/xattr.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index d56e795d9cfe..26fefa25eddf 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1464,7 +1464,7 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 
 	ret = erofs_prepare_xattr_ibody(inode,
 					btctx->incremental && IS_ROOT(inode));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (S_ISLNK(inode->i_mode)) {
@@ -1503,7 +1503,7 @@ static int erofs_mkfs_create_directory(const struct erofs_mkfs_btctx *ctx,
 	int ret;
 
 	ret = erofs_prepare_xattr_ibody(inode, ctx->incremental && IS_ROOT(inode));
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	if (inode->datalayout == EROFS_INODE_DATALAYOUT_MAX) {
diff --git a/lib/xattr.c b/lib/xattr.c
index 764aee3be3c3..703023703e53 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -752,7 +752,7 @@ out:
 		return -ENOSPC;
 	}
 	inode->xattr_isize = ret;
-	return ret;
+	return 0;
 }
 
 static int erofs_count_all_xattrs_from_path(struct erofs_sb_info *sbi,
-- 
2.43.5


