Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFCD761C87
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 16:59:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OKVh6IhR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9Kth2sYsz3bl6
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 00:59:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OKVh6IhR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9Ktb5Rk9z3bq4
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 00:59:19 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C9414617AF;
	Tue, 25 Jul 2023 14:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE35C433BA;
	Tue, 25 Jul 2023 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690297157;
	bh=1/8G5JaqUI6KuuI2rdJCgZt0gS2ge3CDkWe83TSi7uM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OKVh6IhRvMPzZaUNNT/6mBAoahekKV8Su19ujYhua5dNsSJXGr2MngNtpKOYADlS5
	 Hcq3wM7FDUZ1AhwU5l0SkI1+lCCn8xOR0JJEjELHxkXsYQRXohxF15c8QjQl0Xm+Dp
	 AabYaBtk81zigqO/ZNjxOWuBUbzqMLIiq+sCKRMr913CtPRA3nMy4ZQya2P+aMfBUm
	 DfLibUhnVNjPNL0YkM5WeV2HMZF3SVAzWSiYRKfJIayN7D5eWYtRDof0ETICfcAJhP
	 1QdzIniwIyLPb29vjUNBQTa5/ioEZS6W4QeTzhNnSbuJelJPSwWTBbQCum2wVq78oc
	 3sGYY+SrEP5rg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 25 Jul 2023 10:58:17 -0400
Subject: [PATCH v6 4/7] tmpfs: add support for multigrain timestamps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230725-mgctime-v6-4-a794c2b7abca@kernel.org>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
In-Reply-To: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Xiubo Li <xiubli@redhat.com>, 
 Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
 coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Miklos Szeredi <miklos@szeredi.hu>, Bob Peterson <rpeterso@redhat.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Iurii Zaikin <yzaikin@google.com>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, Ronnie Sahlberg <lsahlber@redhat.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Richard Weinberger <richard@nod.at>, Hans de Goede <hdegoede@redhat.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1/8G5JaqUI6KuuI2rdJCgZt0gS2ge3CDkWe83TSi7uM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkv+Mkeyk/syoIEMjY8h9EHJqsxQ0aWd6cS3gVn
 sS0hR6R/6SJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZL/jJAAKCRAADmhBGVaC
 FYYkD/9ytQv3AFDwSgID22VN0gkInS/gdWOU/XMQQ111VBBi+jtoL8sLhVN5+hTN45+z+uGCwcK
 ELptnx+sw1zyhpa/86b54P+Vj5/WEHTeyw/CugTFYvMMoxwZw3ZF8vYg4M+6ynQZWEJf2tQTk2K
 tdiekC/jrc+9KjYzeRXXoAq7TsgQVc8u4/u2BW+1mdUZ98N9dl6u4nDXkARcLRI+LqNSqh9d6yO
 IxOufKgdLh3pGMAHW0q+fSoPiNMaAQfCgxRx5Zy5ia1ZTPZzU6Mby8JrQ1f7U5WMxcYwL5SocmN
 G1UQX9z0RwE31B3CXLu6imdPlx5v9rro+6PBLF3MSRTzzmiLn5NVhf3ASxqYHB88Pxb8/YrZ5Hf
 p/mwAO9pFriehz2pTk7gj/rsg8EUkXvtGxT5/Ud0BQecMRLtzeelj7BsIirEdqiFM+oyJieS+6R
 yLQRWQ90+womEnX2UOBBDcSKJ4IRMVFTxqfRtTbtj+avSSM1HsqYg0PG+ZTcD7VzonTutJSupea
 MDCgNVtA3BSf4FlJtanXc6obMiQXMpaMbvRF7g7ZZQQ+I6clgjwlo2maEMVCXlobjZ7og+2Vn/L
 zdsEdNjCGYRoIRNzoAeGM8rXQ6ra0wNwBlgnVC6G77t8+98CH+j80wmzcqQzAx9NPFqiEcsD79b
 2pTWmlY/xVg/8Xw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, codalist@coda.cs.cmu.edu, cluster-devel@redhat.com, linux-ext4@vger.kernel.org, devel@lists.orangefs.org, Anthony Iliopoulos <ailiop@suse.com>, ecryptfs@vger.kernel.org, ocfs2-devel@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 654d9a585820..b6019c905058 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4264,7 +4264,7 @@ static struct file_system_type shmem_fs_type = {
 #endif
 	.kill_sb	= kill_litter_super,
 #ifdef CONFIG_SHMEM
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 #else
 	.fs_flags	= FS_USERNS_MOUNT,
 #endif

-- 
2.41.0

