Return-Path: <linux-erofs+bounces-1906-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ADFD26CE9
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:50:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVr32Jx7z30M0;
	Fri, 16 Jan 2026 04:50:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499411;
	cv=none; b=Q1N1SOlrjfdO6Yu2Pegu3Po+6xkzCANFgu4cu31BuAJ3THGxwysy5kh86h48Gx2+ymaOoNtyy7nYfTyBKA8JU8jX3J/3ozO2fRiha9Qm7tonYDUrr22z8XVCOBgH362wc5AgdY7X6KViJf62r7nfQFbbLFePaVQ4HNcPiNq471Hhk5r2DX4cLuAGbfaHRTyBpptvR16NIJj5keBmSGm7zGcR8HJnEFSgP3Ce61ML8jJluAasZsyFYMG2cSPLoT8NsLy9vn3GcpaZzFonMvzUgsSttFO8CWc/kDsPsmJ8lA2zesyY6ebOn36d3TW0CZ3ThndS+4KEeChmrXmExG4v7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499411; c=relaxed/relaxed;
	bh=o3PDjLkgcXJzDuu11ScoxsbNv2w5ZQFaQPWZZv+nmpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvR1h5uvyGXeMRPyJlz1mQKcJ3hLdCzMRBPavSqwyD5cWE7OCt+eWVGNIudtbNX2TXV+7PZLjPuPOR7k/aNb8i0Bc4AarPOkufRZodON2tPDV58zLIcqMEBps4i+lTSqfCfSWHEky5PHon9fxbLKVx/zSQ64b+czX+W/Kuxu1ApJl3/HpXPCkBxsr4nyqzbMuDU1iTKtgENg17k9MC0nQVoVX4NAkRYrZqRxRMNCFA3mlK2MATyPy+1hX6pKfCZZNJqQaRmY/vXmSFIFMTWBFQta6Hg/vp/4ytZKcS0Y5lS8n9sJZv0w7kuApg+XyYsT3pL4WjmTO6FisuEm8t7dVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HzaZLDCo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HzaZLDCo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVr23mN1z30BR
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:50:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A6D1601BB;
	Thu, 15 Jan 2026 17:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB285C16AAE;
	Thu, 15 Jan 2026 17:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499408;
	bh=ASJZAYmFtZFPW7zLvK0ZjL1I4NBdupfpmX/yzCsItik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HzaZLDCouvYiTo43CgRna8k0stYnWVggWRX+E7ITKTkQk6SqWtN2mAUd0YAGY8YFg
	 fv5e/by8LOrzChGrKfliZQ09J2SJ9WIOLLR193K9GSI9t/myHqGnT6ZAlWdt+Uzf0N
	 0rJtKvSWVHfJJqTWUhDArUuUXTS48/7IUyWI+5Qw1LrZ/CqnOghvhiGz/sBaMmfaWF
	 KwiX1CJgcy1laOLzsMhtzU5kB/g4fimS9XsKVcl1aEGTakFkmzA5K2zFUXcXPxk3eL
	 joGa56XKg7cKCx0g9tt2zVErEcJm0Vej01lMJF225kYkCN1zd7whNuBBNxCg2pN5G+
	 x8ukV6eAv9GoQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:50 -0500
Subject: [PATCH 19/29] ntfs3: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-19-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=702; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ASJZAYmFtZFPW7zLvK0ZjL1I4NBdupfpmX/yzCsItik=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShIkjDCKglCICLqHNwkybqhDZvmrtSF0SGBF
 LwETpg24QaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSAAKCRAADmhBGVaC
 FXMJD/9cA2N1WYI1YFIcrFPq4MChLxHnvueE6hwkxPc5K7vP7yNwnn65W6JbEp2ObLGTsNTKPYj
 hmY2b/q/WvxyA0jN2iG7UYGUrcmbm8lyfJERfWQ5WnN1+fOBhsMD2Q+TLMqnMgi99BTN3V7CHwd
 7FcYq1rjFMR7i/SoCxFhaVCqjz/9amidfbT73cjGr0kRadbn4rbsw/SLhVv9+z9iK5uyJ4D0blu
 t6qe9CQoAyjLl+Gms605lcENCFqAWP24jtTNmaS/vvulwuBaTl8c+OxHuOCzcH9colTYZUoXSLG
 amzf7eGV7BAAvedVjh+Ycdb0/GwSn9uu+Tq6iJbHTMQMQhpStolF6blR/PRlzWQ/TjYQ3k1VhT+
 0gnz7OR6GaIZk7FkEbKolcNoVM5mc60b9ZoATyL6jx/F4dczwq8Rsv3SqAiClgX+w8mU9dp2Jse
 SRzo1N+Zkj5xAutyPJHj14ERMNwpP2GQIeG+tUyGQ0NU8BqNcwvKIVqRChO0ozWDEaLh757srrM
 olAdLIVH7Rz+CEygbk+t1jGLoA3ywVL2DS5w14345MUe5Hy0DR3iZdpCUlGE+OsZWQ0+BQmmVc2
 Qt72vG0qGAZ3O2rom6X15ExyF6DZpXjgau/5XwvIGUCwEP72+KQ0B1HN2KFve5zwRDbiBxvD5/o
 incrg3kj2EjzIqA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to ntfs3 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 8b0cf0ed4f72cc643b2b42fc491b259cf19fe3b8..df58aeb46206982cc782fad6005a13160806926d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -889,6 +889,7 @@ static const struct export_operations ntfs_export_ops = {
 	.fh_to_parent = ntfs_fh_to_parent,
 	.get_parent = ntfs3_get_parent,
 	.commit_metadata = ntfs_nfs_commit_metadata,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


