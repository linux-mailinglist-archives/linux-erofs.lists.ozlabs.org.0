Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CC63A9995E4
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 01:58:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPmtl41X0z3btY
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Oct 2024 10:58:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728604733;
	cv=none; b=i6m50oe8D8GQJrAbUMw+D4eSDbLDjeEbVf4RFjFaA1lF6TMx/LNDjC6wZ2OLa047dtgLkqNci3355klsyasLvr/KwDOV7OinKPUtBTtMFMfSqXxsgvPr65BNIQq0stRIYAvsDk+GIqA8Qoj4gGugnfUH+kHAsQ7NLbMFexDX/LUtcDQFgRcjrKIu/XmB8dKkkTTbSpT/qEdEN7XFXiw5GVhg3ajMuDTinOgadfMrAoPkDlPZChY7YeuhzxnY5exafWBVojfX4Jg6TZoeWGGhzkAYsRcv4mlKKf2OSrKt3fOjsgqK9NJkbBXwv9+JcLwSZgu/RAI87ckPtzUYMYs7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728604733; c=relaxed/relaxed;
	bh=zbXq5dUZg+8cBo6+/cLm+yRxdzIzOWWwebxq2zDBn0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3a5SZjXxoPuGLVSvqe8OKSAJRp6j8EWeXbhj68Bc5o3Ac1XNmw8eySmbZULQdmJhJmm7e76zYF42J9SbrkUwrjNZo/XnffDf61Yxr9qEhvpDbU0jqu0gz5tf5bm9eEgj2xS8ildL+TlknnyXWugIv+vYqjyXXcstHd8Ci2/mkNbrk/L0eu/EmeIafJxpYva2HlRub/C9xZ+xXbEz6vrkQPz3oKo9oZailMoamhz1XCDTdRBcGvJKiyNZ0xJU2IWT4Ddcn4IpdzFI8Kerc8gAYmDnCBbWDF/M+K5EzNozYRBirri+mdhVLDExE4tt2vcBn3yZprxWr17IP3PUI+WQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vAltLOIm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vAltLOIm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPmtd5GgCz3bl6
	for <linux-erofs@lists.ozlabs.org>; Fri, 11 Oct 2024 10:58:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728604719; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zbXq5dUZg+8cBo6+/cLm+yRxdzIzOWWwebxq2zDBn0Q=;
	b=vAltLOImfHtWF92DdapCbsS/PfdkQYIWLyA/3sGX33AcuupKscC6BFyXUrBP/gHvYRoM7vdhBc9PS7hDvNWY9LJeLu8L4rJwnMdKVjGAjKxqNnkWkbbtCs2nDYq7JVJ+DqFHh6FpTBVZUTs2rlz3Z9HDu9W/Z0646Pw7fmY5/D4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGnpNaL_1728604712 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 07:58:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs: get rid of kaddr in `struct z_erofs_maprecorder`
Date: Fri, 11 Oct 2024 07:58:30 +0800
Message-ID: <20241010235830.1535616-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
References: <20241010090420.405871-2-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

`kaddr` becomes useless after switching to metabuf.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - shouldn't move `m->lcn` downwards since `lcn` has been changed.

 fs/erofs/zmap.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index e980e29873a5..37516d7ea811 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -10,8 +10,6 @@
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
-	void *kaddr;
-
 	unsigned long lcn;
 	/* compression extent information gathered */
 	u8  type, headtype;
@@ -33,14 +31,11 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
-
-	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
+	di = erofs_read_metabuf(&m->map->buf, inode->i_sb, pos, EROFS_KMAP);
+	if (IS_ERR(di))
+		return PTR_ERR(di);
 	m->lcn = lcn;
-	di = m->kaddr;
+	m->nextpackoff = pos + sizeof(struct z_erofs_lcluster_index);
 
 	advise = le16_to_cpu(di->di_advise);
 	m->type = advise & Z_EROFS_LI_LCLUSTER_TYPE_MASK;
@@ -53,8 +48,7 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 				DBG_BUGON(1);
 				return -EFSCORRUPTED;
 			}
-			m->compressedblks = m->delta[0] &
-				~Z_EROFS_LI_D0_CBLKCNT;
+			m->compressedblks = m->delta[0] & ~Z_EROFS_LI_D0_CBLKCNT;
 			m->delta[0] = 1;
 		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
@@ -110,9 +104,9 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	struct erofs_inode *const vi = EROFS_I(m->inode);
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
 	unsigned int vcnt, lo, lobits, encodebits, nblk, bytes;
-	int i;
-	u8 *in, type;
 	bool big_pcluster;
+	u8 *in, type;
+	int i;
 
 	if (1 << amortizedshift == 4 && lclusterbits <= 14)
 		vcnt = 2;
@@ -121,6 +115,10 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
+	in = erofs_read_metabuf(&m->map->buf, m->inode->i_sb, pos, EROFS_KMAP);
+	if (IS_ERR(in))
+		return PTR_ERR(in);
+
 	/* it doesn't equal to round_up(..) */
 	m->nextpackoff = round_down(pos, vcnt << amortizedshift) +
 			 (vcnt << amortizedshift);
@@ -128,9 +126,7 @@ static int unpack_compacted_index(struct z_erofs_maprecorder *m,
 	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
 	bytes = pos & ((vcnt << amortizedshift) - 1);
-
-	in = m->kaddr - bytes;
-
+	in -= bytes;
 	i = bytes >> amortizedshift;
 
 	lo = decode_compactedbits(lobits, in, encodebits * i, &type);
@@ -255,10 +251,6 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	amortizedshift = 2;
 out:
 	pos += lcn * (1 << amortizedshift);
-	m->kaddr = erofs_read_metabuf(&m->map->buf, inode->i_sb,
-				      pos, EROFS_KMAP);
-	if (IS_ERR(m->kaddr))
-		return PTR_ERR(m->kaddr);
 	return unpack_compacted_index(m, amortizedshift, pos, lookahead);
 }
 
-- 
2.43.5

