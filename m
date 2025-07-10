Return-Path: <linux-erofs+bounces-577-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D6AAFFB09
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Jul 2025 09:36:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bd69J30w1z30VV;
	Thu, 10 Jul 2025 17:36:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752132996;
	cv=none; b=oHbk5y5cT0R6XZ5Pgh4kIXHsKNcnqQehkTImhU/boj8oILl3msDG3MEh32ZSDxSpLcM+lfYNZUftxbhKrRbv9Wg/LGKyqTNuRV125cI7u8AKLLKRTp2FtdBkwi8x2QTrTk/FqjAfaH0BxJyp3ueL+bditsRSe7Iy8AaAEIjPC96BhiUWHqbDQILoOnJ662L1Xt1jTEJSpF5I3XeZukMGanAkPp4cMSoP/sgicQi0dOqbSDnIx/jGfXvfKhyk1zw8s2U/H+5BvPmdmo376QB0An1NH+mTsSpfYXvkiL87SE9Q2VQU6kV8dZ4msxS55KhKvTJFyQoW9dYumuNMxUDbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752132996; c=relaxed/relaxed;
	bh=vzlZj1MW57Uk++2C39s0gqx6pbI7wympbNtDHZtBET0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPDa+OSXwxTZ1TIXi4YvTaqY0zK7T4A72t4Ty8ikjFMTgZAoi2bU/8ehg4aCX6bBRIZ68PMP8cSAYU36jNcSzdYrEgcJqC8ikETTu0m/L34NsQPwEhPTnBh19mgre8TlnaBYOT97WCMPz+GKuUkEXLIz4KluIPVyYuNdlSlhW+eeuECs1wt4sLvAK65sUoZ78Maq/lQ397T4Ff6LgqpijyiC+xGhA1tI1Uh1pmQJQsTz5NihbBXiRAD+3INGw7FapEnb8Kvugpvb4J5J1aDleVnJZMpqM48iqShETGfsYre0+aIvQQhp4FGyW16uyzU271hTLgfMcEeVzPtjtr429w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=igEJIall; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=igEJIall;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bd69H6GCNz2yMt
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Jul 2025 17:36:35 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BDA0246E71;
	Thu, 10 Jul 2025 07:36:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE9C4CEF5;
	Thu, 10 Jul 2025 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752132993;
	bh=EyfNAvh03CoAn/icz+i7RWD8ZeXI4bLQ/a7yMcGGBy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igEJIallJCrdIn96SU3cVYajFQXJCQuXtKrVSyO2h5y6VvcUn/vg41J7bdrQX4FAD
	 8Acf0wMNYtwxilaLBlrNYyOEydp9u2nl3UbSF3eqCJFuQPkvj5UUHZhuKn1GJ8Z26u
	 zkUH+/9OpqRENbtE1bgdLEEQLHSgZ0Kp8bcuUlhM9i0AZF8tour+G/qvMZTriRKTWb
	 mny/0Knc4KawiHib5ND0ee8tBPu97Yw77WQujh9FkwGNq7EltHrmKN1DZapmiL97Xv
	 rO1lx6jlslt6EOleeN05QGSi+LuUpjIPy6PRVkcBftGRHkzJHL5Z4jCoZ6RSM8zkWd
	 f4s/RaQYyboNA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] erofs: support to readahead dirent blocks in erofs_readdir()
Date: Thu, 10 Jul 2025 15:36:19 +0800
Message-ID: <20250710073619.4083422-2-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250710073619.4083422-1-chao@kernel.org>
References: <20250710073619.4083422-1-chao@kernel.org>
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

This patch supports to readahead more blocks in erofs_readdir(),
it can enhance performance in large direcotry.

readdir test in a large directory which contains 12000 sub-files.

		files_per_second
Before:		926385.54
After:		2380435.562

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/dir.c      | 8 ++++++++
 fs/erofs/internal.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index cff61c5a172b..04113851fc0f 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -47,8 +47,10 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	struct inode *dir = file_inode(f);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct super_block *sb = dir->i_sb;
+	struct file_ra_state *ra = &f->f_ra;
 	unsigned long bsz = sb->s_blocksize;
 	unsigned int ofs = erofs_blkoff(sb, ctx->pos);
+	unsigned long nr_pages = DIV_ROUND_UP_POW2(dir->i_size, PAGE_SIZE);
 	int err = 0;
 	bool initial = true;
 
@@ -65,6 +67,12 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		}
 		cond_resched();
 
+		/* readahead blocks to enhance performance in large directory */
+		if (nr_pages - dbstart > 1 && !ra_has_index(ra, dbstart))
+			page_cache_sync_readahead(dir->i_mapping, ra, f,
+				dbstart, min(nr_pages - dbstart,
+				(pgoff_t)MAX_DIR_RA_PAGES));
+
 		de = erofs_bread(&buf, dbstart, true);
 		if (IS_ERR(de)) {
 			erofs_err(sb, "failed to readdir of logical block %llu of nid %llu",
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a32c03a80c70..ef9d1ee8c688 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -238,6 +238,9 @@ EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 #define EROFS_I_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 #define EROFS_I_BL_Z_BIT	(BITS_PER_LONG - 2)
 
+/* maximum readahead pages of directory */
+#define MAX_DIR_RA_PAGES	4
+
 struct erofs_inode {
 	erofs_nid_t nid;
 
-- 
2.49.0


