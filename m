Return-Path: <linux-erofs+bounces-1907-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A6FD26D01
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:50:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVr91Df9z30Lw;
	Fri, 16 Jan 2026 04:50:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499417;
	cv=none; b=NUZrbSMjeU4/KyX7b8YW10tZEUgL1JCK+HweWOKzaKx8yuM+UwIwXTX3/3bae8KMPvTScVLVQzESNUtemvg3gLx/PXz3dYvhKC88WALMjqr5HK2vvDNQkUncECcF8v6upoJwah6R0TsjbW4DVC4t5MVZWuddAp7uUzk3OEXohkB1VLZ8f4hn1+WQ82ENb4vMaYrbV8t0VXtT5ujyGxo4KvQ10lRn4B2elohNeFUZXjP7AyjA0bJbWYHe6Ptt6zQxATqr/hbOa+8d8jj3cjWXoQmGm3CUz9BHLl51qMJvPVRzYt0O4esWTbtgUct52olGON9zUPFfENFu3eBjWOQL2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499417; c=relaxed/relaxed;
	bh=ofTok/hZ9dw1JbMr5NBZWt/it5I8zRKreVKO3w5NLO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nf9IL9lHXlKldFogJzQf3Rm6lxGqfrPvWTLQv9psAHvuZA+BEq3mpUVu/NMqsb2ozk241qLJ4LCwfjw0cA9X6ZzpbG1qLZlA9HFKVmiN6sn+CuLSMSVUPYVyDC4BkOlKDRdTgVEhOtxFxF9iRWQycl+ugS4ZSfw3W9j2OaJqE2jLzXdpXh5gZGay23/YW40U/zJF3ekVEPo4C2MyF4xH4XG9d42xRy+E/jZu2wT60HQ11y4wF4izcsXeDn2wslPBXMJ4c2IjUsmfs3BWuu0twJvPQ018LjNqOcljHGBYktWy7OhucV4f0U0O+ZJ+n3JqDB/YNWqWCXbZQQ79FynCsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U4LOVrQz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U4LOVrQz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVr83MnVz30BR
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:50:16 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D503B4449A;
	Thu, 15 Jan 2026 17:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E799C19425;
	Thu, 15 Jan 2026 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499414;
	bh=U14CgwQNmpmYm/olsFPDmAvGebUpMmdXLYBcSiJQo68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U4LOVrQzZFDe86/JOIxFd/oTbsgvDFVbCPtnJNbJV62tNETnGVQcZbKoD5VbL/PwJ
	 f+gza7nr1wN/rVp0cfVFyiNPnmP2h7xyzhf0lL6Pgjbxf9ja5yS9DCJsGAyi5yN2sy
	 4ue0mFvkb23UAcEXqDIfhhT1l6jADXeh4D2GGCzn5vcFi47mkyVciNWNEAcNyEn+N1
	 1k+iUbFC4J/zNUdYYVPM6f7EiRxfog9ZRuVbC8ETpYpelIdZmtAzDehlXfJNHIhEL/
	 cTjgLsM7yaccBslJ6+uQ5W4Vwp47GREyY/Ad4dVxEPb6+NiRXZswo082ea/IHe7W0+
	 ZfuwxblAnAqhw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:51 -0500
Subject: [PATCH 20/29] nilfs2: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-20-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=686; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=U14CgwQNmpmYm/olsFPDmAvGebUpMmdXLYBcSiJQo68=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShJFbXOMj4js450jk2J72PWoFR/JR82AXdQy
 iwgyzXU5QSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSQAKCRAADmhBGVaC
 FSZYD/9uphGdzaGvn2dg4Bd0XX2b8qmIqlYBiw03MYG0trIn0ktMmsuP2fx7I6z6kbKu96A8Sia
 mP/7efimfs1aKaZJr6B3/fmOtBpqwhnDS3kgWOTBu8fDTe5QrkDi+ctDvRVYiIfrAN3+C8bAhrA
 iNy5KeyzvhYkJqb2hf+fJ/zhXqNbv260P6SQ05cNKI9yOiqNnb8npWxgwD/vxA72R0KLkPQngA3
 0iUAXySskZKvUAw6bAmGwc6TeACjpDeXWilP5zP1ejD115mBHRoyPjyH7E0UBwhi/ZwqrQh0Yli
 Q1rmIL1WaF4AqtEA7W1a1ZRqFZwrIxu9SiDRp5xS097OtKgyBRM3YcLEz46iyWojw62Vts/p1yd
 5Zwt0L4bpA7o2oY4CduvIzH4qaBRWnl72mLRhifKBY07v4jEXZo16rcfN1R/TrHWYnvEGK8bVOH
 eveMdSkU99tj3mokzFwkv0xuTwrFRi/Ybi4/OZ3qZhPiaw8jgKHBTSgOzBny17yPp9hLsv3yQoa
 MdwJ48ubetO5oTRrxG5TJQpY6oLaYJ5DfnsyAbylsupYYb7doZ8JEhdLu7WxLMTcUEY06PSoVR8
 Y4467ix83xMvF/LKJBQiPwr5dYhMyx6uNDY3V4tsPAsxBsBErVvgWXjOygYx4my2qfERvrWSmjA
 a18liGFzln9M3yA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to nilfs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..975123586d1b1703e25ba6dd3117f397b3d785c1 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -591,4 +591,5 @@ const struct export_operations nilfs_export_ops = {
 	.fh_to_dentry = nilfs_fh_to_dentry,
 	.fh_to_parent = nilfs_fh_to_parent,
 	.get_parent = nilfs_get_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };

-- 
2.52.0


