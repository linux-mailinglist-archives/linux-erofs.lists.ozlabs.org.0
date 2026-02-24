Return-Path: <linux-erofs+bounces-2402-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDscO7z3nWlzSwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2402-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 20:10:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC9418BB45
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 20:10:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL6kb2P2Tz3cZy;
	Wed, 25 Feb 2026 06:10:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771960247;
	cv=none; b=mn1LJYj/jWSdhogFy1y67c1Asph/giluiwsuBdwNQJKkNwv6wRGrBhxpeAzV06sYCBacvRHecIWn4fcUOQG7iCRlWXUSaHaZ8Q/nY77/RmC8uw8W6uq5BXClrZ5I5j/HD7vQpHwjFxkHxfV/cV06npuSTBHpReEirHYJOQR8ROgdPvnL4NWgaXGOVB8d/k2J+0I+m48lH26R2G9D2JDiLk3rQC+j8/ORBTGkaAUgyti9r3dXh7C+UAE9eHKdNjSC+RBsQsvur0t80CRxj0SjtVuoxdPf2Km3biQpSHyQEHVynHaRZT8syPC4S7MFeX+lkx9QYBnhZdFLU40tq5QBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771960247; c=relaxed/relaxed;
	bh=mgvH6cws4jEPBBTIJzgmbCE3hBIeh3V2bG9jRih3MiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfFDpayhAvcEbp4Nawg7xG35rN/4P//Cjsigtzdmo0TCOMD3iL2X7PfboSbFs7w/0Ocr709fcNC4oVwsnMoHTGXZ5w5Lqs+0V/Gp+yTVHIvrMP0Bz7RH39VR741z6hjBY3soYOLJZq4s92aQ1CbTDmO8f4V0iC2VSdRwI2ANfJ+CmwrpSNflgMberVIvZWnL3t4LPb8vvKE0IdEpoFU5e09koCsg2XVsdk3R/Zxqk58RC/Naq2bAZMbEQrt3JAmK27YEDsFNL+x2laMjGe8ScY8XB1GNR2QRUc/BPGVTkLbkSRdDIHBVrHAeudE4L+9huVHytlnlN6QX2WDWXLN2wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l02WOaWE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=l02WOaWE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL6kY4rcVz3cZp
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 06:10:44 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso8013765ad.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 11:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960241; x=1772565041; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgvH6cws4jEPBBTIJzgmbCE3hBIeh3V2bG9jRih3MiQ=;
        b=l02WOaWE9ZFfuxYKca1TxaT8B+fqcnkJRSvs8Q1xK5TerZNbT6gcLLLspwq4Hp3bnN
         ybyobSsJZwfi0QkqNGFaqSLwKbhIFYoUoFNV8BEC4XcYMm52Sdr3hgILoLRkQhmfjMvR
         cGCoviL/F5iTLPSINE9KcBj+5r0h61OuzcmY09ms6FDLGV6xkQEWtFhqjQEZjraw7CWX
         AwxHVFtAAEPjt+ZhbohXmMHkxrtGjlJp1UPMOSgUgY4f2Myz1U3yFj14f7Wk9FIdw5dv
         S97gXnGrFrJW5jha4Z4Rot4Y/4KgsMWHCDhSalUapromBCB18ch5IJOtbc/zVL6NuRl/
         qgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960241; x=1772565041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgvH6cws4jEPBBTIJzgmbCE3hBIeh3V2bG9jRih3MiQ=;
        b=ohi/WD1cZetBLqQry/d/te3Rw6DtWRwVCTIroKO35VF3grrJw7pPoU4CG8Od1EqGBa
         +WXp+iWjIHE7PBUzxt2Dig4ekD3pi2QT0avuxjPCQ6zkLF68KEZA2FKfay/FU2vOv+BA
         tN+P0oZW8baEUQAxbF5xNAhScn+khiO7jcUMgQjq8JHMNBcsV/KqrStdTX43+4cbnD0g
         ejerXu3eBsl6Iz+eo7V0JokmjSRdmqT38JlyHzxv9bFM2VzfI/b6WR5oEkXIkY+yEm0x
         ygHT9G+d5hdYx51NJbhHZTjjd7mJqevpSE2arGo7csDMBFGbMu9V2EsPAFcCF5yhh/F0
         9IUw==
X-Gm-Message-State: AOJu0YxCtSCoUP/vF1aarJyloYb2lcxvSmgQpojku9I99QppHfQmon96
	kKHzcRMPsdr+vn5Y1VcylMTb8qJD9k5DIlVmZelEYuLnA/vnnteOnZhX2k5TGQ==
X-Gm-Gg: ATEYQzwzsMXA0aoy5Q1MZ9wugZ42lErqaYEzXIJkvq81FjlUN08LoDbvqf95bcJYPyF
	u67ueSDq/eG5yvmwfR/t0QCWIzk3Y23WgyBAhByVyTmG5yVMS2Gd7OrZhNBv0NQVwjNZNwmtVBt
	tGzR5mWyBver4CBGL7JIKkIcBu/wEnpWChkeK2wFrRTZJaIlcUy5wfzPeWPUxOqrK0Tqs8z/vav
	z0eMui8CBOvUvOldHA9lNcIa1DCL6PPun+8qfOXjffElVd8vfIWS8Br5nMimoSoh/o67uwRX2MI
	V2rerM75cH0exiF4g9k5jCB++uifAAuAEzrnqwz1G761Mp1bfb+G/0BjTwA7pP5DRB3ZkGK5H/q
	ojLjOXvGD8aqFiDWJNP8b8XMJxrcHzxsZE6lAfT82wXGCJrSgCgftuHPRn60P+VSXFq5hiyTFEO
	iYFDh9sXBLl2BNeOBJ6lwgzR33ogIuqCX7BsSYkr1Wo7ntKrdw3q/GpFbzvvpzCh97TKgeA4BsY
	VoLxqjTvlLmk14evHxg6J76hlTlXchfRHAc/y8Z8vM=
X-Received: by 2002:a17:903:3b84:b0:2aa:e817:1bd4 with SMTP id d9443c01a7336-2ad7453c0f6mr126509375ad.37.1771960241079;
        Tue, 24 Feb 2026 11:10:41 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7180613sm10935765a12.3.2026.02.24.11.10.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 11:10:39 -0800 (PST)
From: puneeth_aditya_5656 <myakampuneeth@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: puneeth_aditya_5656 <myakampuneeth@gmail.com>
Subject: [PATCH v2] erofs-utils: lib: fix 48bit addressing detection for chunk-based format
Date: Wed, 25 Feb 2026 00:40:31 +0530
Message-ID: <20260224191031.2171-1-myakampuneeth@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2402-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[myakampuneeth@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DCC9418BB45
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


