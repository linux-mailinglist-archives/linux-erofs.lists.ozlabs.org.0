Return-Path: <linux-erofs+bounces-3232-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIeJIPVn12lVNwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3232-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 10:48:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5C93C7F36
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 10:48:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frtrd5P89z2ygf;
	Thu, 09 Apr 2026 18:48:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775724529;
	cv=none; b=McwIATBA7s/5HpFworVrrXtaUnww5uf+EhV28cSjMAVrhKpLR2vZ9b7N27bXt/ameuh8V0zQOuvl6OC/A3gBeQSYPRVkbIcQdI5FdLc62PJj+6/8fQ0LOsJmHFOfu4kLr6tnLkocQWZdXIpE7651MflZVPDa7kQtU270mwCFW4utgzt7+GtoFb0rhkUW8cOA+P1UwW0HJVm6tAj/s5y/46RqBmxHBmUW2OifyFfCh6vogRQYc7J25u00ByaTdOZTWwF1sCwFY/VyX6k2BrH9hXbZzX82/y/+z92Z0ufTVxwOkTbHBwvDdFMMF7o6OBJo53/vRZhr/9RzY63hhn7cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775724529; c=relaxed/relaxed;
	bh=M1kfEtt1SV5bQ+RR5bpRiOIPtz7eRieNLD2e0q7KW6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVHzeSGNFXtSVHO+3Q0QI66X3tDq83Yu/1VecxB+sNkzc8N7NCEcbyu1jUifyPkTjHnK+iOBXHePZLB0JrTTxxH6CJybN5QWjlnOEMAq/wBKdBdAWVun71haN0Pj4Vur/RBAnK62fi/+O3Cd06TWjVxYpxFMAT9hfN3J1bPZ9GYrqO4un0nwEyVnPbEoL1nEATCuweF6m3A94pAalf6NlP+pITXnYsBnUBLHQVCeCn8uwz1ULVWABr+XqwcRXZTMpOaJH7t5rFBZsMPvNaZ4xkpnIHEZZ4cFDDqNuTSTebgH4HoL9bsYbx4ZD1rX8UsHfqXJleYC0Len1/G2F6G1Zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iwpKbdRC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iwpKbdRC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frtrc04j5z2yT0
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 18:48:46 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-82ce09b4197so341914b3a.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775724524; x=1776329324; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1kfEtt1SV5bQ+RR5bpRiOIPtz7eRieNLD2e0q7KW6c=;
        b=iwpKbdRCfxl6i1tXn9F54rgxo5dFbWCR0OGQtKtF+UnZTAtOz536lZZ09NwZzOdMkB
         dnXBJGvBZuL8B6HFAUu2SW3TFbYjJB4hKICtEkI2TKJEaD1qYfHgDdhpFkD9sImOEVaA
         IvmhnO4Lh7O2fzJ/kHrZ7HWJNkGHGl2y6TxqjSt00pj6Mg6oBsyVjMHBZkOjhQ2WN6QE
         Zid+vsJA0A87ar7tOIpv1MBJKNsiCDKuOPTVzUJWMsUHB2sDftHfxiR5Cxz0DdmXXRJ7
         L7bsQRD0xU6OlfVkxm+9eUEpsyFmFVcayjZAiNDlnMqBVgFLKPMeZdyW/v3Gffz1qRdU
         +7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775724524; x=1776329324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1kfEtt1SV5bQ+RR5bpRiOIPtz7eRieNLD2e0q7KW6c=;
        b=LtAqeGAjjUdoZBVrciNeehZA0tBhLeeTj5KFMmPxbRuNNQYq3XMc97sPi/sgLg/MpV
         YJ1nxCVpgy5U/KgKkUeJcdoccxYloPFS3ZQO3vBQjoLD3Myq1GslTYv7anTiuZhccB08
         OCGt/UVOg6KyZ79vILtcd23JbyXErf0PTPcpsz8X2h56Ce8Z15GZ2XDFKCUsaXQEthxH
         X1Xdkkd5Ttb1h1QcwrFP4oum1pUDYTT4NOqcl3LeZsejCocgDGql183foSEfa0i+hIf+
         xqDZTi9e92hJCsqjEezAe7iqDKWOYS1Cvli/zwQhPlZv/6B9e0S0mfvJI/o1jL7jbaYG
         IQzQ==
X-Gm-Message-State: AOJu0Yyu7S4l/XXxAIHvRfg1zubbK7qafB2gq3aId4u7X9SA0UP3w+Wp
	gbOCbrrCsEyWMylD4JzT8IJok5idRlz27W56twVIW3U39gZZA2PuHtLWE7gO7w==
X-Gm-Gg: AeBDieszb8lokKAQuHlxK8q0/9xpANAdIIG7OUDCOTuQReqvqjZivmELee5pKBRrHqp
	7WXJTFzoCDelaTb78pHUaqcPpSoTSnZE5ufPMrwY/Rxv6oDiDZH7aNark4HPTXpeZh1C4Sa268w
	/g9GSxkW8hw6hIgtkfLLfMFa9l17aTFR4sJHG48NTUrupuHtixcJVLsVAaUuYECc6GDn4fBjf1+
	XNizqr/7H/GSY4Adp4a0HfNoGFiOjGci5z1KkLO+7O0FV3EsD7bMdVFRSAbGXYcP5uJ95UO/scs
	7vsbluiRH0xE4Kvg9suCr+io7+cuZzAzX+yQ1O2EpAQQ9vKZLgES34FVpnP7/bZ45ABBBGtrG4Q
	rJ04KsrUXNPWHrtJTw+x0Uz0EkA4pUN9dsEwTRUIiQgHJnDimj7CAeAZ+u3qKFhHnK1Fai3D/cF
	byGgEhgMB4GcrW8WUFG2KWLxOHwijioGxVEAAbyg==
X-Received: by 2002:a05:6a00:4fc6:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-82d0dbc0dbcmr23511147b3a.50.1775724524144;
        Thu, 09 Apr 2026 01:48:44 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:603:7a13:1035:6b92:bc06:68b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm23765823b3a.40.2026.04.09.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 01:48:43 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH] erofs-utils: support --blobdev with block map
Date: Thu,  9 Apr 2026 14:18:34 +0530
Message-ID: <20260409084834.147-1-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3232-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4E5C93C7F36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for using --blobdev with the FORCE_INODE_BLOCK_MAP
chunk format. Previously this combination returned -EINVAL with
a TODO noting it could be implemented via deviceslot mapped_blkaddr.

This implements it by utilizing the deviceslot unified addressing
(uniaddr) to map external blob device blocks into a contiguous
address space, bypassing the need for 8-byte chunk indexes.

For block map format, chunk addresses are encoded as:
  blkaddr = devs[0].uniaddr + erofs_blknr(data_offset)

At mount time, the kernel's erofs_map_dev() resolves these unified
addresses back to the correct external device transparently.

Changes:
- mkfs/main.c: remove the error blocking blobdev + block map
- lib/super.c: initialize uniaddr with primarydevice_blocks
- lib/blobchunk.c: encode unified addresses in 4-byte block maps
- lib/data.c: fix erofs_map_dev() to set m_deviceid when resolving
  unified addresses, so userspace tools (fsck, dump) work correctly

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/blobchunk.c | 19 +++++++++++++++++--
 lib/data.c      |  1 +
 lib/super.c     |  5 +++++
 mkfs/main.c     |  9 ++++++---
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 96c161b..e666d2b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -95,7 +95,14 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 		chunk->device_id = 1;
 	else
 		chunk->device_id = 0;
-	chunk->blkaddr = erofs_blknr(sbi, blkpos);
+	
+	/* For block map with blobdev, use unified addressing */
+	if (sbi->extra_devices && cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
+		chunk->blkaddr = sbi->devs[0].uniaddr + erofs_blknr(sbi, blkpos);
+		chunk->device_id = 0;  /* unified address space */
+	} else {
+		chunk->blkaddr = erofs_blknr(sbi, blkpos);
+	}
 
 	erofs_dbg("Writing chunk (%llu bytes) to %llu", chunksize | 0ULL,
 		  chunk->blkaddr | 0ULL);
@@ -324,7 +331,7 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 	chunksize = 1ULL << chunkbits;
 	count = DIV_ROUND_UP(inode->i_size, chunksize);
 
-	if (sbi->extra_devices)
+	if (sbi->extra_devices && cfg.c_force_chunkformat != FORCE_INODE_BLOCK_MAP)
 		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_INDEXES;
 	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(struct erofs_inode_chunk_index);
@@ -498,6 +505,14 @@ int tarerofs_write_chunkes(struct erofs_inode *inode, erofs_off_t data_offset)
 		unit = sizeof(struct erofs_inode_chunk_index);
 		DBG_BUGON(erofs_blkoff(sbi, data_offset));
 		blkaddr = erofs_blknr(sbi, data_offset);
+	} else if (cfg.c_blobdev_path && 
+		   cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
+		/* Block map with blobdev: use unified addressing via deviceslot */
+		device_id = 0;  /* unified address space, no device_id needed */
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+		DBG_BUGON(erofs_blkoff(sbi, data_offset));
+		/* Map to unified address space using device's uniaddr base */
+		blkaddr = sbi->devs[0].uniaddr + erofs_blknr(sbi, data_offset);
 	} else {
 		device_id = 0;
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
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
diff --git a/lib/super.c b/lib/super.c
index 088c9a0..55d5dd1 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -393,6 +393,11 @@ int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
 	sbi->bh_devt = bh;
 	sbi->devt_slotoff = erofs_btell(bh, false) / EROFS_DEVT_SLOT_SIZE;
 	sbi->extra_devices = devices;
+	
+	/* Initialize uniaddr for block map with blobdev support */
+	if (devices > 0)
+		sbi->devs[0].uniaddr = sbi->primarydevice_blocks;
+	
 	erofs_sb_set_device_table(sbi);
 	return 0;
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index b84d1b4..3cccd60 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1565,11 +1565,14 @@ static int mkfs_parse_options_cfg(struct erofs_importer_params *params,
 		return -EINVAL;
 	}
 
-	/* TODO: can be implemented with (deviceslot) mapped_blkaddr */
+	/* Blobdev with block map uses deviceslot unified addressing */
 	if (cfg.c_blobdev_path &&
 	    cfg.c_force_chunkformat == FORCE_INODE_BLOCK_MAP) {
-		erofs_err("--blobdev cannot work with block map currently");
-		return -EINVAL;
+		/* Block map format can work with blobdev using unified addressing */
+		if (!g_sbi.extra_devices) {
+			erofs_err("--blobdev requires device table setup");
+			return -EINVAL;
+		}
 	}
 
 	if (optind >= argc) {
-- 
2.51.0.windows.1


