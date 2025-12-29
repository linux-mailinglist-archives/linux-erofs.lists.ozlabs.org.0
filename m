Return-Path: <linux-erofs+bounces-1634-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 50050CE655E
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Dec 2025 11:05:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dfsKj1xK3z2xdV;
	Mon, 29 Dec 2025 21:05:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767002729;
	cv=none; b=R7SdN29eISR9ESvsFTS07lxnxysdP5xbWSfxxSRdnXjbeEdxflgOC6sHWbLrxX1k35343KPRwFmxnw3nX3F58IhGVz0IvOrDNxFQpYaJRDbhejNx7N0s6LRVYQpiY3JiRfSjsss3BrDPCdaYB8GEzA6bMmpfJsHcjoijuG6NvW1TJN9OX1u5Hk5Sdw4/lJUb3nqHfXS17DIYfLPvrjfdkykoF35cvklX6g/BqZ4o/smfUVSfcSRSx8e9r68ax6+2heuupZMBGxJon48/EmAhYAo6iVIDtETfvGPMeu0jVcbqSjgMBTAWEBBYSMemjcl/mcepFr1tEPMGDDRChoiO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767002729; c=relaxed/relaxed;
	bh=1FFSI7l0ZOXZyB8p+x/GzISO2FctJEjGqFqb2Via1JA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goF67zJqtPJAcDKWrf/tjZRDeC0H4qBhqD5Q5mZuHgDclRf+Y62uWGUKwz4trHZSnQh+2+Li+r6qC62uOzuyNSNyW1pKclNUiO3rxOA5kQcV1dyjqlsSKUn4Wj/+lFLKA35z+AWNeNH8ck/I8+wcBTdV6pNiTpOMf10uPWagA5o8Nh/tkzpAtfeEUqO7LrfQ0GBZNWw81fd5JJDY0owXu2SWESNDaeTaPZBQyc53O+1HuwRx5DEDCdBzbJv33/AZCI3b6Wxv07wZR+xbix+uWkFipcJLe/ZEy+bU8vqWAu4BaetoRo+Z0MFgBI/+Yuc+qhhrgQbm8xe8mTHzPATZuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nRhisyLf; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nRhisyLf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dfsKf69wMz2x9M
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Dec 2025 21:05:24 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767002720; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1FFSI7l0ZOXZyB8p+x/GzISO2FctJEjGqFqb2Via1JA=;
	b=nRhisyLf7+r4W4cEzKVXhtFEjJQECoLTOd+atKUWOFRz9JzvWl4yekFqJLhj9nnaMe0zRyYLoUAmffXb/rrxAFLf0lLgDXQ0te9S8LERgkegMbXGWcoj6S/DG1VJ+wnzI9aMeZGQa0IeF1wQ6bdopnDUSSa2XmyYhReRloYaa/0=
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0WvrWbjh_1767002716 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 18:05:19 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] erofs: remove useless src in erofs_xattr_copy_to_buffer()
Date: Mon, 29 Dec 2025 18:05:15 +0800
Message-Id: <20251229100515.111287-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Use it->kaddr directly.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 396536d9a862..c5c481b3f32d 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -182,17 +182,15 @@ static int erofs_xattr_copy_to_buffer(struct erofs_xattr_iter *it,
 {
 	unsigned int slice, processed;
 	struct super_block *sb = it->sb;
-	void *src;
 
 	for (processed = 0; processed < len; processed += slice) {
 		it->kaddr = erofs_bread(&it->buf, it->pos, true);
 		if (IS_ERR(it->kaddr))
 			return PTR_ERR(it->kaddr);
 
-		src = it->kaddr;
 		slice = min_t(unsigned int, sb->s_blocksize -
 				erofs_blkoff(sb, it->pos), len - processed);
-		memcpy(it->buffer + it->buffer_ofs, src, slice);
+		memcpy(it->buffer + it->buffer_ofs, it->kaddr, slice);
 		it->buffer_ofs += slice;
 		it->pos += slice;
 	}
-- 
2.19.1.6.gb485710b


