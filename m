Return-Path: <linux-erofs+bounces-2407-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCUJB0+nnmmrWgQAu9opvQ
	(envelope-from <linux-erofs+bounces-2407-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 08:39:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4F0193999
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Feb 2026 08:39:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLRLy4MMKz3cR1;
	Wed, 25 Feb 2026 18:39:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772005194;
	cv=none; b=CMOZVRHSJrDIjzjLwSiNWgDhC12EanBakDuCDTbO6G5rfl4oLyAccE0i4yXkdIBKtx0UiXcESd6Lz8cQdrmtdKb+8vw7UUbV9DMBfUwd6RM6yVRXtMxWAW+YjZmQF53DI1fGK9HE55rOe5AkWZXjuJcNTMt+fR6ff806PSuViz4JaTZ2xdnY86rmdhE+vwFMFuox8z/eu+dx8VYtQYwA+yBndpqkntMjxp6X0oMXUWS2aRsCVvZga8z+jUvxcEFGykpg6XUgiHyWeLypssucCEgfokS37GRaWXJHITfZqNiokKuxhhk/AGsAC9sgrqMucu+29CI8b+8w2Kf77fEAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772005194; c=relaxed/relaxed;
	bh=fntt341k0rk61FfshFn/Qy6xjR+2FQctelsvVEefU+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxYZTfUyoqlTSCOl25h3vq5+eKQgKtDQdASDWA0QpJEXT8zz2CJLHK+HivVhxWtpyjGwb4ALiltlb5Gg5lE3UQcKyvMDHecq6iCxIVH3JeuI3f1sz5YtWzKi+LR1mF+ibtIQXjnhgZeilIswnmVNHKc8YZ548YwNBhmpVCK1fo0tk2FXs2Mncm72KypETJ/4N83fyW1WJsvgezUZb++N+LgN+T9KZbd3PuUlcVQlZlQRmtIMC7beyp8EtTLVr++8kuBMj/7oCtInC0TpPTzwSkEv7Vc2jm/BaBR1YLhKStFDV4LKTDPEbDRYI5vXkuKH7ty4bSRY+qulM1+K98vTkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nHWSpKzA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nHWSpKzA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=myakampuneeth@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLRLx3j1Dz3cKT
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Feb 2026 18:39:52 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8230c2d3128so2714789b3a.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Feb 2026 23:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772005189; x=1772609989; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fntt341k0rk61FfshFn/Qy6xjR+2FQctelsvVEefU+8=;
        b=nHWSpKzADw6AFWLykwcFndb0kTbQy4iyG4vw0SgWnrD5lzPT1YADjDBWumv8ti0zkm
         Oj4GJNSvMinhaZyrjvMcvdUkAPdVfijenEPa/6mgb7nMGI2D80E61afKmS1z+sSjzNfT
         q3tnxyir/UuOHQ71O/AU0T8ZHU37y3I4R+Y3Vs/KEhjB8W2HzepFKXoxxwSwdPh8wXDy
         a1nJw5CQVWnAlXwOMtIO1lYImd7TVuZ+T/PavEOO1vbwt1/ATIxVvW3r+B5rL5qEwowu
         nRvYUcNmvvvhFsdAI1MvDVaTZYB3cz0XuJWpGsXBG50O1Mr9uLhrJOFbtDjGYv63vzfv
         /I7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772005189; x=1772609989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fntt341k0rk61FfshFn/Qy6xjR+2FQctelsvVEefU+8=;
        b=H1K7hUHb2fsuQwNQtHbkZg3cvygSPzGC3RLBQkyxTBWUakOGuxXIFtuxFBLYtN+Rfh
         +Br0j+ujLnIV7NWqgqlmojXqEMuqNk2IdbS37pHyGcOQWrpeooDTemCvv0XYz54ur6+H
         oV29cZZAOFLCsRD2IzOAvQ27FUKFwO5eAvandUjYd9SGhty9DTZxknaZM/00E/aDTOfN
         wvwbwJyoHyM8vZn/4m1y2xQNtVGM7ftJlkvUR9jqTyUVgZK4/1WuZQ5rVevBVtshOf0X
         4G4tQMoZRCxkqBVN9Lv5j8CHET66rkW2NgBU00uTh8bV+iF308q+aNz9IO22uDxYJRDB
         3oBw==
X-Gm-Message-State: AOJu0YwXHL7sqx7G4RC2rABJFHUzw6VMd3yH1VbGmwyIn4HJ4ucIqw6m
	4jef7MNa9jmY1lwP8ms/5gj5UZNLN5EtiBmiqXB8IWiyQ6yA6QnHO1uZSmew4Q==
X-Gm-Gg: ATEYQzzl5B06Nlq61DrqOBug8g0nlSigNYL07lHhMm8nNFOhqTOyI2Sj4PxMNxs6E2X
	/cNuxh7bNFdpdQ7XCQb4NrGOFlMPTOANk627s4Owmdo9RShSB8h4R2wEsXS6Mr83M0YSIrGWGLC
	Nj8lSpPcmFB17Xgr1N4810x0iMlI7bD1cDwKohP5sGH01QwBxTsagWLXshMU6oLdC8x4TU1cOM+
	YvJCKGdygKJGAnMRl3lDRM1YZ263qPKGgFaUE3XVCpJAnjxH1feCgXTCfoK27wZc2k3L97nPxRc
	sA8YrsLKq4C3WUcCg3pi4CN/EMOQThmaWXW3keqhmTJNXJ4EwN7YDb1ZEGdUxxGAGZp2iqlw2sy
	VXPSq0Hnbyc4bWwUhX+ajH0go7WEYZbLWgrPw3S9v+Vwg2d8k6E/auh0tsT6no/q6BzvPN2riAn
	9bZU4mbJJVNHc4FIiIjru6EIOReFw9hraNs+MJoekyDcWzjrF0n3f1qyhZUW9O7JUwrZDaf3BUn
	8HckvikqhIbzcHnYEpVJQMs8qDWcoV9q44XG4NaeHQ=
X-Received: by 2002:a05:6a20:cc97:b0:35e:11ff:45c1 with SMTP id adf61e73a8af0-39545ebee1cmr12167513637.18.1772005188824;
        Tue, 24 Feb 2026 23:39:48 -0800 (PST)
Received: from localhost.localdomain ([203.92.58.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3591342f60fsm341847a91.9.2026.02.24.23.39.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Feb 2026 23:39:48 -0800 (PST)
From: puneeth_aditya_5656 <myakampuneeth@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: puneeth_aditya_5656 <myakampuneeth@gmail.com>
Subject: [PATCH v4] erofs-utils: lib: fix 48bit addressing detection for chunk-based format
Date: Wed, 25 Feb 2026 13:09:43 +0530
Message-ID: <20260225073943.11361-1-myakampuneeth@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2407-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 5C4F0193999
X-Rspamd-Action: no action

The 48-bit chunk format flag was being set inside
erofs_blob_write_chunked_file right after erofs_blob_getchunk returns.
At that point chunk->blkaddr is the chunk's offset in the temporary
blob buffer, not the final image address. The real address is only
known after erofs_mkfs_dump_blobs applies remapped_base, so a chunk
that lands above UINT32_MAX after remapping may not get flagged at all,
producing a corrupt image.

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
 lib/inode.c               |  1 +
 3 files changed, 38 insertions(+), 4 deletions(-)

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
index 4a214f9..2cfc6c5 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -794,6 +794,7 @@ int erofs_iflush(struct erofs_inode *inode)
 	} else if (is_inode_layout_compression(inode)) {
 		u1.blocks_lo = cpu_to_le32(inode->u.i_blocks);
 	} else if (inode->datalayout == EROFS_INODE_CHUNK_BASED) {
+		erofs_inode_fixup_chunkformat(inode);
 		u1.c.format = cpu_to_le16(inode->u.chunkformat);
 	} else {
 		ret = erofs_inode_map_flat_blkaddr(inode);
-- 
2.52.0


