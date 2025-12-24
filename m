Return-Path: <linux-erofs+bounces-1592-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 30564CDCFF6
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Dec 2025 19:31:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dc0pG2gjKz2ySB;
	Thu, 25 Dec 2025 05:31:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766601110;
	cv=none; b=C0adPbHoxB6U7QCP4+OJUhjknoZ6vT6wtS5n+0KrdCC53fovdzjjas5QDLNYHeOyG46CB/ah53EM0ls7/hhD8aZgm+T2no0maAZWEAzafq5kVTdavKAgw3QbqVCnrOFRgL26tQU2FPWLW3lDTIazzTyVJUZ3Elour5spWQKjF/lFzalUKY0ppQc3pe0sixV+GLeB6NV+NYaImx/Paj9JcD89Y+ZsRK2LGn9AxVZBDABvaWIbmUqKt0L9LvOG3TBo//BpJS971XL1lG3jlp5ZobC4By8yIYX7PD/P+xgci332BGFePmbvzSerqoK5TpNj8NmaNzKmZN98N3P4NAawWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766601110; c=relaxed/relaxed;
	bh=nzfc7idTh55tsmh8cbwaxcCnsTLX7AKTXGIOgo0vCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dq2fLXNqsE6NVUs4iYvrP2q4RHLAELHCushxfGr1Ylk/+lSBiqji/muqafSXFWNChv0N0mrKk4rp31aEsdgupYzhX+PzBl9OZS4Asb8PUc3TiUfP1AN/hLM106NLsdLasI5nKiYsGZoVwAy6WJkXATrRix6Cd1VvsmI7bUt0mMa7AFErRd3Qdh2zpFhx299FfOoOBRXn2tsXtIs/zieiqecPHvIqq3vAH2Ih3zQW0EGDRmIOP1jySfK9y/yUcue8r3H0YmFc2EN5Gy5KztStsuETWqkTiottO3FOSPN+sUKPIp9o95Uchx4qzeLWDPb/MEnP7yBYCYiZSSZVUsZ6hw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=the7L06R; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=the7L06R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dc0pC2gGNz2yPq
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Dec 2025 05:31:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766601100; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nzfc7idTh55tsmh8cbwaxcCnsTLX7AKTXGIOgo0vCkQ=;
	b=the7L06RxiSsRgGdO3FARitwfZ5oIulWCrpqLUq5Wx+E03/YLztRZhJNyWc0y0LbASL6zQGLW+7dK+78y7EDJAsTN2sI6bXgnt5FOcvU5C7YelfJ/VGHmk9wGy9wSJGcOM5md74TmjLtFxjZDITRCSmlxbegadDEJ7QdhfhByxA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wvc810y_1766601092 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Dec 2025 02:31:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Huang Jianan <jnhuang95@gmail.com>
Subject: [PATCH 1/9] erofs-utils: lib: fix erofs_listxattr()
Date: Thu, 25 Dec 2025 02:31:23 +0800
Message-ID: <20251224183131.2302377-1-hsiangkao@linux.alibaba.com>
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

A long-standing porting bug.

Fixes: c47df5aa2d16 ("erofs-utils: fuse: introduce xattr support")
Cc: Huang Jianan <jnhuang95@gmail.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 68236690d5b3..4ef27d446bb8 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1637,7 +1637,7 @@ int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size)
 	it.buffer_ofs = 0;
 
 	ret = inline_listxattr(vi, &it);
-	if (ret < 0 && ret != -ENOATTR)
+	if (ret >= 0 || ret == -ENOATTR)
 		ret = shared_listxattr(vi, &it);
 	erofs_put_metabuf(&it.it.buf);
 	return ret;
-- 
2.43.5


