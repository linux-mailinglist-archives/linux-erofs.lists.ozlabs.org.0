Return-Path: <linux-erofs+bounces-1903-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D72D26CA1
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:49:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVqf51kRz309N;
	Fri, 16 Jan 2026 04:49:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499390;
	cv=none; b=iHO6AciaExzU0Xi53FmniUDT5SmPnpwrKItl1FJciZC3eEkRvJpYnY6k6Uj90RxpllVHw+ZvSrk4L/5x/aP8O6PLlPSXU5r7jB4aZTpCcCkS03/g21K/WYbSQNbTY66r7ghVC3X+75NVbz/o8DUmrXqg0bsHVGp103BZ/cMIDv6QKU91LD8HXcg7pO9aTT7E+i5Ti10D3auCq2OyKP2NIw1Y12epUREcBEexwFoGddOnaURgSqCfVlci8UEHdGF+WR1KBx3WnaoE/lZGC7PoupNhGj3h76tK97SfaGiPZNetfuSAptLRxkIVIhnu7icx8ueYZ5T9sW2o7OjruneLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499390; c=relaxed/relaxed;
	bh=gzKR2gyy2aIz+OBiQsjB1N9t5p79oZzAtsRciLpQc78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MZZbM8hgOm6sTsU/vQJwEUTEUivqWPmyiBSo7aesn4yld6HQAVHw/EjuD7wiAi5B87ukIEx/PGioBR4iKjUJzuvgmy/5+KcZMuFmMqLvLrGowSupp4gJGFC3K5Zbow31J0krm3naWQfOBLckOtqPOndqnsmWGoiJek55zpFzEviLmbgJabiDO2xVrAVGPpZTUHegwo6k7cIDqPsqkkByigIglC8YwRxLXpvVsVbforE9jBwovah7pnxCVfsjgCdrWw3pUWyJfxQXeOiO0iz09YAahd8BaHaZuc1KYaleXxd4A0fg+pP4snNpsfQwLx79XtpVTwwhlyqNFmuGb0RTIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXF5eSd1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HXF5eSd1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVqf040Qz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 687B844413;
	Thu, 15 Jan 2026 17:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2463C19425;
	Thu, 15 Jan 2026 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499388;
	bh=4X4oMdETf1MDXNVdTj8Mvnuo+gH/VRKi/jbZgD6BtXE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HXF5eSd16LXlk2pg+ykoxFtOltKLYcVhDbq4eu1qwmD9XuCNWEyYNq/SBbzMC2xZp
	 Us30TUq2Qf0LqFXcegPXmaUXk++IckN9SudLLGy1m2S/IWaC9Fe3O7QdJixMC/QzW2
	 HJf9rCe/ppr7ZNSUKpXLcTQLpiUAT0OY1jeKS3UdP9YlVuUmo+x7zxnsNV6KlYZ7IU
	 OaZtTAo6JUCABYVdaE5e1ipItaqt9i4ljmLQp4ZO65psdJ+V6VolZKMHaqtQRalSo4
	 sMz1xXvAVGjzhRpu823inA7f7eVi+tZrnpoSlK6flDgUJfBJnR2OMCIZpueoNVb0Or
	 MITNRwqqqmCUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:47 -0500
Subject: [PATCH 16/29] ovl: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-16-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
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
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=920; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=4X4oMdETf1MDXNVdTj8Mvnuo+gH/VRKi/jbZgD6BtXE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShIaOS03XvPpRfdi/+BkUUJRyp+R3CppMLW3
 ZiynNioo6+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSAAKCRAADmhBGVaC
 FSKRD/9yG9hD8ojJ6IljtJlzqxX5Mrd2/ao56DDsFXOA9FWMnwCaPHEJAENPNEWtwbmo+vNTjlp
 lQudXpKYDOeNMFVDBXjh6s7BskipekJgzjceXBd/7Z6OS9tRE/xrCWPE15WxooWzDH+MPSod03a
 dXyjbFBx/fMXGVLhHNec09c5PmN/AeUd28FN9pbOkV9+YFIABVgdQ4JjsdPqcHRpqcAiW6j5R1x
 HgNZYRunFukBcUwYHbHQXKQXMa7FEMKpQjmiWSpu4vL15ExPUoGC/AV541L9S3ZmMEFY2SqHxsR
 Fd/cWtvMpc0G5qWAV7q1qmHzpe5466KioKlFxu3HYEz3QVwWi2q2URf34dPKhYlj/SMZ9oDE3H6
 5ijLnuOZj7i/WgY+01ZxkNw0O8sebKJEN3+oguERhCG1jmSPmhERSbTg59Jh1Rpt6wU/eJ8MRSP
 mp5A0ii8f1xcVwyBnfe0wxC7fwXmPZorUgXv0TuPX54mAhzf0J+50OTuensdWi4sVgUyQ4Rv26c
 fUkFlkdWL6b67iWWqJHGyiPP/+lmavFA665rkX/WhAw4ATTVYmqKAJ3kI/M+4G/svV+Cq5ZxfPJ
 4W9/XSnk5zbuOwc/0/q/U5L4RAyIQDrojuGi7pHqgMXVPyD6jrJYx5YsZIgEyYbJcrMh6+zUrz0
 s2rdJhIgISrWcqQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to overlayfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/overlayfs/export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 83f80fdb156749e65a4ea0ab708cbff338dacdad..17c92a228120e1803135cc2b4fe4180f5e343f88 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -865,9 +865,11 @@ const struct export_operations ovl_export_operations = {
 	.fh_to_parent	= ovl_fh_to_parent,
 	.get_name	= ovl_get_name,
 	.get_parent	= ovl_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 /* encode_fh() encodes non-decodable file handles with nfs_export=off */
 const struct export_operations ovl_export_fid_operations = {
 	.encode_fh	= ovl_encode_fh,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


