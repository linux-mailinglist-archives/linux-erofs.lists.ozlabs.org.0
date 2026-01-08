Return-Path: <linux-erofs+bounces-1734-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F3D04D02
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:15:34 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBPJ0b9mz2yFq;
	Fri, 09 Jan 2026 04:15:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892532;
	cv=none; b=W+nvR5b7McZv64Ge5qdefMhtFg0od7ZriBLZmaiCfOwPRsZKFPBpAktdyX+dOKtuLBV41xHqJSDjGCfxrsST9PiSE6izxkt01stZu3frDZaYTehI1oif5Yc1xS7hW5NGyxC812haag5dNf7Y4FjSXEmcDM4qynXkLEJte9IitXTC6OnuFR8PBRZNZYJikInAC5lhaOfNJ1uke+h+2k89f3acbJhfhghaT87EXbQxd7EPhNyhYlcXXwZD23GcCtpzxvXK37Uiqd30gIGaMDy0Bs4oxQJ0dQCFNMtCmPqd/pjZOE9n3IQBSxV1K8Gc4qpU5ONedg11+kSrdWcS3Al09w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892532; c=relaxed/relaxed;
	bh=PIkGxSckJddzOm5mr5N7BySxqdSOcwEmn39dA60iKok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SDq7t4EZIjFPEJ9b4UdZJLKmqd1TZ0hz9Hvyy6jhljqegNldZF5G28lkS/6AYgpx9JoBpMoxFH3mJ4sJ3cuqWdkERmDWPHdBWGdRrTL+w9wUCZk72zp+/JjiUffCbPdMiIwg6xVZYhuvDWotvzwQyFSItHOdoWgO+WwfLAW0qyWDLfN+c8xADCga/rb+/jWW7kpH1jRJXRYu5wIirTBGI8z/ZvGnSD8kd6gpzEs+BThBO9zI5z8QoEFQ3kpAAm35u53XDSukD+WXqiP1ZFF4IUdmBrUcy2jz0lIxdWgoBwAtjwwdCt6fRJpqyaA8jQ/Gk6B92v5gpAyiEXNNGHxySA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o6pSqLEj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o6pSqLEj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBPH1fFrz2xGY
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:15:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F4BE60149;
	Thu,  8 Jan 2026 17:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1798C116C6;
	Thu,  8 Jan 2026 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892528;
	bh=lPmy5m2b6fstUP4HTh/TkAWFgE8sM8Qul7SD/NBtEMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o6pSqLEjn8qK7qYNebbAPkZ/JyIkQW++u82AhUwHi9H+QW2iAyt2/YV8OGsxZd1A9
	 ENrWknJg3NuxCTQ3tUkQ1nzJNdFeu2kkZmIWZslXtUy6vu4vYwlwaK2LDvMonkrRhF
	 3DHPRixwdk37Z3HJCNoiFPBNw4693o6PHwWpI06acd0vWqBNZaKtDxOBBL5GKH39ZA
	 mbERBl79ANFf6jGKxR6nRABJR3U3eh0aPlvqDAYupbvpmt5OfNovh+dgAcWgFcY9LU
	 VS2ZwmFVEW/NiRBVP3QjkmbYkj70bOwxmxx8gLNaqaMxaDmsgaKB3rvo5lQYD+x3aZ
	 OaVj5eawcoMtg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:09 -0500
Subject: [PATCH 14/24] ntfs3: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-14-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lPmy5m2b6fstUP4HTh/TkAWFgE8sM8Qul7SD/NBtEMM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W8LwtRNR2sBvsfy/GEh9ZefE4EjXAmzXj3h
 zdKm8qXc5GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvAAKCRAADmhBGVaC
 FbfXEADAKoRXZYBYCpltQSV7jdjNKk/JyP9tf3Coi/d7GV8fbo+eZK1ue3cTjR/mnT8hTfpD1xc
 5iB3iihAi3kCkIJSXzhpU5KSj5hFQCw343IkafmT3BIx5qzB72aiZMDoAsWRpM3GIreEyEh1sl3
 5Ox+8W9SmDsCzuHZ6gkAXHoarhyBNbRNlsYF+9XHx12xDx2EPVsr7cNp2IEOTtznxjB4k+JBIHG
 UlXRMlUV2UsOWJuS5EheCi2MMjIz+jrNb10YTMZO/ViLSG5b4xfU4a0BjaxfLJmzlNuVxFt5u47
 jJE74krY8s7YAOgW6N5+RB4czfrDPInVhccAdJcQYtAooHkgCDp+mTfMqlqZR7yyjeJf76atjl+
 +u8kOrnz9IXqT0pc8a1QsuAMA7SsW0nBEHcoGbobIpfstwgPDADr+lEqBOAu/SO2hbsAvBVN5n8
 Cx3bipjsINEhrXXbawsgNTUG/Ju8P6zGspNVcDL9yp9ry86Vnp/+WihRVDWnd7/O3XrcpKNtQ9e
 0xmTkabjcapHBXNsYeAA+dnMdTzCt3N16zrQsDrFEw2RublZKzJfg5f2O6eRXDt8/yXbFJ86oxp
 QBcIiI+HCS2lppFLxe4GtpIu69t48Rv29J2fKJ3q5RTb3WDfYDxGbNkeift5ZptZ9QJ7hvm8Lam
 SG2twaW+WuHsXSQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to ntfs_file_operations,
ntfs_legacy_file_operations, ntfs_dir_operations, and
ntfs_legacy_dir_operations, pointing to generic_setlease.  A future
patch will change the default behavior to reject lease attempts with
-EINVAL when there is no setlease file operation defined. Add
generic_setlease to retain the ability to set leases on this
filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/dir.c  | 3 +++
 fs/ntfs3/file.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index b98e95d6b4d993db114283a0f38cf10b1a7520a9..b66438e34bbb84483c5e6a5dde437251339d4335 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/nls.h>
 
 #include "debug.h"
@@ -630,6 +631,7 @@ const struct file_operations ntfs_dir_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl   = ntfs_compat_ioctl,
 #endif
+	.setlease	= generic_setlease,
 };
 
 #if IS_ENABLED(CONFIG_NTFS_FS)
@@ -638,6 +640,7 @@ const struct file_operations ntfs_legacy_dir_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= ntfs_readdir,
 	.open		= ntfs_file_open,
+	.setlease	= generic_setlease,
 };
 #endif
 // clang-format on
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2e7b2e566ebe18c173319c7cfd4304c22ddd2f28..6cb4479072a66dc9c3429be1c4bcebce176e5913 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -14,6 +14,7 @@
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
+#include <linux/filelock.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -1477,6 +1478,7 @@ const struct file_operations ntfs_file_operations = {
 	.fsync		= ntfs_file_fsync,
 	.fallocate	= ntfs_fallocate,
 	.release	= ntfs_file_release,
+	.setlease	= generic_setlease,
 };
 
 #if IS_ENABLED(CONFIG_NTFS_FS)
@@ -1486,6 +1488,7 @@ const struct file_operations ntfs_legacy_file_operations = {
 	.splice_read	= ntfs_file_splice_read,
 	.open		= ntfs_file_open,
 	.release	= ntfs_file_release,
+	.setlease	= generic_setlease,
 };
 #endif
 // clang-format on

-- 
2.52.0


