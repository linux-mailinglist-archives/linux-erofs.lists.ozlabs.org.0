Return-Path: <linux-erofs+bounces-1911-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2DD26D3D
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:50:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVrh2pj3z30MY;
	Fri, 16 Jan 2026 04:50:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499444;
	cv=none; b=nm7eNYgB9S2phSL2mZwncGWxLdvyyHrHmhDpaYOaH8M2hqsxm9zOaxikcsQT/29Dc55Wth6UmVAHOq6o630Qg+z9YN0QcHyaDPGRoWroVvFj+iJrI5qCy9BAv5FhuFXDfrupkGw1dEI3PRsP7wPvAqqdbwFyaOEOH1rlZGq1C+219q6tCpPM7Hg23X/KGGySh3ATf0I++N1OwcCeMjdZHLYpAcjyYESzmLM6cUGna9lyuW+FDCcJ08Quz5Adf3nlaZCYWaP+acZZ8tAhUoaBkY0+Mp/HqRW7XXj4AwaJWdkNGvKRGCVaA6OdKJsPymxTv9P+0TyzzqGIMkokilZklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499444; c=relaxed/relaxed;
	bh=8pOkEdlPgmNI34dyIZCKB6VF8ZglgCh5+XdxlfbEXzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QvaqJGecIzuiKDZ+rfM6UYmBAGa5yjZhu+HzSSmyVK6nx+nPJkKcOpcK7ki9DaPYhuUMpB/aUFcQHitY4TnhQCLnFF4irvL6bQ53Frb93i/6qoEWQcaZZAZ2rWG/Bwc1BgVM+8zJpZUgNJYQtzBGCYpqH1HjaQhKZw/SNNFR6XkmuWeNI+Z+wRj1BJky9oYVWDupST9kOd5MLyY9HG/dUEmLgFU6Z4e3Om5rIlUjrwzJqH7xxTC20M2n52UFPoWDwUmWfLu+XR80ChrKGjFIJPH3u7P4I/2z0UfQTlaHUoOS7VXsvm7WvtVk7doDA/tX8fP0d4pCsDB3JvfFBRdaCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vDbX3mGa; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vDbX3mGa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVrg2mn8z30M6
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:50:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7556C60167;
	Thu, 15 Jan 2026 17:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E44C19425;
	Thu, 15 Jan 2026 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499441;
	bh=i+7my1hIKzN4dEiJBuVJ6Xq5R7300GKAIzUA6le5LwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vDbX3mGaV3J17XgmaClvzPrir7rcZ3244jEyEMkg0ulRRJHe2lzEsEsl6v8ITObrV
	 WvkOhbgNaFo0/WL1grmWsd9hNTGlelkodJYte8X5Zfy6RlEbAVoND5Tq6LyWEqSfuz
	 r0YrXIL6lkDuTdzPDLpnxOz7z6Wh1fE6c9RhzNESyCG5HWxL0omGNAUy0P3QJIDwYx
	 oPZdKHZUG6U3Qkk2i+a1Gk0Yd1/Q76deryInYPHiVrIL7A15tmkN17tEIGtuwpAJmE
	 HoSOOj+qtSeBvhBwA86v5yb2oCgnDtqWCqqSQKXfOrWy5Kfo/GtlsuNj5uXjdW9Ezs
	 PR8uNNzO9mghg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:55 -0500
Subject: [PATCH 24/29] isofs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-24-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=i+7my1hIKzN4dEiJBuVJ6Xq5R7300GKAIzUA6le5LwI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShKBTZTAVUXXqyi6bJrxji0XIyjkD7JqQZY6
 wonbWMv0LGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSgAKCRAADmhBGVaC
 FUq9EACyr/b3KvTajXKKWcsw4iTSig7acGp/8un3L9dhMH4MPBenFoJ9AZtBo9TOeulQUWODwV5
 d0cHtwgvOQyQ5BYykoPeKH3Klf7jh974vbAUu9wNUoufhW31N1yHvp98Hw+1KjoJBj8VEd7xrX9
 UklYejwsyZtn2s0Y9hw+wdkywLFwHe1wdyRKYh2ayx657SSRqjxH18TcmTGkf23E6UiM+CM0AVy
 uFtyUv/kbGeSxYJs/4Y8x9T/gZ6Sth6DCZB3Cs7pJkBXwrtyvZTW1gD77G9M74xXIAWsxDJ8Eyt
 P46Fgt6ZLJlF31KqAGaMdsAQPitvRXAnImogjK3VhJX1kibYdHlLAU8bXjGOs6YTLyNpmLfulQT
 nFWxdkYrH8SZU8AcRZoM86AaPxosuiValXES5vL1ZGcW3dCh6Fi4BCuLqNiWtpCgMr3+Uzt2r22
 Phlyrr58r259LfLhbyZ9qeym2OKdm47S+FTpKKlEK68rS3/9mHOR8GdsY0AtTX3Y0rLb+LXfWtb
 MomTNKAZCecJIvoHWpsKO6lcrok1r1PZo21H11IAheF+wwmQuoVer+ihSNb/2rOutE+Ow3+K+rR
 HoHCt0GkoR97A9lJJVP6yvgQl5GmJ5jMsLZHHBEVl6tuCuNO642t+/h+BMzVGVlHNCEDNiH8aJR
 +8vy+LDJemHgrzw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to isofs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/isofs/export.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 421d247fae52301b778f0589b27fcf48f2372832..7c17eb4e030813d1d22456ccbfb005c6b6934500 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -190,4 +190,5 @@ const struct export_operations isofs_export_ops = {
 	.fh_to_dentry	= isofs_fh_to_dentry,
 	.fh_to_parent	= isofs_fh_to_parent,
 	.get_parent     = isofs_export_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


