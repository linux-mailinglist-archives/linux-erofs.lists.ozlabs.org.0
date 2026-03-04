Return-Path: <linux-erofs+bounces-2487-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGXCClidp2naigAAu9opvQ
	(envelope-from <linux-erofs+bounces-2487-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 03:47:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A54081FA038
	for <lists+linux-erofs@lfdr.de>; Wed, 04 Mar 2026 03:47:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQcXg6NTxz3bt7;
	Wed, 04 Mar 2026 13:47:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772592467;
	cv=none; b=P03TW+sDBFbeOG2PLIfojomR05+Ucf4WlVXJNNU2QI+evsDg4F9kfBkAvX7zlWUAxZSMrnvmFzfGU2VjE6hzgGOIjMhsN8/IY/kheSWP+yBBcGUgV+69S1BCboP7r8kzn1i7wmoSF8+hfEsSziWDQLWreiiWyBGjVcWoZfAdFIe4j6EMDjiQstRVrRL92WntALJgQ9SMzi4S4ctxboFhwGSFgwG750bGPse9flneMiLbCVmFThMIL/AJT7kARUMrXFLRlNibz5sbSG9aMNpgaJVUTNn2CkUY4XpIKD1hUNo2AKe4ru30htLVfUz2j+BhUxCCHu7ehfgUOOYV4btmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772592467; c=relaxed/relaxed;
	bh=wCCCoz1ltuwsHLHJgiwI1A4jnytkuB8SB2LdbKx1aD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/evTsv6ImQQt/vztLF7rAHLpD2UgH+1pDl3/oP8mB+CDhsjs4pdWNXVHPS0dhzzTDTAwh10atadlJlhlfMddjx/lSWlBC3IoO+EPr2eXz47+RU2UFr0GmUbQjaV7apAgbQmNJgygKgFkaqNVtdtsV1neQLxO3CHLI7yx87pufupgTSUSquEYaT0HmCVzInmdatRIfoxZ+riMwkcXoVl0Uye0jE9D7h/V2ctOaPMKjrJ1HajfZLXJE00769zAIIk7yvlOK/HdSsTbj5HqLcUPUfW6TIP1NY1Yg4vhtkOChxLlSI4gySPYNDoC5EK6ry9R0HgewCFQv86ipd5vpLyFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=itktk5dO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=itktk5dO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQcXf4HNkz2yLH
	for <linux-erofs@lists.ozlabs.org>; Wed, 04 Mar 2026 13:47:45 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so74024035ad.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 03 Mar 2026 18:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772592463; x=1773197263; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCCCoz1ltuwsHLHJgiwI1A4jnytkuB8SB2LdbKx1aD4=;
        b=itktk5dOBg6vROpF5fyOXdDwjKprzFr2j7saOZOQPFPwUnkZsvgNrxEEtlOzSGXXyc
         1N5GKaAI8Sqxz1J314SZjQc8xhH5sdFWHcHFyZj644+QvFVTxwOxNLcHx+RCCMxtmtwJ
         0JwLF8RavoaNP55z1I0VhMnDzjYxnFKaw+DolafRDz9jS7AtsC2VK4Wrb1Mp+Nm9V+0F
         wWPbI/gsKQfPkoUAqiO1LtCsnRN+sIv9awyOSafIDbDoFtOjqK4KvcjzzYL4S5B4nsHo
         jHUJU8fYTIaF+Bb8cPpNMKlEdtlKhT32FYkU2cX0D3k4wVxLAV7+N0Dqe0xQAq7Vv8Qm
         M+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772592463; x=1773197263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCCCoz1ltuwsHLHJgiwI1A4jnytkuB8SB2LdbKx1aD4=;
        b=fPNHX2uFP2zKd9GZWVlWg0kcTa4SjP5UJMzCDDMNu15TT8WdxtbUm4ha3ztFlIJX8b
         xemZJi9Pd5DmcixG4LiawPm97A9s7drU7vGE99w0pGLdtXloSWv0LUI9Wy29U/DLd7iY
         Ua6JiH/j6MO6buInPNCD21c7z43QNxETIBIIDaDQC819GJFpotxikwogF9I2D+WzOLZr
         N7khSZcItQoN1eThnDMtCCp0i5zedmbko5ioN0txY4lq2YIaVHBkNJmR4MmdhjRYVowA
         wE6Q4bNdBgGS4T7ZaQMJdv4HYELFYqNyD0UPDjiSMqSmBoum5bYF1t2FOBwMv/1JCXFH
         wnsg==
X-Gm-Message-State: AOJu0YwxtoorT2mG6Nt4BTEO6HA28M87wtkFLJbW8Qhd4iYkU60/7QFG
	K6qVg1/fX/eB3QLn0AbAtN7v7Alk0/Dv/Cz4I9tVwrhWKR1zv22VIrMVdVdK3aaUkyw=
X-Gm-Gg: ATEYQzz0bbnr71cmxtxnQriUJp/eKqEYjLym/3i2F7Z2EBisneaN1qXUc7up9K0Ge1N
	zVqq5LSzaKMdQsxmrCY5lMABWrypaUl54OQy3sGo8dtj9dwxuQzp2u6ykiIe4OP05inE5UScgJi
	Y9eDExZNe7r6+7RneTkHJO1WEqIE+enIzhQGsVQauC5cTmusnBgyU+0PyTH3CrzRL38toWbB56/
	zh0EZOdr/MgptRzcbS4fLE3ojDQyUPF1tewpbfCxsqjp/p1Xj/bgJuGHa0kptzANajXhEDSrdp2
	xtGrbKKK9dBI0LvrRulSy8B5pTEGrUvdMP/yAsHfBKQ5vQJBM2xk17BGvlJrU5c/3moVopj5kPG
	wfoJZBA2qgshqCpawh1ZDRtK6bUzM8+I6snXJwTfiHZg4EaCWL+169VJccOp6kioYIHwmuxxKAy
	3pDv0CUFf/u2/T1HKT6eLo61wKT1GCuZ+N0MXM
X-Received: by 2002:a17:902:c40f:b0:2ae:50a3:3aab with SMTP id d9443c01a7336-2ae6ab8e799mr6502195ad.51.1772592463428;
        Tue, 03 Mar 2026 18:47:43 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm238940475ad.43.2026.03.03.18.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 18:47:43 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	xiang@kernel.org,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] fsck.erofs: introduce rw-semaphore metadata cache PoC
Date: Wed,  4 Mar 2026 08:16:40 +0530
Message-ID: <20260304024735.78595-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
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
X-Rspamd-Queue-Id: A54081FA038
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2487-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

This PoC introduces a thread-safe metadata cache to reduce redundant I/O
and decompression overhead during fsck extraction. It directly addresses
the TODO in erofs_bread by modeling a bucketed, rw-semaphore protected
cache after the existing fragment cache implementation.

Baseline (LZ4HC 4K pclusters, Linux 6.7 tree):
Extraction time: 1.538s

With Meta Cache PoC:
Extraction time: 1.090s (~29% reduction)

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/data.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/lib/data.c b/lib/data.c
index 6fd1389..bcd8d17 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -9,6 +9,35 @@
 #include "erofs/trace.h"
 #include "erofs/decompress.h"
 #include "liberofs_fragments.h"
+#include "erofs/lock.h"
+
+#define META_HASHSIZE		65536
+#define META_HASH(c)		((c) & (META_HASHSIZE - 1))
+
+struct erofs_meta_bucket {
+	struct list_head hash;
+	erofs_rwsem_t lock;
+};
+
+struct erofs_meta_item {
+	struct list_head list;
+	u64 key;
+	char *data;
+	int length;
+};
+
+static struct erofs_meta_bucket meta_bks[META_HASHSIZE];
+static bool meta_cache_inited = false;
+
+static void erofs_meta_cache_init(void)
+{
+	int i;
+	for (i = 0; i < META_HASHSIZE; ++i) {
+		init_list_head(&meta_bks[i].hash);
+		erofs_init_rwsem(&meta_bks[i].lock);
+	}
+	meta_cache_inited = true;
+}
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
@@ -500,7 +529,56 @@ static void *erofs_read_metadata_bdi(struct erofs_sb_info *sbi,
 void *erofs_read_metadata(struct erofs_sb_info *sbi, erofs_nid_t nid,
 			  erofs_off_t *offset, int *lengthp)
 {
+	u64 key = nid ? nid : *offset;
+	struct erofs_meta_bucket *bk;
+	struct erofs_meta_item *item;
+	void *buffer = NULL;
+
+	if (__erofs_unlikely(!meta_cache_inited))
+		erofs_meta_cache_init();
+
+	bk = &meta_bks[META_HASH(key)];
+
+	erofs_down_read(&bk->lock);
+	list_for_each_entry(item, &bk->hash, list) {
+		if (item->key == key) {
+			buffer = malloc(item->length);
+			if (buffer) {
+				memcpy(buffer, item->data, item->length);
+				*lengthp = item->length;
+				*offset = round_up(*offset, 4);
+				*offset += sizeof(__le16) + item->length;
+			}
+			break;
+		}
+	}
+	erofs_up_read(&bk->lock);
+
+	if (buffer)
+		return buffer;
+
 	if (nid)
-		return erofs_read_metadata_nid(sbi, nid, offset, lengthp);
-	return erofs_read_metadata_bdi(sbi, offset, lengthp);
-}
+		buffer = erofs_read_metadata_nid(sbi, nid, offset, lengthp);
+	else
+		buffer = erofs_read_metadata_bdi(sbi, offset, lengthp);
+
+	if (IS_ERR(buffer))
+		return buffer;
+
+	item = malloc(sizeof(*item));
+	if (item) {
+		item->key = key;
+		item->length = *lengthp;
+		item->data = malloc(*lengthp);
+		if (item->data) {
+			memcpy(item->data, buffer, *lengthp);
+			erofs_down_write(&bk->lock);
+			list_add_tail(&item->list, &bk->hash);
+			erofs_up_write(&bk->lock);
+		} else {
+			free(item);
+		}
+	}
+
+	return buffer;
+}
\ No newline at end of file
-- 
2.51.0


