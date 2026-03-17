Return-Path: <linux-erofs+bounces-2787-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NZbNG4VuWmOpgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2787-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:48:46 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D872A5EB3
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 09:48:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZlx64pCWz2yjN;
	Tue, 17 Mar 2026 19:48:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773737322;
	cv=none; b=dUbG7O/W80ns4EKjEDC7qmpumvv4eFNg5X4TjLwn/sbhRUNp+v5Wi1RWppg0c9oiFcpfRnzDcKplxqXkfMoaHqODurF/QzGqXG6ureCZvwJRXTam4ndLZM9lc7nueWhlp6JLIGqeOHeuY+TiFJwe3n4mac5KWZ2TjRKhJIOa+9IwPFafAXbgayuPLRB2EloUr6CSYMNFfOi50yFtBqN3hyU4yRjuSQMtt4cGhioq2XojiRKMSoTeyGQqxcX2z3EUIrt3MOvU/ntUVsK95OoBfjeFLMQmNF7jlq6tiTNqMoJIo6tknYCiXoqCIeFDEKU0NQnWEDglVeWhyEz8jwtcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773737322; c=relaxed/relaxed;
	bh=u7HOlEoMY0UoBawzZEogYqcGTajgsfa96C4azhYL57I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dLnfqUjx6gdAGA5y/1FMy+CIUObGIiQg2ts45EPQii9Orc+OPvnx6lkugohIFxrjV4xtXqNRlJrMmkxtxUckcxs6DOOhFkohYDwnr0H7yFqdn9B8FgX9IKo6fpU+tM3clUlLf/VEAwgieO7Z08DmnclYcZg2ZZRA9yPXb4zcYI8qGp6YaOv/k3asXrEzNaSriBykLdR4VmPCgVg2Ef3/uLey49z7SI8l/3hZLnmHrTdRxvqi2c/duDZo8IQOQOXuh/jwstrpnycvSBdCqEJX+yeyMwDBPxLZ6L1O3JPkBtYhMTSRBD7G1Dgh/xKduV3Un2bkjsWvBFjwK9Gl/9MIaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=moekU8Jg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=moekU8Jg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZlx41Zfhz2xb3
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 19:48:38 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773737313; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u7HOlEoMY0UoBawzZEogYqcGTajgsfa96C4azhYL57I=;
	b=moekU8Jg9kvtmkMSL83MD4jNuh/fcG1nvWm8gskui5Wt1DITvVB0kyu6q6wGD6QlZSU1CqTSMh9os8nYg63R9xkwNeOYkvw2NhWYnG8MUJ+1fD7G+/LNzSxlqhbOu7gtX48dWPSjgZ2VyuOScafWP/+zR9FBNMUaVvUkjLB9dgk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.APPE._1773737308;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.APPE._1773737308 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 17 Mar 2026 16:48:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: fix invalid algorithm for encoded extents
Date: Tue, 17 Mar 2026 16:48:26 +0800
Message-ID: <20260317084827.3228413-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2787-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: E6D872A5EB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Source kernel commit: 131897c65e2b86cf14bec7379f44aa8fbb407526

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/zmap.c | 66 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/lib/zmap.c b/lib/zmap.c
index 0e7af4e355e7..067e3ddd7cda 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -409,10 +409,10 @@ static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 		.inode = vi,
 		.map = map,
 	};
-	int err = 0;
-	unsigned int endoff, afmt;
+	unsigned int endoff;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
+	int err;
 
 	ofs = flags & EROFS_GET_BLOCKS_FINDTAIL ? vi->i_size - 1 : map->m_la;
 	if (fragment && !(flags & EROFS_GET_BLOCKS_FINDTAIL) &&
@@ -507,20 +507,15 @@ static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 			err = -EFSCORRUPTED;
 			goto out;
 		}
-		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
-			Z_EROFS_COMPRESSION_INTERLACED :
-			Z_EROFS_COMPRESSION_SHIFTED;
+		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+			map->m_algorithmformat = Z_EROFS_COMPRESSION_INTERLACED;
+		else
+			map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
+		map->m_algorithmformat = vi->z_algorithmtype[1];
 	} else {
-		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
-			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
-		if (!(sbi->available_compr_algs & (1 << afmt))) {
-			erofs_err("inconsistent algorithmtype %u for nid %llu",
-				  afmt, vi->nid);
-			err = -EFSCORRUPTED;
-			goto out;
-		}
+		map->m_algorithmformat = vi->z_algorithmtype[0];
 	}
-	map->m_algorithmformat = afmt;
 
 	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
 		err = z_erofs_get_extent_decompressedlen(&m);
@@ -647,10 +642,10 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 {
 	struct erofs_sb_info *sbi = vi->sbi;
-	int err = 0, headnr;
-	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct z_erofs_map_header *h;
+	erofs_off_t pos;
+	int err = 0;
 
 	if (erofs_atomic_read(&vi->flags) & EROFS_I_Z_INITED)
 		return 0;
@@ -686,15 +681,6 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	else if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER)
 		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
 
-	headnr = 0;
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err("unknown HEAD%u format %u for nid %llu",
-			  headnr + 1, vi->z_algorithmtype[0], vi->nid | 0ULL);
-		err = -EOPNOTSUPP;
-		goto out_put_metabuf;
-	}
-
 	if (vi->datalayout == EROFS_INODE_COMPRESSED_COMPACT &&
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
 	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
@@ -720,6 +706,30 @@ out_put_metabuf:
 	return err;
 }
 
+static int z_erofs_map_sanity_check(struct erofs_inode *vi,
+				    struct erofs_map_blocks *map)
+{
+	struct erofs_sb_info *sbi = vi->sbi;
+
+	if (!(map->m_flags & EROFS_MAP_ENCODED))
+		return 0;
+	if (__erofs_unlikely(map->m_algorithmformat >= Z_EROFS_COMPRESSION_RUNTIME_MAX)) {
+		erofs_err("unknown algorithm %d @ pos %llu for nid %llu, please upgrade kernel",
+			  map->m_algorithmformat, map->m_la, vi->nid);
+		return -EOPNOTSUPP;
+	}
+	if (__erofs_unlikely(map->m_algorithmformat < Z_EROFS_COMPRESSION_MAX &&
+			     !(sbi->available_compr_algs & (1 << map->m_algorithmformat)))) {
+		erofs_err("inconsistent algorithmtype %u for nid %llu",
+			  map->m_algorithmformat, vi->nid);
+		return -EFSCORRUPTED;
+	}
+	if (__erofs_unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
+			     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
+		return -EOPNOTSUPP;
+	return 0;
+}
+
 int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			    struct erofs_map_blocks *map, int flags)
 {
@@ -738,10 +748,8 @@ int z_erofs_map_blocks_iter(struct erofs_inode *vi,
 			else
 				err = z_erofs_map_blocks_fo(vi, map, flags);
 		}
-		if (!err && (map->m_flags & EROFS_MAP_ENCODED) &&
-		    __erofs_unlikely(map->m_plen > Z_EROFS_PCLUSTER_MAX_SIZE ||
-				     map->m_llen > Z_EROFS_PCLUSTER_MAX_DSIZE))
-			err = -EOPNOTSUPP;
+		if (!err)
+			err = z_erofs_map_sanity_check(vi, map);
 		if (err)
 			map->m_llen = 0;
 	}
-- 
2.43.5


