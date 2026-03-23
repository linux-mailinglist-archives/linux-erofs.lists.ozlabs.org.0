Return-Path: <linux-erofs+bounces-2959-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNq/KHxDwWnpRwQAu9opvQ
	(envelope-from <linux-erofs+bounces-2959-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:24 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3762F3322
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Mar 2026 14:43:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffZBH2KCpz2xHX;
	Tue, 24 Mar 2026 00:43:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774273399;
	cv=none; b=fQgUnhPmTuqMV09WNdt11pRErsIXvGedsYdg4daD4i8JiVw0mPkNCNIZVPg8a8A9ScqGslV1m1eJh4Y/GBg2dfg2BqgMYfYIb9uJaSDAD4n6Ei3fRujg1+W7GjU0d7hzXkvqpP6hwTHygnc/bsYpDBL1pbZlVt/wmhgXblX/dnFL3LklQVJh/yQT/O1aLHE5awv4iBQGjrBGhzCKpHX7TJyAEMJdHZ2DqRsRcChdjzTP3OEtf0htZZL90eYr8gfIEMjUHfUCFlW39r9TWu4uClKux9+Nu0AffiFhpnqOJSsyEJQJBk5zw/h2EhbdGW7Nf3jmc5rbzUSOrXi3rA2ahg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774273399; c=relaxed/relaxed;
	bh=qqq01aF0WRzDIVbQn/qohQ/4CC/XQZ5sW5ha6+M9wUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTrPsmQGrjzK5rIFJKEc02T5YSnqq2te+BkP85ki3IgGixi+G1bQzvyzAkiRObdhSZXMuweZR0evqYE2wBpTJLlT+/v9Y+gVOyGFNR0NiBnBvDX9x0PVywi55eUEL54JiTSaIKXh7GBmgfxW3kSIOwdSprPlCvnFtGbqsusd2yEOMB77BhK/lPNDqHJzUhvMXMMsQ4mW8SRD8qMMTsVn7nGj02M38HGQ/R8haymz9QZ8SD96jBwbQRZexwDVDYpifPviLs9IkQTELi8t1UBZH6noUse6tYqb9Vz2zBLQPxZtTyGnjD8tFJqUT5giVH7PEwfWaYe1XXj/0PJwbbMzQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VoDsbN09; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VoDsbN09;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffZBG40FNz2xs4
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 00:43:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CE9E340ABC;
	Mon, 23 Mar 2026 13:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8476FC4CEF7;
	Mon, 23 Mar 2026 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774273396;
	bh=E/d0Y9rfYY0+dgC04Nx9nfu7GqYdQ08cupS06mN5wu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoDsbN09sMXwtmEjBznr/DjH+5NZXB03rYwqJF94l0TN7M5DXvEE9lkeQnJIWnIg0
	 P2Bksc3DTc9nT7gUcmlv7OBwV4ORT4yTyyq+IxYso2dHaRpUMhUQSUCQ+iYW9EB0HJ
	 mOF+tmHgmC9jM5pkfmBwGiTIxGJN/eaam1OgV1COVzaSaq4Vb0zw0NZX12De6iCkjw
	 GhTXQpuF0/sCRTcw1XasCMdfJMDjl3sEbOETocuZ6vQvWv6xVbxXZje5kSDuo4GcyK
	 GC/c1CMOHPk6hkzrs2cvKz5Fdf0MUD/ARawstrLR1ddHyZzJOqai9JQDXvmfZxOTNB
	 wwmNFX4tmS6yg==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org,
	u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 4/4] fs/erofs: allocate data buffers on heap with alignment (3/3)
Date: Mon, 23 Mar 2026 14:42:20 +0100
Message-ID: <20260323134305.2675822-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323134305.2675822-1-mwalle@kernel.org>
References: <20260323134305.2675822-1-mwalle@kernel.org>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2959-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jnhuang95@gmail.com,m:trini@konsulko.com,m:linux-erofs@lists.ozlabs.org,m:u-boot@lists.denx.de,m:mwalle@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,konsulko.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0A3762F3322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The data buffers are used to transfer from or to hardware peripherals.
Often, there are restrictions on addresses, i.e. they have to be aligned
at a certain size. Thus, allocate the data on the heap instead of the
stack (at a random address alignment).

This will also have the benefit, that large data (4k) isn't eating up
the stack.

The actual change is split across multiple patches. This one handles the
"struct erofs_map_blocks" which itself contains a data buffer. Add some
helpers to alloc and free the struct because the data buffer will now be
malloc'ed separately.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 fs/erofs/data.c     | 103 +++++++++++++++++++++++++++++---------------
 fs/erofs/internal.h |   4 +-
 fs/erofs/zmap.c     |  29 ++++++++++---
 3 files changed, 94 insertions(+), 42 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2fe345d80ee..d10c00fe9f3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -174,32 +174,60 @@ int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
 	return 0;
 }
 
+struct erofs_map_blocks *erofs_alloc_map_blocks(void)
+{
+	struct erofs_map_blocks *map;
+
+	map = malloc(sizeof(struct erofs_map_blocks));
+	if (!map)
+		return NULL;
+
+	memset(map, 0, sizeof(struct erofs_map_blocks));
+	map->index = UINT_MAX;
+
+	map->mpage = malloc_cache_aligned(EROFS_MAX_BLOCK_SIZE);
+	if (!map->mpage) {
+		free(map);
+		return NULL;
+	}
+
+	return map;
+}
+
+void erofs_free_map_blocks(struct erofs_map_blocks *map)
+{
+	free(map->mpage);
+	free(map);
+}
+
 static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
+	struct erofs_map_blocks *map;
 	int ret;
 	erofs_off_t ptr = offset;
 
+	map = erofs_alloc_map_blocks();
+	if (!map)
+		return -ENOMEM;
+
 	while (ptr < offset + size) {
 		char *const estart = buffer + ptr - offset;
 		erofs_off_t eend, moff = 0;
 
-		map.m_la = ptr;
-		ret = erofs_map_blocks(inode, &map, 0);
+		map->m_la = ptr;
+		ret = erofs_map_blocks(inode, map, 0);
 		if (ret)
-			return ret;
+			goto out;
 
-		DBG_BUGON(map.m_plen != map.m_llen);
+		DBG_BUGON(map->m_plen != map->m_llen);
 
 		/* trim extent */
-		eend = min(offset + size, map.m_la + map.m_llen);
-		DBG_BUGON(ptr < map.m_la);
+		eend = min(offset + size, map->m_la + map->m_llen);
+		DBG_BUGON(ptr < map->m_la);
 
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			if (!map.m_llen) {
+		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
+			if (!map->m_llen) {
 				/* reached EOF */
 				memset(estart, 0, offset + size - ptr);
 				ptr = offset + size;
@@ -210,17 +238,21 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		if (ptr > map.m_la) {
-			moff = ptr - map.m_la;
-			map.m_la = ptr;
+		if (ptr > map->m_la) {
+			moff = ptr - map->m_la;
+			map->m_la = ptr;
 		}
 
-		ret = erofs_read_one_data(&map, estart, moff, eend - map.m_la);
+		ret = erofs_read_one_data(map, estart, moff, eend - map->m_la);
 		if (ret)
-			return ret;
+			goto out;
 		ptr = eend;
 	}
-	return 0;
+
+	ret = 0;
+out:
+	erofs_free_map_blocks(map);
+	return ret;
 }
 
 int z_erofs_read_one_data(struct erofs_inode *inode,
@@ -282,19 +314,21 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			     erofs_off_t size, erofs_off_t offset)
 {
 	erofs_off_t end, length, skip;
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
+	struct erofs_map_blocks *map;
 	bool trimmed;
 	unsigned int bufsize = 0;
 	char *raw = NULL;
 	int ret = 0;
 
+	map = erofs_alloc_map_blocks();
+	if (!map)
+		return -ENOMEM;
+
 	end = offset + size;
 	while (end > offset) {
-		map.m_la = end - 1;
+		map->m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(inode, &map, 0);
+		ret = z_erofs_map_blocks_iter(inode, map, 0);
 		if (ret)
 			break;
 
@@ -302,31 +336,31 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		 * trim to the needed size if the returned extent is quite
 		 * larger than requested, and set up partial flag as well.
 		 */
-		if (end < map.m_la + map.m_llen) {
-			length = end - map.m_la;
+		if (end < map->m_la + map->m_llen) {
+			length = end - map->m_la;
 			trimmed = true;
 		} else {
-			DBG_BUGON(end != map.m_la + map.m_llen);
-			length = map.m_llen;
+			DBG_BUGON(end != map->m_la + map->m_llen);
+			length = map->m_llen;
 			trimmed = false;
 		}
 
-		if (map.m_la < offset) {
-			skip = offset - map.m_la;
+		if (map->m_la < offset) {
+			skip = offset - map->m_la;
 			end = offset;
 		} else {
 			skip = 0;
-			end = map.m_la;
+			end = map->m_la;
 		}
 
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			memset(buffer + end - offset, 0, length - skip);
-			end = map.m_la;
+			end = map->m_la;
 			continue;
 		}
 
-		if (map.m_plen > bufsize) {
-			bufsize = map.m_plen;
+		if (map->m_plen > bufsize) {
+			bufsize = map->m_plen;
 			free(raw);
 			raw = malloc_cache_aligned(bufsize);
 			if (!raw) {
@@ -335,13 +369,14 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			}
 		}
 
-		ret = z_erofs_read_one_data(inode, &map, raw,
+		ret = z_erofs_read_one_data(inode, map, raw,
 					    buffer + end - offset, skip, length,
 					    trimmed);
 		if (ret < 0)
 			break;
 	}
 	free(raw);
+	erofs_free_map_blocks(map);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 13c862325a6..2e471d66c7d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -291,7 +291,7 @@ enum {
 #define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
 
 struct erofs_map_blocks {
-	char mpage[EROFS_MAX_BLOCK_SIZE];
+	char *mpage;
 
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
@@ -367,6 +367,8 @@ static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 }
 
 /* data.c */
+struct erofs_map_blocks *erofs_alloc_map_blocks(void);
+void erofs_free_map_blocks(struct erofs_map_blocks *map);
 int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 		   size_t buffer_size);
 int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 1ded934a5d7..3060b2e9ec6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -75,28 +75,43 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	}
 
 	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
+		struct erofs_map_blocks *map;
+
+		map = erofs_alloc_map_blocks();
+		if (!map) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
 
 		vi->idata_size = le16_to_cpu(h->h_idata_size);
-		ret = z_erofs_do_map_blocks(vi, &map,
+		ret = z_erofs_do_map_blocks(vi, map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > erofs_blksiz()) {
+		if (!map->m_plen ||
+		    erofs_blkoff(map->m_pa) + map->m_plen > erofs_blksiz()) {
 			erofs_err("invalid tail-packing pclustersize %llu",
-				  map.m_plen | 0ULL);
+				  map->m_plen | 0ULL);
 			ret = -EFSCORRUPTED;
+			erofs_free_map_blocks(map);
 			goto err_out;
 		}
+		erofs_free_map_blocks(map);
 		if (ret < 0)
 			goto err_out;
 	}
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
 	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
+		struct erofs_map_blocks *map;
+
+		map = erofs_alloc_map_blocks();
+		if (!map) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
 
 		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		ret = z_erofs_do_map_blocks(vi, &map,
+		ret = z_erofs_do_map_blocks(vi, map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_free_map_blocks(map);
 		if (ret < 0)
 			goto err_out;
 	}
-- 
2.47.3


