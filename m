Return-Path: <linux-erofs+bounces-1735-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 52795D04D0C
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:15:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBPQ662Yz2yG0;
	Fri, 09 Jan 2026 04:15:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892538;
	cv=none; b=D9pMcpTUWs5qyjfTKAvdaBr46picH5fL0aTijTeKV0zNwuTwQmQWgVhS1DJaAq4nbk+sojBv+U2WKB30wJJzuPiMwPoSh/WRGXc7EVUFynMt+zbcGY8Rb+uWT4yFDQAutEkfrHF8XP1WFauCpn4MqgUlx5u9V3eVPlibYMAgFUw7Jh29KfqbIqLGuiBrcouDIVLWcZ+ozwNdVd49/hRUO1lNbVA2IXbUnTuJ/UjU+gp1rPm9qgYe819xwtkjrMmCs8rK3H4RqPW8GeEuD+GEZKNMXq0qwB0+1hOVv3/ZC64/ltj5KVN8jHlnaIfIXK22dNtm9bhUIuI5O0cFF2+PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892538; c=relaxed/relaxed;
	bh=+8EkRoG1L9zjgQ1DOKG9mWDwPpbdMkoAIHjT4aDgnzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlvDG+ahDnCZsMV/wcSyPmJM2u+4oh64/0o7o85+niw1noJmP9NtSLUt4fDSl49Fsi39E0BqQH5nEFrDVgnph3hPuvm27NIjbYSzxaLjsEd4OY61TJEIRlPCq9ocxWvNe3ICa/2j8CociyBFfdLQDhBtjuSsy2gc4LxZo77KqcQ7rI5SuVaL7QMjqBSunShkfF614Ilo849ilkSxD5U3MGfzx4OGpOYzxdv29KRdSr3PSeSd73CW+jnlOotgpAlMwtQVFGc5VkWtOz69CwXJXnHwB7en03DcGnV2YMH/sOxQXl5TXhkOw2dBjEjfaKSQCW3RhveuPS5OgLjnayUeAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TDNJcMd6; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TDNJcMd6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBPQ0nDMz2yFy
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:15:38 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BBCF417B5;
	Thu,  8 Jan 2026 17:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6360EC2BC86;
	Thu,  8 Jan 2026 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892506;
	bh=f+f4o4ynYy+1SY/DeVfHq3onGDbY5zceG5AUdIXzRFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TDNJcMd6q902mahde+BO9wSWmbW9wjddkU26c1KViTrFBxwUdgE7cFhjS0dNF3jtf
	 6Kk0r/OwVHpHX55siH6IZecEdrCSr2DCgPJoaSgr4zwLDXirwvkRHwnst7SJcRNLcL
	 WwkGp1R5Oplpg8ID0G3hFXMyazl85w3U9ThrzJUR7nvfo0YAzzC84krpqTWECQ9+lI
	 RRrPBQx4aAyUO/5pyOG0rGiL0sMaMgJkiuOt7MJqeLW4Ry9+VXvGVxqNaTjIopbLYy
	 hGMNCDe+LUdCUZ/AYoAp6mt3lNoGuFLlkAljMn08t1i7ZscD156Xj/ScCXO0oBfPnT
	 /HctkjSSFO3jA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:06 -0500
Subject: [PATCH 11/24] jffs2: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-11-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
 Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org, 
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=f+f4o4ynYy+1SY/DeVfHq3onGDbY5zceG5AUdIXzRFo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W7lCQZfgywIvw59WIEginzoekcq167e9p3d
 FIoynspkAuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luwAKCRAADmhBGVaC
 FdDKD/4znaNh5ZW6PAHUf642a8kepq5X6OHMfltH9Cc7L/Be4t+uhH2C2l8lp1cvjF3p8Rpi3oA
 fZ+dR9bUW5GRyCJ3+vRKjVS5PRDra8bHdHtEx7mCNQeTzUhsLWKmjFoTVQ+2z6Dv47T6ZmLUrOW
 vt2kqZpnLjWLWWiPlf0sOMJIeswKuv5uKd88OxRHUWG2kQSOKbcKfwQcQ4bjSnR08ZPqmkmOos0
 TrsoXeTh7E52Ttx+5nLskrvumsAUMiLfNpAYGRnh5zS9deqJ/icejX/Tnm8rp/HfMYW9lZY1JLS
 uAR1InznJLqI5Ra1WMIM+/c+6E9oW407IRy23SocSVro/Mua/BIjEJ7gOfORQmHMPu3+9VYfcyt
 Dlxsr/Vz8PDZc+xqqrW5abevesTWIHsXWA6cp0lDEJG3JmUdmpVGPJ8g8DK8clPYo/rFC+9xN2e
 w+Ol9y3A0g4mbiyDNQShnxdoWa8G24T+TC06gfvWatd7epKfvf+QiHukAAjTB1zsTXPxn1Y3LzI
 +PZQPSYmATnn8m8nyY2wkZ8htVVohDBRW85B3Mp8M3jnGgMP0L7Ea5mp1wDVPTgyjwmRTpNCdV4
 18aUPXvyTh8KR3P0CgCnGA73VzPVfWcUEJ10+JBd6hS248f5/wSH14zMU2VeB2iNpgDdkeSQKbE
 um2oXzdHyzfwuLA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to jffs2_file_operations and
jffs2_dir_operations, pointing to generic_setlease.  A future patch
will change the default behavior to reject lease attempts with -EINVAL
when there is no setlease file operation defined. Add generic_setlease
to retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/dir.c  | 2 ++
 fs/jffs2/file.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index dd91f725ded69ccb3a240aafd72a4b552f21bcd9..2b38ce1fd8e8d8d59e80f6ffb9ea2935f8cb27e4 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/crc32.h>
 #include <linux/jffs2.h>
 #include "jffs2_fs_i.h"
@@ -48,6 +49,7 @@ const struct file_operations jffs2_dir_operations =
 	.unlocked_ioctl=jffs2_ioctl,
 	.fsync =	jffs2_fsync,
 	.llseek =	generic_file_llseek,
+	.setlease =	generic_setlease,
 };
 
 
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index b697f3c259ef25171ce30785d4584d5a53751a0d..5e1ef4bc009b6e5b4818a7467639fc328c137c12 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/time.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
@@ -60,6 +61,7 @@ const struct file_operations jffs2_file_operations =
 	.fsync =	jffs2_fsync,
 	.splice_read =	filemap_splice_read,
 	.splice_write = iter_file_splice_write,
+	.setlease =	generic_setlease,
 };
 
 /* jffs2_file_inode_operations */

-- 
2.52.0


