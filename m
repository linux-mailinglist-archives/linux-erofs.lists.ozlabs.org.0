Return-Path: <linux-erofs+bounces-2014-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA07D3B0AD
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 17:27:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvwq42pX1z2yql;
	Tue, 20 Jan 2026 03:27:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768840064;
	cv=none; b=VrhoBKj1kV8hy1uD1OSucwgEwyuL+/rVWI3q2N0QN6YBJUQoOXe4XjRAK1TLDGvJUsAPFnc9tS8/225767WnzSQG/dGJfneqqQERIZyngFFXIQiXjU3YG0WfvhLMzstd+3iqyWRQ+TUOigtBAfeaSy+tZIIUVXl3R5ZQvljJm6Mkw94v111fhTQbPcXnPnS9QtJ1WfcN9epD2I0wa7HF5Drp09Pw9UlnpjdwBo5CNNLz62KyH1afNNTcy7UTkPP0RfovUq+YJ6MnzPjFWOfFYc4QRkG8nGo4A/x4Iv0sEWDOOTTV03byobBKGbqmd3sKPqs+IR11nUVhxFDsVmnamA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768840064; c=relaxed/relaxed;
	bh=2uKyHe9bvtS4rRqV9g+HwXpIhfVuwz+cxuTdSbT39m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kR5cXIwWbYzx3gxSQsrtXyDSCZrMtt00CFOeFwCJb/Otf6+C2UGnVSgL1xiRozylYR7N79XvkoYFoxnlboJMa3PYKP2/G8SrCMPs+xOhevkDmuU4nieNrBjrWBkYpVqaV/g29vhejUjV91vGbU6CCBBIdEAbcmbOMvZGCu5xRc4i/ie663TWtfw4GQvD3VGgKNSVPI9Lv6tYgbpexFNOwgaxBnl+855G3vZZdBgGobcYJR+PvJmB9lQAueMl2gnQYUJOtbCV0qIPlNb6ssgXnfBoLnj93+swlnYM8d4wpt9Nvna1vwunZe12L1838fpx8GeZUE4Uk2c2FU7ymXd4Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fhdBn2dB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fhdBn2dB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvwq34tM4z2xKh
	for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jan 2026 03:27:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D3F3D444E6;
	Mon, 19 Jan 2026 16:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DEDC116C6;
	Mon, 19 Jan 2026 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768840061;
	bh=0HPdHuxiDqTtA0YywSuVWS43ZS3BgDMq+Pvu7w00t7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fhdBn2dBdU8qsd9fov0W3cRwBs6xrhJwrMmju42vZTu0LzeOcag5Mdd3r7MGvyvhc
	 YG1QDMIXTVtBeBMOaWEDZkVVxwZu+EAfat7NXseb7Li2I0zzhNkCQy7u7LTQqy4eQ0
	 yFx3dacO6OxpJ+t20CfGLKs+fb+h+fjlnywsgqy1yVtebczKM3mdOFE/4kZavk2Q+r
	 UnXmGW0DAKOqCQ10ZePYNiGtJT1Pxx1s5rOAc4Z7h8dPo4CkiHrhax+111awiCI+n2
	 vSLb86fZMTxXENHYCelmDQ1/Gd/cB5QhTtutKl6phJthJ67CysXayb7i1Qe9n7+pWC
	 oI/oX14JZ9AWg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 19 Jan 2026 11:26:20 -0500
Subject: [PATCH v2 03/31] tmpfs: add EXPORT_OP_STABLE_HANDLES flag to
 export operations
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
Message-Id: <20260119-exportfs-nfsd-v2-3-d93368f903bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=725; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0HPdHuxiDqTtA0YywSuVWS43ZS3BgDMq+Pvu7w00t7Y=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpbltZJI9z4X2wT98SLfDh2LLMCfOso9BJWBaSl
 4V78G5vaYuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaW5bWQAKCRAADmhBGVaC
 FacVEACaj9MFO0nJvhnrbzJlVoaITK++8XVR/P/SlqYInzb6OApdrLCDaYj4o7clJSxoyY2+YXy
 nufOx/AFKfqW2S6FzC3wk0Amea2TLDHxNelOCx/2SIff9t15wvQiA4ZLxpYQVPPFLVxQK2GRK1Y
 GYWpk4R5NQjW8pI6fmnlB1C0Up+pudUOErMNmSgrXnGknVVaCMzqt2Wmc0wQ/KnpYYRDjqWzc9Z
 4aPzlAGV0DjDnRr7i1ILM6O7+x9H1+oqvDf5uPli/I699nETR/nnfhRR9ydxu2O/Y0BcZIQi4L8
 DWiDejEGM1IDAXwNfYeM2L24B9rzknRun4ykATk1QAYlBA8sjY2hW5RA1rtsopmXraY0wgLM+v/
 GF/ZzduMVkxw2L7+3SfIwl9IF4v8+vk8svrrLK2aDrvbA35RDe0QC55Z5Tp+7RGh0S9AL5Tpgz5
 RFL3t9hL/j+ejpsxX+/cYTzdyMe+uIzqVubH4KhniotJHOe3U+wPHnwZXvvfOu0QOutCllL4o4C
 pl735gbPZcgpGxib1cuKMRukAgWC60c2w+jfYn3Vb+VyhwXLbEh8Vg9K7yMsSHYubjYw3a+MP8B
 2PdQ1JkgTqMvc6gHLGaQrzIftI9HQBd8a3otzqg3wULPebh48F1QRniiGaGou9fA4+pe0fcaGK7
 9dnB8OyYRbW/VrA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to tmpfs export operations to
indicate that this filesystem can be exported via NFS.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d2bd47db9d7506e4d6a565e092185..c64c4410b4fd9961599a5ea768b469d8184e713e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4477,6 +4477,7 @@ static const struct export_operations shmem_export_ops = {
 	.get_parent     = shmem_get_parent,
 	.encode_fh      = shmem_encode_fh,
 	.fh_to_dentry	= shmem_fh_to_dentry,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 enum shmem_param {

-- 
2.52.0


