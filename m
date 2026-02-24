Return-Path: <linux-erofs+bounces-2372-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAc2Bcg9nWlUNwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2372-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 06:57:28 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0791823CF
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 06:57:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKn770cxFz3cDr;
	Tue, 24 Feb 2026 16:57:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771912643;
	cv=none; b=MmF/mCUGzQFnabVVnXC2j8Y7FlwMMFhD//2bcRosMAsZkIY4Cccs4D4p6t6ZQSCfr8HqqB7KEewTk8jNkgdd2xiGhz0yHoY/wjpaaUwwHt3CDpcNiuImpKJeH2DW1j7QUP7iktg7VpW5q+xJuoqfF+Qy2I4Lda3NeN5mL6XQdnVR6rQsJQHgSLwUSf5QDNTvedFKZJFm4fZFuS80PtCb3PZ8ffnZf1Sf2i21JTj5f7yR8gCB3wwEzGrj6DP6aznEJEiyWXvsOb5XQnU3uYI+XdOuju4mZnPdRPBGYi15DhApdQ+mB80xnn0E6QAjqJAQ4Y52PT3LlkbKRosn0c0/8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771912643; c=relaxed/relaxed;
	bh=EYBICnAxckwfVseZT2u2BRpPM7tahyIeCUHh/Ctktik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGTQmEvZAn5+ranHmtYZGQbOWGiM9E88ogi1xdR1UtyW3pxnLBVMLvz8A1oivLcZENSh/cB/+XBtxa5a3Bv6wKv3SYoPOPgrhzMV6lNAD6yWf7PxGQ1ByFEq+SuxfOo+FGbJco0P7xlmc0AxuT27huW6GJIC/DJLkeeOQk8h2kmSjBBz9p72mhgUkvtJryV6h8TKCBYM2saPHsa0O3z3DAVLMDaWPKefxmXJg0NGwL1EMeebiwC5DeMdRCWuKLQOSkg67C+JGb0A2jN45sFUr6hYpPrJsSywfZJGcGUDz9OnaazemLT8IJJs1g3haarG0jbzicaqAwlFcHpJPW+OfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cT2tMRaX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cT2tMRaX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKn761JrMz3cDg
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 16:57:21 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-c6dcdc955a1so1808860a12.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 23 Feb 2026 21:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771912639; x=1772517439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EYBICnAxckwfVseZT2u2BRpPM7tahyIeCUHh/Ctktik=;
        b=cT2tMRaXMBkYCYDblVkfF7Pc731hgY/taPXN26kTnIx2wCPM0i0WoVWLe3p45gZD75
         +dTkO30wLMQEp7JaCBTG6JgLwEz1DciDmB//gOmsn109Cmg0nScG0KrSb4aKIVULz5JH
         /Dt6iZ8Xyrb7UmXJ+cB7VAfAb8BmV4Q11PW6hmHHk9TawmzEe/jV8aoyfy19JkUnIleI
         sJMuHq40BY3dJJ/0ZGjopLd5L8j8Fvxuni0D0y+eH6TGZ8Cre7is4H9zJ58qrsRXSf6a
         zxHg0RKCCS7tBesJf5z4vEO7riUUTug63Y9BCzD14Z/6omBiX9OscZEUJCqhY6LBUsQr
         2UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771912639; x=1772517439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYBICnAxckwfVseZT2u2BRpPM7tahyIeCUHh/Ctktik=;
        b=vtC4GR/XEgYu0cmP1cJFcAI/+QzhqXzcIOuwaJb1qHI4/PZi3uCRZNygoAnaDzfm/E
         uHRsaHmxirFPFPtUP0lzmgAI8XUYz8Rseyip36jpPV6ZVV89hT9LhG9QMqrVLzg9KpB9
         VkprtcJSBEGkQo5erxLJDAPzEsvWtzB90KnPc2XM89cDNvn39FP1bTv0pxt7Kd9nDU+F
         hbXhfmc6Mp1GbdNlN9uSMVPYtT7st6xu5n/O4YUujNYGc1Xq/gr7cvl7EbBPZ84YqFCU
         BRlTP/k9BMs3C3oQNbJ4YWUW63F2vOepJUGZSb3Ivvx3Ywo9rP/mFsJUS44KI+awHB5+
         7Kyw==
X-Gm-Message-State: AOJu0Yxzf2pST0htKTvMLI6WBeicpOBEi7n3Uh2qKfUTNb4VxBOP9PDt
	U3mTTpeT87mk5NptwzHjiSkRhF2I6nEGF2V1G2wp95lbkp4v8vgGQWWTQm/SCQ==
X-Gm-Gg: ATEYQzxztbQJpgIGNI+Ocfn0gpCcoYTK0kxWrg+UzWeNpIUu6iz9tE0Zs0NcS6Ql/Vs
	gm4pD/pUmXlVqgsiqWyK/htLWErqLBJs6UxjG4zithUHKQtc25Qkg8IGZtZqlyAMZUDjepY+qZX
	oOeQ87lsrWOGLGY0TxRLDjf0CbilxxJLjzQIayRPjMnHvSzIHLYEjl6Ev6TE8VubEgCgRa4qGxT
	yu8JJfz6QQ5GQYZasnAzaBMNbBAgS4/13vaCWEgJ0jf4HZLBer6/v5iA0yKj7exdJN8sOENM715
	p2PGpoQxdGPxMAjLKj3oXIY+vpZ5GRA71qCOpLkaSPgP/YOxYwC79/swufbeOqLcprWBBi9/Hg5
	q7POVp32s7TguRPDIhIEUkXGtbuiP1xmLP0ux8L2HtPgOK61Bk8HINB8+LF4gZKzn/+Ylbg6p1F
	+JoJuMLUDmbgnWRzPFBOLae5lzBjxv5qTGE/6WSHqcb8y5sMFoRbUcIA==
X-Received: by 2002:a17:902:d54c:b0:2a0:e80e:b118 with SMTP id d9443c01a7336-2ad74418adfmr108054625ad.7.1771912638976;
        Mon, 23 Feb 2026 21:57:18 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75027641sm113242155ad.64.2026.02.23.21.57.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Feb 2026 21:57:18 -0800 (PST)
From: puneeth_aditya_5656 <myakampuneeth@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	puneeth_aditya_5656 <myakampuneeth@gmail.com>
Subject: [PATCH] blobchunk: fix 48-bit format detection to use final remapped block addresses
Date: Tue, 24 Feb 2026 11:27:12 +0530
Message-ID: <20260224055712.14110-1-myakampuneeth@gmail.com>
X-Mailer: git-send-email 2.52.0
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2372-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[myakampuneeth@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: EE0791823CF
X-Rspamd-Action: no action

---
 lib/blobchunk.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a051904..9b8112b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -154,6 +154,19 @@ int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
 	chunkblks = 1ULL << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
+
+	/* check if any chunk lands above 32-bit range once remapped_base is applied */
+	for (src = 0; src < inode->extent_isize / unit * sizeof(void *);
+	     src += sizeof(void *)) {
+		struct erofs_blobchunk *chunk = *(void **)(inode->chunkindexes + src);
+
+		if (chunk->blkaddr != EROFS_NULL_ADDR && !chunk->device_id &&
+		    remapped_base + chunk->blkaddr > UINT32_MAX) {
+			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
+			break;
+		}
+	}
+
 	_48bit = inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT;
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
@@ -380,10 +393,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			goto err;
 		}
 
-		/* FIXME! `chunk->blkaddr` is not the final blkaddr here */
-		if (chunk->blkaddr != EROFS_NULL_ADDR &&
-		    chunk->blkaddr >= UINT32_MAX)
-			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
 		if (!erofs_blob_can_merge(sbi, lastch, chunk)) {
 			erofs_update_minextblks(sbi, interval_start, pos,
 						&minextblks);
-- 
2.52.0


