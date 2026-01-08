Return-Path: <linux-erofs+bounces-1732-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4DD04CF0
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 18:15:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dnBP84NCNz2yFs;
	Fri, 09 Jan 2026 04:15:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767892524;
	cv=none; b=gmenaVphvVlmrfXQU6aeX0ONIsR7T0jnAkygxJqlVyQ3N5QnQmNDliaB1uyxjclPaYtM8o1733GiED0pJmlrHN3FkT5zf6KjSEOSc1W5bha1bhPM1v2RpEEJWUWCDPsphVamSqWXJvYGdmlJsnf2OGGxBA46tUn++V4ucE1KmLLb6jPEtLLZm0WfRxP9jI4m4hGgBlxtXbKV1Nohiqo2rEh6v1aq+so+RFcV8yjQKtf1pWb7YYOMmS9RNpB5m8oeJgE6uqetc/TbfReuqFdCgKeAA3U3/hugYwwSOACPgFeF3tDheeq03veiCXZQrcxVfeEtyQc6yC2n2V7n9Zdnzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767892524; c=relaxed/relaxed;
	bh=dKbojeUF9wszpmnpENiT3itMPf4f4MBXLvnrvVy3l24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGvX7hDdRgSTst2wq+MG7TM3RrO9hieSYaATU12r/OGp0oNtDNp+avyNiIEIktmueR4VQm4l8uLYKfnACFr+WdsI/EHylD8vrCRneCw1T7E4SOSGbpiBrcmTmU0EhuogVIJTuxqXxvghdm9zDKKjKn0C+WDJqb7v2bWyVAvy96WS4hBXzRaVJl23LOlcNHzsg4RcyPkjU9mhExI9gO0kF4RhmJd8MD5z3gc9nXR9P3r84DwPIsoxWaObsxb17qpKgm1i8JqWZZ0iiEiO+jbnyH9mnIFjGDVmQYm43SQ8+MOKhxFwNeRW4cjpuiTVQFc35DbWgO3wbdvBNpA8nEQ5xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U63CS+2S; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=U63CS+2S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dnBP75tPPz2yFq
	for <linux-erofs@lists.ozlabs.org>; Fri, 09 Jan 2026 04:15:23 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AD24160132;
	Thu,  8 Jan 2026 17:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0906DC2BCAF;
	Thu,  8 Jan 2026 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892521;
	bh=7K9p85kQBsPIELLrgo6Fwt98n+8PhfeVVaYWOCIPo7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U63CS+2SID+lavsOrSSCUalQh3m7FJHBSbAoGL/RmPqzsfFEPGFZGbdZsU6eJQ5v9
	 uneS5gyrpM9Fep8UdIeYQSvBAiMRqLI1WFUiyh3FHuYXqE5c1vvwxIG3liIMSCIPf8
	 k/ZHusqr8jROTU2Z1TsxDbsUhK1LNDoWdcbKukPO67MY+LMNXUGLVwQU5GnQewNeHm
	 X8r3wm4rHE1ZGLA11pFy8vFE4Y2MopFN4iwY1VLCL2ProgfDnPQLN6cYI4h9KECtyI
	 4AKCxyPsXPB5f/spy5jS1w48yjld5OSFSYK8tN0A9KP19ZVyrDG+PNFqwz6ggoTPcC
	 MV+xGBiu4K4UQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:08 -0500
Subject: [PATCH 13/24] nilfs2: add setlease file operation
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
Message-Id: <20260108-setlease-6-20-v1-13-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7K9p85kQBsPIELLrgo6Fwt98n+8PhfeVVaYWOCIPo7A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W76g8a5Sef4VJHMu/SBiKGJBzYZIYBEvZM7
 sa7pofG9vGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luwAKCRAADmhBGVaC
 FRefEADUL6yifXH4F2LGUNkPDbna2fKnDcbKePeGEDTBWN1hhn9ngEJTm7fpEqb1YRrtPcDp5vE
 +1R/Iwq0TMu23DexViJFHvvST4O2zdxNMDAkI59v1YOXOc2iiFCpeYa3fgo4CrBcHdGbeHnQ1TW
 yLKsPs4Hiey4j+/QdTEm0FCCPpA6W2TAZ2tca3zdwPBZ0B86QYT7n0rZI6G4MQ312DG9n9OmrLW
 wzsMlQIz3mgqAXM/1h9TI3qFLLveP+r9b0eOfIDhTQdfWAqfMCWV7gtBSkEsucAHzGQpD/UmBcu
 1lZrlIEoJTfx2Ds54BP34C/fwPGQ5QBiZAGis4Lo0luqIolY2PA2Ea+BN1LWsf/ygZKWQ50jdcE
 TTddRZkGUgNqpIjWoVl4CetGS/X21/t+55U4WcKz2YOxhxlLBxbvpU+x2jQDf/tFtiPYYA1G2OX
 ctASop1n8K3jd/MYBIGR7Yl7pitBvV0VNOK8wWSbW4xa/EfjZQq7aU7LBwwyNDRzuSl0+AO5WqR
 oAIyaiX4gXhi7PAAbr12kT0TRMF1RVN6pPjpz+ibo4iAsep4JsVSnnpWIuTVRS+iIUwB+gCgQjm
 RZr/YvulgvvUovmoLq8+3kMR2IrDBkO81sWpr19hA92feWIURvJq5Qylyfi8CB5rW1ebshMTKz7
 XusXaUQHgsa1/Tw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the setlease file_operation to nilfs_file_operations and
nilfs_dir_operations, pointing to generic_setlease.  A future patch
will change the default behavior to reject lease attempts with -EINVAL
when there is no setlease file operation defined. Add generic_setlease
to retain the ability to set leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nilfs2/dir.c  | 3 ++-
 fs/nilfs2/file.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 6ca3d74be1e16d5bc577e2520f1e841287a2511f..b243199036dfa1ab2299efaaa5bdf5da2d159ff2 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -30,6 +30,7 @@
  */
 
 #include <linux/pagemap.h>
+#include <linux/filelock.h>
 #include "nilfs.h"
 #include "page.h"
 
@@ -661,5 +662,5 @@ const struct file_operations nilfs_dir_operations = {
 	.compat_ioctl	= nilfs_compat_ioctl,
 #endif	/* CONFIG_COMPAT */
 	.fsync		= nilfs_sync_file,
-
+	.setlease	= generic_setlease,
 };
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 1b8d754db44d44d25dcd13f008d266ec83c74d3f..f93b68c4877c5ed369e90b723517e117142335de 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/mm.h>
 #include <linux/writeback.h>
 #include "nilfs.h"
@@ -150,6 +151,7 @@ const struct file_operations nilfs_file_operations = {
 	.fsync		= nilfs_sync_file,
 	.splice_read	= filemap_splice_read,
 	.splice_write   = iter_file_splice_write,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations nilfs_file_inode_operations = {

-- 
2.52.0


