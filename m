Return-Path: <linux-erofs+bounces-2398-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEx9OvLTnWk0SQQAu9opvQ
	(envelope-from <linux-erofs+bounces-2398-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:38:10 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2C189DEE
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 17:38:09 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL3LK62QZz3cYm;
	Wed, 25 Feb 2026 03:38:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771951081;
	cv=none; b=Y6o8hk3q0WFWy18Fl6iNE1+ZaThVv+yXeAqeiyhtpb+MKidDovIU3iX+/nmmFB9m2usUfe3xFGJdwVIZwDUXnL0SfTR4mrxsjPge3YUcYfs+11u77a0TQoSdtmVJrFkjrwYwrHQIfjTpuWcy99UADt2mJUPHrKVqFH+P0eXkPIoUAH0gtMeU0skxCpU5r9tAdbj+md3c57dnxOiZp7z2gu5taNVmO/XYThplzy2hsJiNN5L1x4MqC1/q0WFTAqn8D8ONvZ2lgTrzxciiXmY+tFtzNoxk1l/e6Y5rkJ2qjveAyNbO+n4Uqyog6vPixYHyZ3dKeM8kgSTKjKAxS/8j5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771951081; c=relaxed/relaxed;
	bh=mgvH6cws4jEPBBTIJzgmbCE3hBIeh3V2bG9jRih3MiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hx6CotZnCphIBoMbNtln/WtJDEojHVsYuJFM9hufvdtP3eKvrrIu4RUMtoW7RBDpdA8vPhIYLXiobpVKiDtPgnthmkDZEtHdE/Gm6IO4VPU1MmRNnu5fe2wjqVK+aJsxrV8iVIZECVUgPtIS+O6k8bpMQhi313zp1KgKzjDDuqfsPwwyEEDuLQe9BHMfzHtR4El5nNpB1t9pjhW2enTFT7yZioVRUawz5dp7hV7f77DgXffBYbvscjz1osE0mYahUSdVgyol4Airwcs66WTjOFcC1kV9UUPNLe8Ou5YPfK3UNAk2YFnKq8iYvEwYh2YlPZJQZgXOh87H9VR4J8wXQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UhhkHTSw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UhhkHTSw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL3LK0FTLz3cYb
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 03:38:00 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-82418b0178cso3427147b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771951078; x=1772555878; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgvH6cws4jEPBBTIJzgmbCE3hBIeh3V2bG9jRih3MiQ=;
        b=UhhkHTSwBR4drO4luKXV7LarMFCdoK0DIuMRiHpUzpIvHdU+BeAK6pbw19r9J97jEt
         T/vKEHSPleKq0l6fGtmajvsKVZPHSbjz1p0EOemhxU6JExYgohBCdUOZ2oRVm7r/3ZPg
         pzt/CxgIc+estPpeOm0uXcxb58/JpudOuGv7vALTpmwk3gyu7TZibZ1cW1VHmR84atN2
         YAR4S8dPz32TfGK3wTLmCmGi6YYDcVFGbCJrbPQfC8rtd/bh+WfdY3PdVJvPfY9cl1KG
         pUyypzsZFB5Jyk6XPeLVvQobE4H2oFW4vJZkEpF8XZHrPlC6wqrN7EYP7ua4QViRf8oP
         hdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951078; x=1772555878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgvH6cws4jEPBBTIJzgmbCE3hBIeh3V2bG9jRih3MiQ=;
        b=ZRz+bdIUchhdB6esd1yMcez03ExDD2fQRe6chZxPCwMfQgnTS8cDkeaC0DV8V2IJ65
         PltDg6HLnaytbroEK2zZ5wZ0NDRbV+2Y7y2s8vOsrRecv4Txs1DnmneC60VyuS5SopTS
         rKK4b/mwdPjNNOvAlqZzIhWsxU1IUutibHll6nCG0f+xYUzqVAMwIrGUol/3j4bZUbqR
         1+mPv2ET14ZD1F6lVe8XdpY6xvZIPuWAmm0vG68nTM+V3j5xY3UYSviB64Mj1az+EEv2
         YzE4qLXJPOGBi51xIkU+Q+APmvEGLWBX4+bo5p4a+5EGo0LBgx3GpLCHQQMZ45PEAf3w
         URiQ==
X-Gm-Message-State: AOJu0YzAxDpZRksqEXNE5cj4GiZJorrOUErmjoGGwujfAtbkmXPvA3sN
	pxBXYuJ5G0Jj9MgWbVH+jLPnHaQltlG35NtCxmU8U2XAChXib5kdORHywwpB3Q==
X-Gm-Gg: ATEYQzy5sfSthtqn2hukwWQxlZ24/y152vJ7Ro0povk9OmVHtd3c/uZCo6WQU2Ek9Xt
	oQVO025I1JHR4V4KIclQ7fvPhiA+d3zNZxPqM/cKDn//B5c2eDCFF2LILRxw9gUlk4L0asGIJDh
	MwGY9au28U36Ov8eBlzTqsUB3X+aUhvHbWDCJhTvODxS12viz/lZ/xrD5Bal3ZHS5Yytaeu3iLA
	FYXls16R786aeMsozcWDIalxs1+gw5YQJy/vAUl9RSRNkrZB3w5HBaI6ABXPFjjNUGJ48vsf7ZK
	5+5BMg4zy1pZ/O40GgJLyRXe3Okk/PX5YYRRbS7fHvOhhhB/PvghPkzs7ILyZjMho+/sHcDI3wF
	RrcVbM5eTs8HMaUJPOgREQMxlVCWm8oyDtHG57DXDx7PpzREAlgyNW/sdfN3QKSsHNJzL2P6GKq
	tDTxygpW2vIEYQAJ7eCehhkqNZZm/7fMcqUk4UhhQcWgDFvbwtVKj0OpIBcwSxD7Y8
X-Received: by 2002:a05:6a00:1709:b0:7e8:4587:e8ce with SMTP id d2e1a72fcca58-826daaab0b5mr10896581b3a.65.1771951077555;
        Tue, 24 Feb 2026 08:37:57 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd87eea4sm12313835b3a.40.2026.02.24.08.37.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 08:37:57 -0800 (PST)
From: puneeth_aditya_5656 <myakampuneeth@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	puneeth_aditya_5656 <myakampuneeth@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: fix 48bit addressing detection for chunk-based format
Date: Tue, 24 Feb 2026 22:07:49 +0530
Message-ID: <20260224163749.32581-1-myakampuneeth@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224055712.14110-1-myakampuneeth@gmail.com>
References: <20260224055712.14110-1-myakampuneeth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2398-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: F2B2C189DEE
X-Rspamd-Action: no action

The 48-bit chunk format flag was being set inside
erofs_blob_write_chunked_file right after erofs_blob_getchunk returns.
At that point chunk->blkaddr is the chunk's offset in the temporary
blob buffer, not the final image address. The real address is only
known after erofs_mkfs_dump_blobs applies remapped_base.

This means the detection was unreliable in both directions: a chunk
whose blob offset looks large but fits in 32-bits after remapping gets
flagged unnecessarily, and worse, a chunk that lands above UINT32_MAX
after remapping may not get flagged at all, producing a corrupt image.

Fix this by introducing erofs_inode_fixup_chunkformat() which walks
the chunk array after remapped_base is finalized and sets the 48-bit
flag if any chunk address exceeds UINT32_MAX. The fixup is called from
erofs_bh_flush_write_inode before erofs_iflush so that the correct
chunkformat is written into the on-disk inode header. Both blob chunks
(remapped_base + chunk->blkaddr) and device chunks (chunk->blkaddr
directly) are handled.
---
 include/erofs/blobchunk.h |  1 +
 lib/blobchunk.c           | 40 +++++++++++++++++++++++++++++++++++----
 lib/inode.c               |  3 +++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
index ef06773..48fca63 100644
--- a/include/erofs/blobchunk.h
+++ b/include/erofs/blobchunk.h
@@ -16,6 +16,7 @@ extern "C"
 
 struct erofs_blobchunk *erofs_get_unhashed_chunk(unsigned int device_id,
 		erofs_blk_t blkaddr, erofs_off_t sourceoffset);
+void erofs_inode_fixup_chunkformat(struct erofs_inode *inode);
 int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
 			      erofs_off_t off);
 int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index a051904..96c161b 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -136,6 +136,42 @@ static int erofs_blob_hashmap_cmp(const void *a, const void *b,
 		      sizeof(ec1->sha256));
 }
 
+void erofs_inode_fixup_chunkformat(struct erofs_inode *inode)
+{
+	unsigned int unit, src;
+	u64 extent_count;
+	bool _48bit;
+
+	if (inode->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
+		unit = sizeof(struct erofs_inode_chunk_index);
+	else
+		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
+
+	_48bit = inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT;
+	if (_48bit)
+		return;
+
+	extent_count = inode->extent_isize / unit;
+	for (src = 0; src < extent_count; ++src) {
+		struct erofs_blobchunk *chunk =
+			*(void **)(inode->chunkindexes + src * sizeof(void *));
+
+		if (chunk->blkaddr == EROFS_NULL_ADDR)
+			continue;
+		if (chunk->device_id) {
+			if (chunk->blkaddr > UINT32_MAX) {
+				_48bit = true;
+				break;
+			}
+		} else if (remapped_base + chunk->blkaddr > UINT32_MAX) {
+			_48bit = true;
+			break;
+		}
+	}
+	if (_48bit)
+		inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
+}
+
 int erofs_write_chunk_indexes(struct erofs_inode *inode, struct erofs_vfile *vf,
 			      erofs_off_t off)
 {
@@ -380,10 +416,6 @@ int erofs_blob_write_chunked_file(struct erofs_inode *inode, int fd,
 			goto err;
 		}
 
-		/* FIXME! `chunk->blkaddr` is not the final blkaddr here */
-		if (chunk->blkaddr != EROFS_NULL_ADDR &&
-		    chunk->blkaddr >= UINT32_MAX)
-			inode->u.chunkformat |= EROFS_CHUNK_FORMAT_48BIT;
 		if (!erofs_blob_can_merge(sbi, lastch, chunk)) {
 			erofs_update_minextblks(sbi, interval_start, pos,
 						&minextblks);
diff --git a/lib/inode.c b/lib/inode.c
index 4a214f9..7a1d982 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -908,6 +908,9 @@ static int erofs_bh_flush_write_inode(struct erofs_buffer_head *bh, bool abort)
 
 	DBG_BUGON(inode->bh != bh);
 	if (!abort) {
+		if (inode->datalayout == EROFS_INODE_CHUNK_BASED &&
+		    inode->chunkindexes)
+			erofs_inode_fixup_chunkformat(inode);
 		ret = erofs_iflush(inode);
 		if (ret)
 			return ret;
-- 
2.52.0


