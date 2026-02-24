Return-Path: <linux-erofs+bounces-2403-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJBpFlj4nWlzSwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2403-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 20:13:28 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452818BB9F
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Feb 2026 20:13:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL6nc6GvWz3cb1;
	Wed, 25 Feb 2026 06:13:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771960404;
	cv=none; b=Q7km3uBdRy/2ftOqKnJyyZNdgYoPhlc6L4hn5uSfaIK3ACI5UzS0FUf3gRqFvsxjEcC95nnD1jwQyty/T7yDg0Tdu5Jh70nYJ8eLJC0JjmcC7EAg0yMyVh/x177jnsHm7ivgJXTohbjkcS62oAPE1yBwEiCsILBin/65r2Rc2o4kHsLg0zu5Rd9uNsBf6XJG/XCR4S0LKLKdNufdbD5DzM6zc1kSwOwUI6RTSDfL1QmhWLtcsxMFB+kNVRFse3vWYnjLu3RWFZcYxjR6/bhBXuf/dMTW2C4yUtz2028L6VDMtx3VbZ0h+QG7Ny5hYNApMWBr/iVS+pBjpIYNXZXnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771960404; c=relaxed/relaxed;
	bh=5ougKBhBMh/ZLkPpKrpMh2IFq64ym+cHzbHkr3G+2rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNysGHKiVJ1e/yVHRBDKRp+SE8dCtrikhr6lvki9gdVd7Mm2B9IJhm0ULmeQ1DgOMn7iqv+ALqJZxUq28Ca32h2pl2YmhmaK0F65IEsoIynD98PW0MENndXw6Ho+c0pi+he54ad19ufWLTkO1ymfQSJSVHBALL91avyQOqRHMa9SNKKarm+fOgrcYKDS/2KiqUyqxpBNBeptNl9Q090WgbS7g0nhjwAlngn4n+difhgUGCslPGHYzonSBuk57afnmDttSHfWr5tz6+xdcnmXCR5fJt+nDeyizJfaDhGAn/+sOkTHOVQdz9lZkw8eoQwGdxixKftcOoHCaSBnqlhBhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nIgoeONf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nIgoeONf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL6nc0fhBz3cZp
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 06:13:23 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2a91215c158so39475635ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 11:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771960402; x=1772565202; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ougKBhBMh/ZLkPpKrpMh2IFq64ym+cHzbHkr3G+2rs=;
        b=nIgoeONfOLeFRCPR/jmo9cZz7Xpj0NRWpi+W+imUnOE+iX5cPNRI1IFL32GgzFZ1mK
         los+sLn6/NCLcuQ5rS19V8NbUfjFQr1YvccGewW77LZ51JP/rQlv+Jyti7CAsQlUyhAX
         gCVLRUQbVpfi18787XW5eaojNls7PjVtWSOfZwqaeF0H2cL49dTKmzx2ccEwLr1GYebG
         YbmzQqZirQsQ3VwO4eh9KxrEBLyo4JNHY2nCpQ3tRlObyOZ9QCExdaVV6OldgubRB1Co
         e6/DBJQ7EdmbuL30n/a6kZvMnonalFu4VhJolL+u6BOaT+0KAiazjrfRvgdpw6mld0yJ
         JvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960402; x=1772565202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ougKBhBMh/ZLkPpKrpMh2IFq64ym+cHzbHkr3G+2rs=;
        b=DMuRqdQZVVyy3LtMLR/aDx7kLCL2rc5CorC3xo+rpOUP9fcS6H9+9pFNimDNHQUQdi
         HMTwbvIeaaCbZ2C1jYf9ELlC/q4pc+x3w/kwySGY50e0m5B2J/EZWPRgF3ftopiJLF1A
         ugZWD1fGWOpFKOvEFFnJQZlfkU+aEYk846HdSdSJUssN5RtcCwUjNsY9hJBlYHS8wWx/
         qEo2esCkGdFocbArixgU520JH5VyIe2+/GWikA9PToF3BubzBI4z7NjCLWi10jMKnLz1
         TQlzw84rljaodQM5LFMiUBjlJdL7/yh3T4pCgMWwCcwKAoRLNWywwt7g0CRMymI+tAF5
         ZTyw==
X-Gm-Message-State: AOJu0YxN1szPeKk8Wg26LviCVa5lwSv+OOosown2gm0385ny9r2u8Umy
	ogcKYRP2wLhbmNxS5kv3BeOLoyOQ1BxmMVQ7cKgeRAR5YS6UAuRVYKkJlJgbEg==
X-Gm-Gg: ATEYQzx6/84wATzmh8xSBU6ijsNMsr3UZ/GqmLa1/DDFnah7BIGh1OFAxJRoKYxmVF+
	u1kAYnpnQ721iGIDlPS/tRDPA832dlDIw+vEFM5PmCgr/VS1f4fsWuf6XEEntVW1feGefNadE3b
	opb4Njnch2ar2A4qT+8ypSuoAkB010BoKbp6SFylIcRZ8l6YInC96IZKFofUX53O3t4MsJEp16Q
	tssR//QYfzEZG1r4LixFxbZCWKav4R8oz29/pqOONeiJVWzqgBJjbLURa2HE7wfk8OHszc7Zzrw
	x/jXiqz1nr3M+I9kOrRa3xKcMhVgdDrIm1AxiFLdt4bhxYHHm4IN66tPGowL29xyb43OutZxskD
	LoBrHytcG7yXgbrKcpNZX90UWIisRW1DrfmwoiKCwTLJgJmo/5XspuWQuulJsvFqcWwA9lCqzXt
	55ZxRPWRp+suPbP2A72LWOTs07tATeCGt5Hk7k1S8jXEwHS3BO/gi5Gc77wa5aZ4408BdZiKsSN
	0B1UM+MR7cGiMN2WOlXHbQF4MtupvX2n5c8aCCwXeY=
X-Received: by 2002:a17:903:2b06:b0:2a3:ee53:d201 with SMTP id d9443c01a7336-2ad743e3e8emr111622665ad.12.1771960401492;
        Tue, 24 Feb 2026 11:13:21 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adbb3fda99sm12877115ad.35.2026.02.24.11.13.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 11:13:21 -0800 (PST)
From: puneeth_aditya_5656 <myakampuneeth@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: puneeth_aditya_5656 <myakampuneeth@gmail.com>
Subject: [PATCH v3] erofs-utils: lib: fix 48bit addressing detection for chunk-based format
Date: Wed, 25 Feb 2026 00:43:16 +0530
Message-ID: <20260224191316.2294-1-myakampuneeth@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2403-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6452818BB9F
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
erofs_iflush so that the correct chunkformat is written into the
on-disk inode header. Both blob chunks (remapped_base + chunk->blkaddr)
and device chunks (chunk->blkaddr directly) are handled.

Signed-off-by: Puneeth Aditya <myakampuneeth@gmail.com>
---
 include/erofs/blobchunk.h |  1 +
 lib/blobchunk.c           | 40 +++++++++++++++++++++++++++++++++++----
 lib/inode.c               |  2 ++
 3 files changed, 39 insertions(+), 4 deletions(-)

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
index 4a214f9..25087ca 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -794,6 +794,8 @@ int erofs_iflush(struct erofs_inode *inode)
 	} else if (is_inode_layout_compression(inode)) {
 		u1.blocks_lo = cpu_to_le32(inode->u.i_blocks);
 	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+		if (inode->chunkindexes)
+			erofs_inode_fixup_chunkformat(inode);
 		u1.c.format = cpu_to_le16(inode->u.chunkformat);
 	} else {
 		ret = erofs_inode_map_flat_blkaddr(inode);
-- 
2.52.0


