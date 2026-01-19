Return-Path: <linux-erofs+bounces-2039-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D476ED3B104
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:30:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwtX2vZlz3bhG;
	Tue, 20 Jan 2026 03:30:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840244;
	cv=none; b=mzyTe1vg43HQKViE5TIxLi7punBzIUtA2CXEqFyPiEsQHaS9EQ1/5B9+bir/cIODLVXXslKoSun+digY6Kau3twStA1AroRUenvfhj2jo8DEr2RHz7DRQmpAVcj/ghUlQn3J7BgAwNHX6d6J5QvWqg5boXRnwzKF6/fFIEewXbscvotqJS+SgkAvpVkCUe+okub99zBgV7mmXRS7HDAqLq34T+C7mHoOMRIm5jU1DtPmWZx5klz2awhyxOk30ajPHg0rzqHWNrROlXsLQ2eyP+6mFaTKU5Ts+hbPggZWYtO/HDejVM44xf5TqI2YjQ5M1f62TXpKYRH9egOm5Y8rag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840244; c=relaxed/relaxed;
	bh=yuTkwBieDaBYfiVvkErhMkdIL4UCbBwNP1dX5h4YmOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSOFlyX24G4YBgIzderN7e2RxvcqCbf5Pi+b7AcUBkV1XxjivZK9y2oO/ShrfV3zNEyhvQ3h7CvfH/WpXMcNX5ksDvwE7KXpkj/9Va81LajxderzlpdOozuqgAz7SHUqU8cuIk7O9w+3SqAe3s+JEiY8QOmwQdq+K+YTd2KbpWwKUP47WtwFlNScCbtaBJrnNuIZOSaxCXj9kqcqvtC7yw4UOUTTULe9poe1Ijg1Tg2rwL7x6DgOXu5hdSc1+y5G5bvMishu27KI6iQKCDVSrh69covFFK0t+Qv7mjJhFU6NCVP295cV0ewTGYWrHVZ8lRhP319w87DalQ5XIXIi/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L1drpzmO; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L1drpzmO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwtW3L3nz2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:30:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 609BF6014E;
	Mon, 19 Jan 2026 16:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B28C19424;
	Mon, 19 Jan 2026 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840241;
	bh=Zmo+do6HqZsZlZXVQKKSsmbSay6qOtqCBcv8Ip3ODxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L1drpzmOZwhS7wO9cwa19VSsy80i40QcyZlAaGZK3Yn+eev1gLy2tMLiqi6zsQpcX
	 g/gWqsJHMJQgBaVzW4ZFeciI1NUhgPlNi5wWsbXGgGL4j0Uv4T4IPHTMt37mKkUYzz
	 UD4RtogawKHmef7uBWR19MHXmO2cT1auakcTOXeY4PVe27C6i68OoaNwBKad8GnDtD
	 d/nyC4L6XNekUDohSQC4guagkxmqlyAdRj+IVSfTfvVlbK4VUGfXBnjpoUTMP39dmf
	 w5jxXL9g7wxExeBthoaxz8pkLK5ytzCmZJipo8hAi1qkrPrOUFFDoHfUqo2F6DW1bS
	 Cas8WWW1oS0SA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:45 -0500
Subject: [PATCH v2 28/31] fat: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-exportfs-nfsd-v2-28-d93368f903bd@kernel.org>
References: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
In-Reply-To: <20260119-exportfs-nfsd-v2-0-d93368f903bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: David Laight <david.laight.linux@gmail.com>, 
 Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, 
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org, 
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org, 
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
 linux-doc@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Zmo+do6HqZsZlZXVQKKSsmbSay6qOtqCBcv8Ip3ODxg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltgaseKc8dYHUYRj77eGOmyavKVHMKU3e7sZ
 sLVNVNiAJmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bYAAKCRAADmhBGVaC
 Fe4cD/49CNUs86PH4v3uTOUHN5kkn9aZB4X8mzMOEw4J/AAiuF0Tml48ByLFtTTwHiqIZrKm2Eu
 x/gkwXTZvO40kPoyN5fIytK8K0yVjl09hrx8Rc9gwq0iGOtxQ7hdMwP35a/JbGT22DLjJONXGnk
 nRgl2lnb1Y2E40m4Hg8msm2FFmpQDusi9gIyl7OLVbIF5BHQ6tF+jnJ0DKHKQDN1MihKoHBbsXw
 OoxRSrcERSMtIY3oqeV9rzbmFmCEeOcFIM5XY+s2aMQE7vgt8BQKML+7avl/HqW+PEZHum4ZKu0
 a96hkWCBzhBniSGFHY78LpqWIV/41RMKi+a9ipC7ltAdNP69CN2VynIyliSsXbKcb85Q5RCaI6a
 iKydYxVLdL3c2SRkPqHe+m9LsbpCzRbOkEuP++7a45+g5/TU4Gcr+zfJ2ZCT5EsA8rU8KaXJBV1
 41BZcMEXMUTK98bUgMNZoBDlYca6mxL0Ldrru8nrqHr6JkrwGZrQFA7i+ztcA8+xSNKoUf7j/JX
 BDHFLN3lZrbj4ksk4mEN/6FV2y6MNHt9vS8x425TyotVmlwlsCG1NOtCndEL+VOZM/PenzdlEnf
 lFXckOYEqH6cS10AeacCinqqkjHbooveZGMvtPbqnMOniZUQv+cdXig9LrFKv+06zxNZikuiFlE
 F3LGgWPUpQR7npw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to fat export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fat/nfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fat/nfs.c b/fs/fat/nfs.c
index 509eea96a457d41f63f04480da32aceae75a8a4a..f6a5c8c4f5e8a14e549b5aad6643d490f1d062b1 100644
--- a/fs/fat/nfs.c
+++ b/fs/fat/nfs.c
@@ -289,6 +289,7 @@ const struct export_operations fat_export_ops = {
 	.fh_to_dentry   = fat_fh_to_dentry,
 	.fh_to_parent   = fat_fh_to_parent,
 	.get_parent     = fat_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 const struct export_operations fat_export_ops_nostale = {
@@ -296,4 +297,5 @@ const struct export_operations fat_export_ops_nostale = {
 	.fh_to_dentry   = fat_fh_to_dentry_nostale,
 	.fh_to_parent   = fat_fh_to_parent_nostale,
 	.get_parent     = fat_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


