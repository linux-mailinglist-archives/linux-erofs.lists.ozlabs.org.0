Return-Path: <linux-erofs+bounces-2532-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fDN4NIvFq2n3ggEAu9opvQ
	(envelope-from <linux-erofs+bounces-2532-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 07 Mar 2026 07:28:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED022A604
	for <lists+linux-erofs@lfdr.de>; Sat, 07 Mar 2026 07:28:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSYHp4DXlz3cBd;
	Sat, 07 Mar 2026 17:28:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772864902;
	cv=none; b=GMDr2INYV1lpuCjX6RWe+flmEI/JgPf7kyfur53w0vovIe24CkFEVkQ9/eTCgaP8aQEiBUIhzhrdQGPPmif1hFSgaS0+qmexb4S6G0sUNSSr/rQlpcylkIgzmozl+e5yld+BNEQBb6dSA9sdzNXnFIo4lnuoTKvbj4/8xRSDymrCPfa/JyTVZCSZNjd4IBQ91zmYRkDuApyyc+BoDkY2nXGtVOJ8m3dK6Ga9l8/Xe8N+WqacKZzQeIQxwZmB1kJ6N23WZJbKYhNzqH0z7cKvalZV+925rrL1PZTWgjV80toBcdSX9/39LpvD0H7pK+7pBUxRGp+tIuMUxZ3cz3bjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772864902; c=relaxed/relaxed;
	bh=pp6459sEHgDvXHzZslA/d/z7MVfjL94uWh8GF3sNGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CKAABmtAz2J8/TE/DfoRG5PlkAIFFQylaODIcPE53yM5qD9vgF3HYuZy5FPpsCQBCJjaoYaMD/2RfviWDlTWnVGAJD7cGYh+DyWNBTRllny+5XqYzZ4gizjHo0mPaC9o4BYLXlzLqWodXAu0VmZCE/Qi0i88qH/m3saJhziFd3/eHMer8tXpCVQ40svnbCp1y/wEejcGJFlinBVjZQRB3gupkCTBoMcaOPzas/mARDk0KYBT/xne3J3tOkrl3rrrHELSQb2d+vALpo95YtyaiwyAU8u9RYKBOVWVdHyqyQ9ueAoCdYIf7fSbbygSndOIF4OZV5QL6aciLDps2bFodA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kNM/W6ZR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kNM/W6ZR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSYHn3LHPz3c9y
	for <linux-erofs@lists.ozlabs.org>; Sat, 07 Mar 2026 17:28:20 +1100 (AEDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c738d327336so1558198a12.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 06 Mar 2026 22:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772864898; x=1773469698; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pp6459sEHgDvXHzZslA/d/z7MVfjL94uWh8GF3sNGHE=;
        b=kNM/W6ZRAm6RnxHh7hdJIi7lxhhCX0kOcPLGjSVKv98clEXqFpH3y7swXM9hQeik9i
         ORFlZrlDwP3Stsg+C1GAxk/awWckhMua57kfkdz57y8LLlmWHcqP9aDrUNS57rdbhPKb
         35ZBI4PtdtIWplJSQjW3tGWia1YpsWoFwPJhs7VveMlN6S+6iRwGHdCzqx3MS7hTFSjR
         estqTPZrqY7Xk//G5aors4mCBcfUDOaji9U0S1vaFD27DFZrE90Fv1U6MIisNns5x4sK
         u7wXXywDhk9qN2GwmH6X7oMDrMkC6udrYYM7VWEGEs8mWWUHQS8wlsNJZWAUx0tE0+8Y
         ucMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772864898; x=1773469698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp6459sEHgDvXHzZslA/d/z7MVfjL94uWh8GF3sNGHE=;
        b=m/RHefSvXHhBnmIv6XauSTOoSwePA3zTySP9gB9WyrOads6tgi+sAXFWcD2lVKE+wM
         dP4P/VoW5jBlO2Zq4nttghbp+qCPoEjpDXj0EUQ8Q/6OcnLNks3CPXpmYTkssIcB0hno
         JFa9o0R7SCisbsuiACbOlVTucAsu2mOAA45k1nLEPfnUgcc2MwSrgrfOf7OQQQArKvQf
         kR7itujkwurrvFN6ym85jAfaLAspb2wihlOXsJJDvlf1rBThBHRVVzAZjJa5xSjOyovx
         S/L8WWiBvPhtPiziVSbhVf3zeKNOWmKVgn/i6Hv5CinSFbe94qs/peEtRnRCjiYyP3RX
         lZyQ==
X-Gm-Message-State: AOJu0Yzrl/j+cBhhLcUzkir12G6MM0l8Urie3vz01XBa3JZ8up4EK9TN
	8ftQ9Kurvc8yg7L7VSZlDgCLt+8lXCrGcvVUj8wqTthFL+H9b8Fwd4Mkd9AOmJAV
X-Gm-Gg: ATEYQzytv8csJ04GsvNXS0OJq3dy+c56fDnwSwTZNLGoH7se1+zqUEuA6VEJTwwL39A
	Dn5BozTvs45nOoQqBn64+d1cpRoFVr3O65+pg2ATgxBeBKwWTDycb3XmrcpN6sO+dtcV5AzTq4c
	wtqlWuC7CcgfOYb5Z1dL/gEyG443XLumwYNNKrLyTMIE4k/iMuie+bgKJrrGTPkg1uh1dtcoLZM
	u/3B3zX/o4vCekTZEOmkoAuBxEYAd5fYDk0nq0xJ7+ou83EqzlPLwY8CVb7tqXpy0OpWtvA/ukM
	4jmgNzCjQ2F6WmSEop8OEEOu2PhmM7xenKpG1jeB51Yv2cBjndjuZ8c5JExvThvBrwSy9Iv3Uhb
	9mXANu3fN+OQWCZjz1dFSwOBKVHrnTNKYp2xntoe3BKheNJCf4ptmoccLKeH/hhPvr7bJAi3zIx
	wsNJ6ty3T4ipOn1DfwCj/0JEs0HgEYmSs1tDCX
X-Received: by 2002:a05:6a21:7107:b0:371:53a7:a4ba with SMTP id adf61e73a8af0-39859009d9cmr4327894637.30.1772864897737;
        Fri, 06 Mar 2026 22:28:17 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e183020sm3163029a12.26.2026.03.06.22.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:28:17 -0800 (PST)
From: Nithurshen <nithurshen.dev@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Nithurshen <nithurshen.dev@gmail.com>
Subject: [PATCH] mkfs: support block map for blob devices
Date: Sat,  7 Mar 2026 11:58:10 +0530
Message-ID: <20260307062810.19862-1-nithurshen.dev@gmail.com>
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
X-Rspamd-Queue-Id: BDED022A604
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2532-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linux.alibaba.com,gmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Currently, using --blobdev to specify an extra device is restricted from working with the block map chunk format. This was previously noted as a task that could be implemented by mapping the device blocks using a global address.

This patch implements this support by allowing the block map to reference chunks residing on extra devices. This is achieved by:
	1) Removing the -EINVAL check in mkfs/main.c that blocked this combination of flags.
	2) Calculating the global startblk address for the block map by summing the blocks of the primary device and any preceding extra devices.
	3) Ensuring that EROFS_CHUNK_FORMAT_INDEXES is only set if the user has not forced the block map format, and adjusting the index unit size to EROFS_BLOCK_MAP_ENTRY_SIZE accordingly.
	4) Updating erofs_inode_fixup_chunkformat to correctly identify when 48-bit addressing is required for a block-mapped file on an extra device.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
---
 lib/blobchunk.c | 34 ++++++++++++++++++++++++++++------
 mkfs/main.c     |  7 -------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 96c161b..2ef7462 100644
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
+					_48bit = true;
+					break;
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


