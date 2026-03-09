Return-Path: <linux-erofs+bounces-2539-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFUjBhS8rmn6IQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2539-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 13:24:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B5805238C25
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 13:24:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTx665Zp9z309P;
	Mon, 09 Mar 2026 23:24:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773059086;
	cv=none; b=UwAvCtQNM/AL2JgtxabL/twvEYbLdVwb6W9mocvzFCVGP0w9z6Bf82ufIyCLUbvqWS2NyJDYHzuFLQi8EBWS0dYIX6EgqD3+5cWqhya/7W4X2AF9i/TDOZkRejp84bGOamXAE/zN7qArCEeOwH8yZKDH4vuA2zSEyZN5MEJseOwxbiETM0zcYsGWmNoaBJrAY9LYFj60uCEAr9eDaZqzlX33Qq2S+jk7nxDDoJ3hc1Upc52+AjF0op58o5mBwbXt852de4577ZnG7zEi9tdT+u30bOoFJ1nHPA2STC/cAKfDnglo1npZQqF8GroylI8wnkSNQUfSOaDe3+0cFnoVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773059086; c=relaxed/relaxed;
	bh=pFO7rtllsGyYF83MU8i6cdHYDoKLWfTatK5oN8Qp+Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dg4dU90YDv88CnwwYd9w+3N/iUvDgveJHB9JCQ2lMJej9MQm+yjzBdtM48KV6PwGeW3ipFVBgGyCtnMlZVW6W+XNJmdvvAipDQ6YNZ46A0mRPmrF6cvdf+3e8Ba5KUVOW1wtCxuDd0k8J+tVUT5jKS4IytLNg9tkbNm6ytJKiugTj++3S2nsn3VhOHIuQdZUHRM+YJlToDyA6UhWxGAv54JyRySgPCLsl9y4geLoOExzyTvddKWzWUEoHR7SW4B5nC1PR96BzM6NPQcqpIIH/g/7R/CjlVkApOT9njBMUb1Ro8JePYj4/kXeT/g0p2Hp5H4+KdzJSARcS/3wOlwKBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d5taGAhU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d5taGAhU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTx6539rCz2yFY
	for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 23:24:44 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82990763921so3758522b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 09 Mar 2026 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773059082; x=1773663882; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFO7rtllsGyYF83MU8i6cdHYDoKLWfTatK5oN8Qp+Ak=;
        b=d5taGAhUXSNXBZOa0WttoPkyN3YbhEAOf6PYEfZM9YMez5Kz4YuKWJrhvKz8PmxJve
         WD8yi4ArIkSYi2IEDvUbRnXM2HrzWF7zskA8liuuG/+zC2hSPbKNNjuqqjupGSkak0Ks
         z1+C/BX/JDop0d8p47onjczzqz0I+PTE7yXRRmGOj8abb/QLCvlinp/4QJVn8439fxeH
         AGyONJnOquYq0qdpQQ5o3d/mpVHHttR/Gz9leruYWXMVCuViM1B4bfz0/aBbRBfVZnqe
         GbEHfzXaFOi9dcHRIdyADDtvEOsrPVP9ymDp/qk4faym0irUKL8ahnB4JLBbH+Qf+YCG
         xhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773059082; x=1773663882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFO7rtllsGyYF83MU8i6cdHYDoKLWfTatK5oN8Qp+Ak=;
        b=s7goL7egPzusn07JaEHjlqGr1Tj+KmOWBvVLpZIfLzbMuf1LVrKWbs1CWxSLBQDuDK
         sLM0TQvsuNyLqs4d1uvU2xNLXw/kxKmbqQ4MbCIsPkcbky07K6HX1hDkmZcPlSJYJrTh
         j3+o1rSBftS1PbnPDmcxq1F7tNyMM6T0hAYZ9+zBYl1AXB9DVebI96JadC9CBTtF19H4
         /JYIqLfo1DCHqgV9wVpIZ8YYfipdDfDns1ld0r7sgpK1gFHlICOWiRhK6tVoOZ7SUk+X
         MUZUnPwYzV2ZJ7Tu7O+H9AwZU8lEw4YRd1NY8VnX3ccsQX+wNKkhdcn2oER3xczHfHEH
         c+pA==
X-Gm-Message-State: AOJu0YxMcfCZrkSATYj4QEyYZrcQpr2cdHkxm78duEO4iIag7xIkgi16
	D+yXau5LoHIJqo5Tp8gy23KJSa/R/KOkNgtDAQNqpGHhxLmRIbHW9yuhgA/PNeQ2
X-Gm-Gg: ATEYQzw/YGpc17kRj4iUEfSZ0WOiXIcrK86kiL2niPBGe5RPF4UJrkV9LB4aQHXCw7V
	4p3BqF+p4nvXBqPf4yCbaD+9Vp/61usYfKhneG4XppYZEgwoZNYiGA7wWkJid/wogv7mx2KJzvH
	c7TEnb3ZpDl50aW8tCn8tdmZClXiQiA5dHOqNsgVZ/C725eOxGOvnGI6+TxLYDYGPm4DE9fogGv
	HLYe3J5wVMQAfh1x+bqLAgjswchOqkLOCGxBwEXZqZ4RGACCt511C9UttHjj3a83laQdY16erfh
	kYc+1aojZ/EbhUAYF6tNfXDBkJXf+MKLJ6Qjr4zeIVlcJNLZno0QASenK0q+L1CnjsOVpsKHI85
	Asozyl+OrhYnnImWu3avDyVHMmtbN1gyEFMfS2XKi0CTo/d7G/4MHfIG/ThR80NcJU+JTMDi4hH
	U+P53kD/AuqWSiBVAd2pz28Aw90O9eD2i1YTRYtxzAoBuHj6rWGec=
X-Received: by 2002:a05:6a00:22d1:b0:829:9527:e160 with SMTP id d2e1a72fcca58-829a2e17813mr10890158b3a.14.1773059082096;
        Mon, 09 Mar 2026 05:24:42 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636cfbsm10039111b3a.13.2026.03.09.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:24:41 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	zhaoyifan28@huawei.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] mkfs: support block map for blob devices
Date: Mon,  9 Mar 2026 17:54:34 +0530
Message-ID: <20260309122434.49204-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260307062810.19862-1-nithurshen.dev@gmail.com>
References: <20260307062810.19862-1-nithurshen.dev@gmail.com>
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
X-Rspamd-Queue-Id: B5805238C25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-2539-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,huawei.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
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

Currently, using --blobdev to specify an extra device is restricted
from working with the block map chunk format. This was previously
noted as a task that could be implemented by mapping the device
blocks using a global address.

This patch implements this support by allowing the block map to
reference chunks residing on extra devices. This is achieved by:
1) Removing the -EINVAL check in mkfs/main.c.
2) Calculating the global startblk address for the block map by
   summing the blocks of the primary device and preceding devices.
3) Ensuring EROFS_CHUNK_FORMAT_INDEXES is only set if the user
   has not forced the block map format.
4) Updating erofs_inode_fixup_chunkformat to error out if the
   mapped address exceeds UINT32_MAX, as block maps cannot
   support 48-bit addressing.

In addition, erofs_map_dev() is updated to correctly identify the
device ID when a global block address is used with block maps,
enabling userspace tools to read these images.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/blobchunk.c | 34 ++++++++++++++++++++++++++++------
 lib/data.c      |  1 +
 mkfs/main.c     |  7 -------
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 96c161b..fdcf4b3 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -159,7 +159,17 @@ void erofs_inode_fixup_chunkformat(struct erofs_inode *inode)
 		if (chunk->blkaddr == EROFS_NULL_ADDR)
 			continue;
 		if (chunk->device_id) {
-			if (chunk->blkaddr > UINT32_MAX) {
+			if (!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)) {
+				erofs_blk_t mapped_blkaddr = inode->sbi->primarydevice_blocks;
+				unsigned int i;
+
+				for (i = 0; i < chunk->device_id - 1; i++)
+					mapped_blkaddr += inode->sbi->devs[i].blocks;
+				if (mapped_blkaddr + chunk->blkaddr > UINT32_MAX) {
+					erofs_err("block map cannot support addresses > UINT32_MAX");
+					return;
+				}
+			} else if (chunk->blkaddr > UINT32_MAX) {
 				_48bit = true;
 				break;
 			}
@@ -201,8 +211,16 @@ int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
 		if (chunk->blkaddr == EROFS_NULL_ADDR) {
 			startblk = EROFS_NULL_ADDR;
 		} else if (chunk->device_id) {
-			DBG_BUGON(!(inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES));
-			startblk = chunk->blkaddr;
+			if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
+				startblk = chunk->blkaddr;
+			} else {
+				unsigned int i;
+
+				startblk = sbi->primarydevice_blocks;
+				for (i = 0; i < chunk->device_id - 1; i++)
+					startblk += sbi->devs[i].blocks;
+				startblk += chunk->blkaddr;
+			}
 			extent_start = EROFS_NULL_ADDR;
 		} else {
 			startblk = remapped_base + chunk->blkaddr;
@@ -324,7 +342,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
 
-	if (sbi->extra_devices)
+	if (sbi->extra_devices && cfg.c_force_chunkformat != FORCE_INODE_BLOCK_MAP)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -494,8 +512,12 @@ int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset)
 	inode->u.chunkformat |= chunkbits - sbi->blkszbits;
 	if (sbi->extra_devices) {
 		device_id = 1;
-		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
-		unit = sizeof(struct erofs_inode_chunk_index);
+		if (cfg.c_force_chunkformat != FORCE_INODE_BLOCK_MAP)
+			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
+		if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+			unit = sizeof(struct erofs_inode_chunk_index);
+		else
+			unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 		DBG_BUGON(erofs_blkoff(sbi, data_offset));
 		blkaddr = erofs_blknr(sbi, data_offset);
 	} else {
diff --git a/lib/data.c b/lib/data.c
index 6fd1389..5aeb0c1 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -184,6 +184,7 @@ int erofs_map_dev(struct erofs_sb_info *sbi, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
+				map->m_deviceid = id + 1;
 				break;
 			}
 		}
diff --git a/mkfs/main.c b/mkfs/main.c
index 58c18f9..07ef086 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1565,13 +1565,6 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		return -EINVAL;
 	}
 
-	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
-	if (cfg.c_blobdev_path &&
-	    cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
-		erofs_err("--blobdev cannot work with block map currently");
-		return -EINVAL;
-	}
-
 	if (optind >= argc) {
 		erofs_err("missing argument: FILE");
 		return -EINVAL;
-- 
2.51.0


