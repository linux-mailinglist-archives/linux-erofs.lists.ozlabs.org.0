Return-Path: <linux-erofs+bounces-2744-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHWPHRjht2mcWAEAu9opvQ
	(envelope-from <linux-erofs+bounces-2744-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:12 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CA9298446
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 11:53:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZBl76vJRz2xlm;
	Mon, 16 Mar 2026 21:53:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773658387;
	cv=none; b=BHloTnTFZODAaSTXCbt5yN3mJgoDuRrMelio4ygkVKFuacRBdkqjtUP0biCIgxPyTWFO7dokM2C+EGrb98k/g8IGj+V1fHNEL9C4PlJOW0HGJSoE4oW0C7trDmVfc3Rxuu8SeqqWufCvTrK7zBHj+TdyzgtThjp6L1OWucLo30evyJv016NHKB0NmPSVSh0vy7BWJPeoFHSXr92sQ7i1OlEGcrh3O4ecWu5VVywpYYndxbjT8X7TXIzYCRLo3908VDpCXwepeZwVhaLhPi4zC2fgtR3/5Bte0WBOeaEXv8WQtv9a9vDkCiYXS86p8kKXtN6siuT2sRux+Ggy2ELddw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773658387; c=relaxed/relaxed;
	bh=pFO7rtllsGyYF83MU8i6cdHYDoKLWfTatK5oN8Qp+Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvTtdXiyQoaTNWpTpU9QbBtVuAxFGfvNM8Ho+xVcJBebDXGdH5/MGnj7Y3uN+bqQ9jCglHprjrjzBr3PO1V7zVI4WDN9UWwxGkxnkC2YB8UVYTzSVCofEkjfw994H/7VTqt6UidAg8yNB/bkVLkNHEVTQBKJ8OCxBISUa43Npm0d17bBlVCgFA9zuDub+xOZZ9AcMNCkzOYwvIvDqxUW+t+bNC0p/tCIKlrFAPhZeDQ3xp8nV2EZCyAesQkic0pFf7OWtWG4uVZNGMeGchW/V3tDFPkW1Ym1KWI7vZgYdmduRcAIhVGW+WgMDz/l+MEZ/h4dIDRD1JBpKMnOwvWRTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dgjYhYhF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dgjYhYhF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZBl72YJ8z2xMQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 21:53:07 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-356337f058aso2743892a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773658385; x=1774263185; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFO7rtllsGyYF83MU8i6cdHYDoKLWfTatK5oN8Qp+Ak=;
        b=dgjYhYhFOFsCWwuhGtinFFlDGCJNzmul/glb/DJw7lkmVa1LfFkFHCYLmAKuff1AC7
         Wjdm6sMgHUn5YW5FAq9Y35r67Om9XoaqPmlzH/QWMZFvqUiQpAJaSXPfrLGiXvjb++Ct
         suvlvvNDbZq+zZVdXk+gihu6mNg3/2XX1Ujz3M+WlOAmrRe5NwhVhabRGNjOTMQ7gCX4
         md6GEBC0ptL4BQIxGENqW+lfOOQUQmS4o12O58lkNEFxLAnwiPz14V2vcFyZugDOH5cr
         +1O26prQlF7H17K9D0+YlpCEsKpDNBUGNasYTMPs64ccIrnRUXyPBpwJlm9q+baMjOyJ
         uAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773658385; x=1774263185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFO7rtllsGyYF83MU8i6cdHYDoKLWfTatK5oN8Qp+Ak=;
        b=Av/mcdqqxNoTKv5FVE0cBRAxjodAcobrvePy0uXgeHaP27C+ooiqTzzLvgE+rdYnyc
         /rOahL0SOxyqRSMG8tyUIcGWGytSqsIKoqI6Z5nSIaPRAXJim4y+gYEKUAPnRU4O6l/O
         36MplHWQN9FacoEdkZhstSmB6k0rdc2tALhmG7w9yMjOSFuYJXC2SfattLOO1xhH8EJg
         xiI/LAxGsCCAhDa/2YGCE32VS8Ka3bE5S0+gY5gsTjKdLLMBsLtJVyJc3DKbU20yUImP
         RkC9uu42vLJAH+usCdO5ijuGAfM/ofYHdRUHXsuqbPA6zz556o+Vs/y6UL8agshiaOLe
         ruvw==
X-Gm-Message-State: AOJu0YwQYyan1TkX8tIXm2BfG/kRHtFiW5o3Lr2aWzMtYO8ygx32O/3z
	bP6oUrV2kVjX56V+DKqBOS1kXByCdfhCfD4mQ3PbJPVKRpGP3jXLt8FnUBjCYG26p7Y=
X-Gm-Gg: ATEYQzxSUKcH4wTl4Oj79ULBpQZZ/000DcWmXSh86bquSOH0wzAn4+A5gA2wn0PAS4+
	c74iN7HmOTJYPtnq+i45aVTkFfLVuoEM+jbsTcAJn0RSysEYnyNEm8XsIKwZM+88x/7K7FWWq3z
	ArkEkwCSQ029MPzoLZnccWQ/C6Q0yl+AGQuFlOB0M+5PQT5mhzJpjOFWSawgAW6ImV+OOdVB1Ib
	/Gl25JTrfycNdbweuljDQLC/qc3AqRm881EHeE2aAeNBu6U1XOa4lLXVdjHS6X164xfC6fsgE+C
	Ia4q9EJ8qJEW+CK5zXhSpFcG9H21AUqn0YyYPngyBBkF2/OaoKJGPN72fQeFiAKxtiePK8HlsA1
	AbFX8jp5os/CTtWqc7SZXTZW4Gqhz3JXx9/6aiM6P167jDRWbTzPTpEwVoERaxrbPULb1afASWL
	JE0xSQwCXKlvsaiTLReLRxgUHdfmRlOohOUl2kG5pfL5WlNwGVOrM=
X-Received: by 2002:a17:90b:1e44:b0:35b:a3be:f1b6 with SMTP id 98e67ed59e1d1-35ba3bef652mr1813052a91.16.1773658385016;
        Mon, 16 Mar 2026 03:53:05 -0700 (PDT)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b94e8baf9sm1693569a91.13.2026.03.16.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:53:04 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH v2] mkfs: support block map for blob devices
Date: Mon, 16 Mar 2026 16:22:41 +0530
Message-ID: <20260316105242.6894-4-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260316105242.6894-1-nithurshen.dev@gmail.com>
References: <20260306085717.12776-1-nithurshen.dev@gmail.com>
 <20260316105242.6894-1-nithurshen.dev@gmail.com>
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
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2744-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 64CA9298446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


