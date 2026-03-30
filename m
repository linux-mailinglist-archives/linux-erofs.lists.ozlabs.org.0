Return-Path: <linux-erofs+bounces-3124-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNXENAfBymk//wUAu9opvQ
	(envelope-from <linux-erofs+bounces-3124-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 20:29:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52835FC02
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 20:29:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl0C72lWFz2xSb;
	Tue, 31 Mar 2026 05:29:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774895363;
	cv=none; b=SarPZMIr45+lfYVj8BIebwz9S6+yKgtqb2DMNfEig7YNmexW7k3GREu0b66/ml4esBE88aoRZKrVmS6KYbSOvzfDC0AY/3Q/w5OW1eNZIFAn/PBWDRhzv7d/7e4FS4Zxz6K2f5h0VTK1053vxxctMdc2Hz91ImnS+A1ltt17XZJFkX+LsCZ59bogDBZ9ZKP2hZDDW7f8ZwkhSuZKnwzgrQBTHuUnLAji5B3ihqvFsb52Gg7aZQ4Z2pkUPryOmBOwVE2mQu4EAbrl1K4PYoDo/YVV/p5vWXJTqV9hneGCCc2y9B3kQLwmKWRw8PaN7/DKk9IhECl1fV3Bm0qsuU6OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774895363; c=relaxed/relaxed;
	bh=lHt8IA3toLF67omY7bueVbNNVsRZx8i6ryejlWFYKaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dil9kOtFZ/1UI6zz7NeeCBUPQ5zu7Zw+n4K0V4Hq6m8CJ+aHjIQ6bnggWsMPdzuhG6She8RzzdQtBK7bs2Qr267ICGjK0P/JPmoxbk6qHIsDhUl5JipktvihA4JQbvNM9agM6/ByJPihTEXkjAVJSDDBBfBBlpubpdQOw4yEiWkKqYkG9FWhRBSzgFX4itX73E5fFzydPE+M4VnYrvr/eQcliMOp8cGuGvbzieWEsSGrzKc0xUiNqhl1b7aZFyzQtIDhvAIQFFc13yppru9u7WHSz6d2pZAs/BqBDjAAlSq3srYNexUeUnUrI/+EuvYMqhIq9ohezTtXzJOu9ZpJSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bhgY8JnD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bhgY8JnD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=aghi.saksham5@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fl0C61N0Hz2xGY
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 05:29:21 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso1713981a91.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774895358; x=1775500158; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHt8IA3toLF67omY7bueVbNNVsRZx8i6ryejlWFYKaA=;
        b=bhgY8JnDNG8Lp3u/nZVAvsmuB+gPH1LReKcune6+JujHNnYXDGCdrC6zfRbgV7ezD4
         txNDvQ/ocwQ3n0JHx1ta6pOZXXJA5BLrNXuw+aM/4TzfxLkqMdM3fxx8l91ipvasZ18l
         GxrKZF9nmHhcVREi+DrlKd8wBRdtMef/5DFIyaWMS9snHzfTQ3uepzaGvTn8X/6hlKgP
         6hKUIB3Q7h92jCjiIr6NFtREz7pPJLsesaDYiMEXh4b7u8WvaXoz89EVgvlFiEUZH+RT
         TxZEIwXxYzus3e4/S35a7VWDXbj3198E+YJjLGHXk1hV6mRU2JUBhiNYk7G3KJCZzv+4
         MOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774895358; x=1775500158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHt8IA3toLF67omY7bueVbNNVsRZx8i6ryejlWFYKaA=;
        b=aG7XcTU7JQTsiQsjkIdSenx6vgmDYnpOC1RW5ZInf32ddj/Cg79Bwa+w74grqdtTln
         r7ZIVlzEtS1rPQHG4oXLd5MbDEVNTK/eJEqqK9WxFT4vlbmwEJKCx19GopezTUtqMiFs
         QtYdAa5tt0QhWZzscJWFadCZ01MpSsDtv4M760Yfkx3L6e/+Rl4XpUnbbq3fkIHN1M3e
         aTWoWUGgj6J3YcPj8VRgjfup6IqmtkS3A13lhZE8STiKcn0G+jO62NJu0AI+QsvlpF3h
         Bc0J3bOxpasqXdoIzEuUItr4ygK3Uj4enCrnLnC03Mq0PSeTSJfOJkBOYJnO36RoDMtP
         OwKA==
X-Gm-Message-State: AOJu0Yz1bWHe8gYxf4DdAf0QgIEwy3y9WwRg1P1uNZur3TLmfMtvgE/W
	WqNSfOoCg2Zw3pGh/f5NbFAcUc+wnwWlK9hvIaB/jgR1YbGibabTpUbm7ZMpSyxg
X-Gm-Gg: ATEYQzxsgnbGjEgjMqu4VGSbeLcANrWml2+HrnsvmJNg+Ev1GzxWnUVUr8Ck6bZGBzi
	nDcVc4zO/gZgbepg0Z9PlAcLrtyBi6HJMeag8luzS4rAWorHctqDo44YUOYJCjUYgjmfm3a0GX4
	DJPxqcWTSvEEKO23WKbUrQSIo4GMq2zCqRKmdsnhTAZxYDxqEeTH65A8RgkW4V9RqfMOOMNS3nb
	mUlCeykmpc2CQDf0Y710GAE6NKB/KF4IE//QbwhAC+uLz6+ZqwmKh7Xr6vCeebS+QEB81xoRfG6
	mX+you7cOhnjGDHiON8Mt280T30YxZ8XsMtgHr2XqDq6aTFgNU5Ue31en5YDIXv+S5nD5D3vN5R
	3ZraI7LRju+axjgKRTuQ9oNxdggu9yDZRXUIk23OAXCW89tf6XkklUuci/9/A3YKx06ja1GJpZb
	Itrx8EPwhNixP/Mdu0xcQm1le02VKPVCQcSw==
X-Received: by 2002:a05:6300:2189:b0:39b:e44e:d4d0 with SMTP id adf61e73a8af0-39c87b98248mr13710376637.55.1774895357770;
        Mon, 30 Mar 2026 11:29:17 -0700 (PDT)
Received: from kali ([103.212.138.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bacc2sm7044325a12.26.2026.03.30.11.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:29:17 -0700 (PDT)
From: Saksham <aghi.saksham5@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: Saksham <aghi.saksham5@gmail.com>
Subject: [PATCH] erofs-utils: support ztailpacking with encoded extents
Date: Mon, 30 Mar 2026 23:59:11 +0530
Message-ID: <20260330182911.22780-1-aghi.saksham5@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-3124-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[aghisaksham5@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4C52835FC02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, ztailpacking (inline pclusters for compressed files) is only
supported for the legacy compact and full index layouts. When the
encoded extents layout (a.k.a. non-compact indexes, Layout 2) is used,
the mkfs process explicitly skips the encoded extents path if
ztailpacking is enabled (idata_size > 0), and there is a TODO in
z_erofs_write_indexes to address this.

This patch implements support for ztailpacking within the encoded
extents framework. The encoded extents layout is more flexible and
robust, especially for 48-bit physical addresses or complex extent
mappings. Supporting ztailpacking here allows for better storage
efficiency even when using advanced features.

Key changes:
1.  lib/compress.c:
    - z_erofs_write_extents() is updated to correctly track physical
      continuity (pend) when inlined extents are encountered. An inlined
      extent breaks the contiguous physical block sequence, so pend is
      reset to EROFS_NULL_ADDR.
    - z_erofs_write_indexes() now allows the encoded extents path even if
      idata_size is non-zero. It still falls back to legacy indexes if
      the encoded format is larger (returns -EAGAIN).

2.  lib/zmap.c:
    - z_erofs_map_blocks_ext() is updated to handle the
      Z_EROFS_ADVISE_INLINE_PCLUSTER advise bit. For the tail-packed
      extent, it calculates the absolute disk offset by adding the
      metadata size to the inode's metadata start position.
    - It correctly sets EROFS_MAP_META and EROFS_MAP_ENCODED flags for
      inlined extents.
    - When EROFS_GET_BLOCKS_FINDTAIL is passed, it correctly initializes
      vi->z_fragmentoff and vi->z_idata_size from the encoded extent
      data.
    - z_erofs_fill_inode_lazy() is updated to trigger a FINDTAIL map
      operation when an encoded-extent-based inode has the inline
      pcluster bit set. This ensures all internal metadata is correctly
      loaded upon the first access.

With this patch, mkfs.erofs can now generate images that combine
the benefits of encoded extents and tail-packing, as verified by
dump.erofs and content validation.

Signed-off-by: Saksham <aghi.saksham5@gmail.com>
---
 lib/compress.c | 15 ++++++++++++---
 lib/zmap.c     | 31 +++++++++++++++++++++++++++++--
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 4a0d890..7f723f0 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1068,10 +1068,16 @@ static void *z_erofs_write_extents(struct z_erofs_compress_ictx *ctx)
 		pstart_hi |= (ei->e.pstart > UINT32_MAX);
 		if ((ei->e.pstart | ei->e.plen) & ((1U << sbi->blkszbits) - 1))
 			unaligned_data = true;
-		if (pend != ei->e.pstart)
+
+		/*
+		 * Inlined extents (ztailpacking) or non-contiguous pclusters
+		 * break physical continuity.
+		 */
+		if (ei->e.inlined || pend != ei->e.pstart)
 			pend = EROFS_NULL_ADDR;
 		else
 			pend += ei->e.plen;
+
 		if (ei->e.length != 1 << lclusterbits) {
 			if (ei->list.next != &ctx->extents ||
 			    ei->e.length > 1 << lclusterbits)
@@ -1149,8 +1155,11 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	struct z_erofs_extent_item *ei, *n;
 	void *metabuf;
 
-	/* TODO: support writing encoded extents for ztailpacking later. */
-	if (erofs_sb_has_48bit(sbi) && !inode->idata_size) {
+	/*
+	 * Encoded extents (a.k.a. non-compact indexes) are preferred for
+	 * 48-bit physical addresses or when ztailpacking is used.
+	 */
+	if (erofs_sb_has_48bit(sbi) || inode->idata_size) {
 		metabuf = z_erofs_write_extents(ctx);
 		if (metabuf != ERR_PTR(-EAGAIN)) {
 			if (IS_ERR(metabuf))
diff --git a/lib/zmap.c b/lib/zmap.c
index 0e7af4e..f98512f 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -618,11 +618,28 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 
 	if (lstart < lend) {
 		map->m_la = lstart;
-		if (last && (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER)) {
-			map->m_flags = EROFS_MAP_FRAGMENT;
+		if (flags & EROFS_GET_BLOCKS_FINDTAIL)
+			vi->z_tailextent_headlcn = lstart >> vi->z_lclusterbits;
+
+		if (last && (vi->z_advise & (Z_EROFS_ADVISE_FRAGMENT_PCLUSTER |
+					    Z_EROFS_ADVISE_INLINE_PCLUSTER))) {
+			if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+				map->m_flags |= EROFS_MAP_META;
+				map->m_pa = pos + vi->z_extents * recsz;
+				if (recsz <= 4)
+					map->m_pa += 8;
+			} else {
+				map->m_flags = EROFS_MAP_FRAGMENT;
+			}
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
+
+			if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+				vi->z_fragmentoff = map->m_pa;
+				vi->z_idata_size = map->m_plen &
+						   Z_EROFS_EXTENT_PLEN_MASK;
+			}
 		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
@@ -677,6 +694,16 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	    (vi->z_advise & Z_EROFS_ADVISE_EXTENTS)) {
 		vi->z_extents = le32_to_cpu(h->h_extents_lo) |
 			((u64)le16_to_cpu(h->h_extents_hi) << 32);
+		if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+			struct erofs_map_blocks map = {
+				.buf = __EROFS_BUF_INITIALIZER
+			};
+
+			err = z_erofs_map_blocks_ext(vi, &map,
+						     EROFS_GET_BLOCKS_FINDTAIL);
+			if (err < 0)
+				goto out_put_metabuf;
+		}
 		goto done;
 	}
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
-- 
2.53.0


