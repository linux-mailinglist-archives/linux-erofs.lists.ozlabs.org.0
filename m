Return-Path: <linux-erofs+bounces-1176-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7DBD02F6
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Oct 2025 15:59:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cl2Cw045Vz2xQ0;
	Mon, 13 Oct 2025 00:59:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760277579;
	cv=none; b=eACVBueldQkWfFFWVYUfBTPt+OE84F/oZ+zPw/VHv/35L0OX77rVMeCHcKDAVKSUj2ACOIeg5q4DwcxrEEtBZm6D8YJcoZLvXIDsVxZkus9cEEhrpG343qzbqjb0VOS+IhKV5b9LOCb9jKLhhhle7TAqjH/18pAEQu2BA7+CRIOhe0T+AWzX9favI4JVXG5rvuWcKjnRLdYeNKJ7zeyQY7GHbNXh0t0O3XvonAI/IJUa1RX0rKt1DFEIvCIPIam1Q3EIFFxxqphXlw5fOxXdIdgf2xundfYldFlhlXOdo/PO0SvDE8C1Z1zG5qGx3Vmu9nsd3YZPtzBi09//pmbHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760277579; c=relaxed/relaxed;
	bh=C+3m6uNElGJ0/qN5ibv3cED1GoNXw5FqkHWx83H4/tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1aVi925ARsLWGwMnqQLlSB0Vt9MxDVfBaqVw1VUXAedARTtGZjPzEeHOXPkT788RhRYHAh2dAuT5K/7/GWX/6W2HoB/TQoyZNm+kKXkP+z+pBnH6DE/hEsWx6EweBNLYiguaq6q3JOwTUTHQpqTUEHy6Zl3VEd4S5yUmxrx4mbXly9KoxO6kL2h12bkBAKVwA/ibjht92W6+spVT6TiBxYo76zU7x2dA2TLOqW8ent8KoHE6onrryNn360goGSaPlS419C0yiBrduPlOeLKoydMGdgW60VeE/GWEQGkoeb8jOy/TdxYiUw0Nv/RtRBOgI4cv0vnOkcjcP53Xc83+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hUaCxwTE; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=hUaCxwTE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cl2Ct0YSWz2xPw
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Oct 2025 00:59:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760277571; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=C+3m6uNElGJ0/qN5ibv3cED1GoNXw5FqkHWx83H4/tg=;
	b=hUaCxwTEseCknDJ0EnAyj69839n/ffBYM1zYy5zeIaIojlX9j6NfnLo3IKwkqzjEhEpcPdsAmH7U4VedQ1othBzLpgeiCsb3CSDjA0KDXPC9XCnNnLvsUmSzMnlaNVWcq6FnWu/X6t5u1EjLjJmAlnR9gknMVBDoXefRYJqwyiY=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wpypp5T_1760277566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 12 Oct 2025 21:59:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Robert Morris <rtm@mit.edu>,
	Hongbo Li <lihongbo22@huawei.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH v2] erofs: fix crafted invalid cases for encoded extents
Date: Sun, 12 Oct 2025 21:59:25 +0800
Message-ID: <20251012135925.158921-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
References: <2cda3cc5-f837-4627-9587-051ed10839b9@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Robert recently reported two corrupted images that can cause system
crashes, which are related to the new encoded extents introduced
in Linux 6.15:

  - The first one [1] has plen != 0 (e.g. plen == 0x2000000) but
    (plen & Z_EROFS_EXTENT_PLEN_MASK) == 0. It is used to represent
    special extents such as sparse extents (!EROFS_MAP_MAPPED), but
    previously only plen == 0 was handled;

  - The second one [2] has pa 0xffffffffffdcffed and plen 0xb4000,
    then "cur [0xfffffffffffff000] += bvec.bv_len [0x1000]" in
    "} while ((cur += bvec.bv_len) < end);" wraps around, causing an
    out-of-bound access of pcl->compressed_bvecs[] in
    z_erofs_submit_queue().  EROFS only supports 48-bit physical block
    addresses (up to 1EiB for 4k blocks), so add a sanity check to
    enforce this.

Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/75022.1759355830@localhost
Closes: https://lore.kernel.org/r/80524.1760131149@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2:
 - `pend` should be converted to blocks and then be compared.

 fs/erofs/zmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 798223e6da9c..87032f90fe84 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -596,7 +596,7 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 			vi->z_fragmentoff = map->m_plen;
 			if (recsz > offsetof(struct z_erofs_extent, pstart_lo))
 				vi->z_fragmentoff |= map->m_pa << 32;
-		} else if (map->m_plen) {
+		} else if (map->m_plen & Z_EROFS_EXTENT_PLEN_MASK) {
 			map->m_flags |= EROFS_MAP_MAPPED |
 				EROFS_MAP_FULL_MAPPED | EROFS_MAP_ENCODED;
 			fmt = map->m_plen >> Z_EROFS_EXTENT_PLEN_FMT_BIT;
@@ -715,6 +715,7 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 				    struct erofs_map_blocks *map)
 {
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
+	u64 pend;
 
 	if (!(map->m_flags & EROFS_MAP_ENCODED))
 		return 0;
@@ -732,6 +733,10 @@ static int z_erofs_map_sanity_check(struct inode *inode,
 	if (unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
 		     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
 		return -EOPNOTSUPP;
+	/* Filesystems beyond 48-bit physical block addresses are invalid */
+	if (unlikely(check_add_overflow(map->m_pa, map->m_plen, &pend) ||
+		     (pend >> sbi->blkszbits) >= BIT_ULL(48)))
+		return -EFSCORRUPTED;
 	return 0;
 }
 
-- 
2.43.5


