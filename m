Return-Path: <linux-erofs+bounces-667-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A4894B09BC0
	for <lists+linux-erofs@lfdr.de>; Fri, 18 Jul 2025 08:54:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bk0s54Mw4z3bjG;
	Fri, 18 Jul 2025 16:54:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752821673;
	cv=none; b=HeA1YLVHc8N8Ioy0isnSKJdWFcXpoAso/8VTqgmy0kv2XxdgI12Cvw4ldaYYLMkUKk4yxdMxDeKMrRvRV+bT3hJFLydqsM5VcBH+EB8jro0p2Q3OK1o+wC7rivdFaBcfIVJDGG9bm1Wdlm4THXhlTAYIg4rUanJ1wiz8N9aE93nwpLIlwd1gctnshXqsgm3mRdShsBKHDJCVUPATMsMAxjaUHQSSOTvvhTNcloR/VSkursLAWkLzIqjEXmfNyagAP4YcTFEQ1Bs1MDQ5eNpRTPPrbUHrW4tafadzxHLxSQBkxnk+kScIt6VtxCCUcXiKmVmZHa5wrvs4hxmkK+O8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752821673; c=relaxed/relaxed;
	bh=yQQmaW20MyVMTzwg5iJoQmmyp4H2bSG9qGE7/OLGrlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6T2cW0QtxywbdR9bixaCc0HZRHhL9WVGruXbWX0zpZ4Tnr0368ZeMsEJ0ul4vGQK4v+zoh9dWqGQ2lkihqCStyyZYoou/Pa1dCJHcb/sc6esfD6Q250Gya3gljceDHrXyheHvXlj7Gl3s5Mob3Xa+40j4usyhxR2/TfCdwvj0cVO24BEvnSFIEqCirhpvO580IDZZQ33ooJgwmBqNrxp9StKu6Mtt7qngwxcxiH8thGqhlQHKn1w8wLTniy7GVhIrZ2pemWvQrvAcPyLvothSyoZKgGA3TKVXmfCGwNrsHEzNcqcaTUcJgxFi9PHwjjMbYrHINZekdZbG8ZJstmxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YRVN2j0t; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YRVN2j0t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bk0s401KCz30WS
	for <linux-erofs@lists.ozlabs.org>; Fri, 18 Jul 2025 16:54:31 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752821668; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=yQQmaW20MyVMTzwg5iJoQmmyp4H2bSG9qGE7/OLGrlI=;
	b=YRVN2j0t4L9VyD4OQDD3OeI1HVXZNFvXEs7meTU1RmaN6tAJ0jjFLVpBM978f08EYcvPOUqRZND2MRc/HgUzJp0n91BK1siA1tV2R7OdHnp+Vo3iYsRHIps3Y+GasKPd2ni9NwBlzAD2ouZC+Esg3wuoZpLiXk3OPFjO+S5SYTM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjBMlRf_1752821666 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 14:54:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 04/11] erofs-utils: lib: change argument order of erofs_io_pread()
Date: Fri, 18 Jul 2025 14:54:12 +0800
Message-ID: <20250718065419.3338307-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
References: <20250718065419.3338307-1-hsiangkao@linux.alibaba.com>
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

To match pread(), swap the order of `len` and `pos`.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/io.h | 4 ++--
 lib/io.c           | 8 ++++----
 lib/super.c        | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/erofs/io.h b/include/erofs/io.h
index 14d6e45f..01a7ff44 100644
--- a/include/erofs/io.h
+++ b/include/erofs/io.h
@@ -26,7 +26,7 @@ extern "C"
 struct erofs_vfile;
 
 struct erofs_vfops {
-	ssize_t (*pread)(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+	ssize_t (*pread)(struct erofs_vfile *vf, void *buf, size_t len, u64 offset);
 	ssize_t (*pwrite)(struct erofs_vfile *vf, const void *buf, u64 offset, size_t len);
 	ssize_t (*pwritev)(struct erofs_vfile *vf, const struct iovec *iov,
 			   int iovcnt, u64 pos);
@@ -61,7 +61,7 @@ ssize_t erofs_io_pwritev(struct erofs_vfile *vf, const struct iovec *iov,
 int erofs_io_fsync(struct erofs_vfile *vf);
 int erofs_io_fallocate(struct erofs_vfile *vf, u64 offset, size_t len, bool pad);
 int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length);
-ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 offset, size_t len);
+ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 offset);
 ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t len);
 off_t erofs_io_lseek(struct erofs_vfile *vf, u64 offset, int whence);
 
diff --git a/lib/io.c b/lib/io.c
index 983d9bf9..b91c93cf 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -196,7 +196,7 @@ int erofs_io_ftruncate(struct erofs_vfile *vf, u64 length)
 	return ftruncate(vf->fd, length);
 }
 
-ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
+ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, size_t len, u64 pos)
 {
 	ssize_t ret, read = 0;
 
@@ -204,7 +204,7 @@ ssize_t erofs_io_pread(struct erofs_vfile *vf, void *buf, u64 pos, size_t len)
 		return 0;
 
 	if (vf->ops)
-		return vf->ops->pread(vf, buf, pos, len);
+		return vf->ops->pread(vf, buf, len, pos);
 
 	pos += vf->offset;
 	do {
@@ -403,9 +403,9 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 		}
 		read = erofs_io_pread(&((struct erofs_vfile) {
 				.fd = sbi->blobfd[device_id - 1],
-			}), buf, offset, len);
+			}), buf, len, offset);
 	} else {
-		read = erofs_io_pread(&sbi->bdev, buf, offset, len);
+		read = erofs_io_pread(&sbi->bdev, buf, len, offset);
 	}
 
 	if (read < 0)
diff --git a/lib/super.c b/lib/super.c
index e5364d27..8c0abafd 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -78,7 +78,7 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	struct erofs_super_block *dsb;
 	int read, ret;
 
-	read = erofs_io_pread(&sbi->bdev, data, 0, EROFS_MAX_BLOCK_SIZE);
+	read = erofs_io_pread(&sbi->bdev, data, EROFS_MAX_BLOCK_SIZE, 0);
 	if (read < EROFS_SUPER_END) {
 		ret = read < 0 ? read : -EIO;
 		erofs_err("cannot read erofs superblock: %d", ret);
-- 
2.43.5


