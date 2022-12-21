Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25451652D5C
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 08:42:05 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NcQPj3Ycsz3c6H
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Dec 2022 18:42:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oBg5ZP+K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oBg5ZP+K;
	dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NcQPX1mbgz3bZk
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Dec 2022 18:41:50 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1324111pjd.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 20 Dec 2022 23:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkLMygPIhMkn1JMuS1SQINsksFne/Btnep0O6ThNa4M=;
        b=oBg5ZP+KqKs/muY8t+ZeW2nb29zGVTdrmsSzHQ10vwBD6JHJlFEhxGp6ZhKq0NwRt7
         7HpON2ZlFBreLb5Ymgk1oBZnV9rHqciSsk6l8vF0hW1508jCvZVRacYmqOx6aj8gOiSO
         U1t7n571ClmlmGdClvahohTtu5Vnobm3up7ONzIIOefV+cnA94dx9soQk8UxYshnbTBj
         nl9NQ93hxeLkERQaCjvhFx4lajtcEMf4RDEKr2HV0RqDtD6VOypprVIEH9YE77nabPSI
         vrCBe9X8eP1OMpZOQ6vk7XfKpHR4B52knujS4DpCWEy46keqLQOXJ5rN4ihK6YiE1hXT
         R1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkLMygPIhMkn1JMuS1SQINsksFne/Btnep0O6ThNa4M=;
        b=S84Y7U1NFT36vx5wvrgniRbmY1kp/Zadug9iYsr3EHkQDIRkzAheXGKxY9IqXxfKxT
         FnU7UFXpKxlQ5nBPTR7X06eLW14s+xEahDRbqItpQUveGFKLEoEVfFRvBb40dKTSPqof
         Tyuah+bDYhNtFXw7u3RpTt8SZiQ+xWOlLmQlKOWhgbXAEKTRD4/tuQalNwlO61IT0LHW
         MDN/p40mfb6PRYvZpWsW2w8eYFIkU5UxwOFpcw97lIxtpSmZJ3BM1YZK94nax6iCi+0W
         752Z15ta6WOEN5ygqEWckTanvWk+yi3tyBN+Lf7kc3rbLlzFyvdXTqGQ9kL445MPFj72
         eSQQ==
X-Gm-Message-State: AFqh2kpzaJzyuD3nkJt1ghJudl8YtU8OlXFzrNn2+pNYpyTSQhVRBhB6
	WI7SqwhiQkjwHUuj0h5g3Ju6peKByuI=
X-Google-Smtp-Source: AMrXdXtBiTs/bYUZ+pw/IONnwNe91J605CXB1tzRD/AtI+WWfLyWBv8xYUZOIxB2wJbYcuYCshkwFw==
X-Received: by 2002:a17:902:f68a:b0:192:49f4:fe67 with SMTP id l10-20020a170902f68a00b0019249f4fe67mr76265plg.57.1671608504667;
        Tue, 20 Dec 2022 23:41:44 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709027fc700b00189f69c1aa0sm10660820plb.270.2022.12.20.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 23:41:44 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: support interlaced uncompressed pcluster
Date: Wed, 21 Dec 2022 15:41:30 +0800
Message-Id: <20221221074130.26034-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Support uncompressed data layout with on-disk interlaced offset in
compression mode for fsck.erofs.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 410e756..c2f57bc 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -458,12 +458,16 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 				.in = raw,
 				.out = buffer,
 				.decodedskip = 0,
+				.interlaced_offset = 0,
 				.inputsize = map.m_plen,
 				.decodedlength = map.m_llen,
 				.alg = map.m_algorithmformat,
 				.partial_decoding = 0
 			};
 
+			if (map.m_algorithmformat == Z_EROFS_COMPRESSION_INTERLACED)
+				rq.interlaced_offset = erofs_blkoff(map.m_la);
+
 			ret = z_erofs_decompress(&rq);
 			if (ret < 0) {
 				erofs_err("failed to decompress data of m_pa %" PRIu64 ", m_plen %" PRIu64 " @ nid %llu: %s",
-- 
2.17.1

