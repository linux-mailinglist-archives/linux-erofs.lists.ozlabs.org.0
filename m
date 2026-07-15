Return-Path: <linux-erofs+bounces-3899-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L+DqFdJcV2qWKQEAu9opvQ
	(envelope-from <linux-erofs+bounces-3899-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jul 2026 12:11:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3403B75CC9D
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jul 2026 12:11:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WvM577LA;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WvM577LA;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3899-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3899-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0X5772cZz2xjN;
	Wed, 15 Jul 2026 20:11:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784110283;
	cv=none; b=Xa0uzxooFuWCFPqo5CPRByXehKMy6uSJ01QHQ47ZRz6lpkE7p7qfBAuiKVwFaLz3otAKPQottUsxHvP9/Iug6yip+RNb+2WDrKeBD2Vte43B0srENwSsHAP6VbwxOxjot34WVvX60L9XyVtXYFgUwgsgFkCdQX3Qh2tOP+lVWBG5shMK2FVQ892Vaxmt//nUIXqhgGQ2/GL0ZPexMQAFqyNftd80HSAinlqEB/S/LP1wvH2vIzccRghagcsKD9wXSYLqVjjAM8vImNo+edeY1KQDao3BYVCunKECf6R58EGMC2Wn8myI1cJv6bFHHQiYLHe89ruBCn0KRNAB/lVO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784110283; c=relaxed/relaxed;
	bh=MYLs8SsTwg44aYRzc9yzYhPrXdd8IrmzE9cKsD2QDVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Oq7HZmicZd80yxx3fFxuVrobQi3IsWASIr70C9Zz1pvERAT/5cUUBI0f6aw913FYAPpq+zWMFD3sFHAEbzMUDCV0+CQQWse8vsuLScCBu2EXU/ptUepK3dDhDZM6SbpzVC6dg0+5C6esTlvLNzU44nPJLpWUXyHojOTKg9EMIbRziuYrPXcnCJtUfIkb5ESF542AUzAzzpgBEM6vW/dZ9Zz18RdBN9JnE1y6C5pF1Z7JZ+ENZlfpTnICz+o7aGMGhkRmfOw3Fq09/a9w8/1ioUZYLw/nc1C96lqXgy51112nvXG2sLJtXCTuZXalpPBVAAOHDbByjC1yZdeASBmJaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WvM577LA; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WvM577LA; dkim-atps=neutral; spf=permerror (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mszeredi@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0X545wtyz2xd2
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jul 2026 20:11:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYLs8SsTwg44aYRzc9yzYhPrXdd8IrmzE9cKsD2QDVU=;
	b=WvM577LAYR8kIi8YWc5UN+YGhOB9dhNdigcB0otwRTNIkM+vGG4RHEX5hVIXwB/9XyhyEm
	EAdaazghwpNXcre9J/ZY4ixbz0Is6Rj1YeNkD5wCZuMrpK/6YKntD02V0yLgU2ASQAlxfc
	Oap1G18QLEaMV+Hlm/ij0NwMXIzxniU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784110274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MYLs8SsTwg44aYRzc9yzYhPrXdd8IrmzE9cKsD2QDVU=;
	b=WvM577LAYR8kIi8YWc5UN+YGhOB9dhNdigcB0otwRTNIkM+vGG4RHEX5hVIXwB/9XyhyEm
	EAdaazghwpNXcre9J/ZY4ixbz0Is6Rj1YeNkD5wCZuMrpK/6YKntD02V0yLgU2ASQAlxfc
	Oap1G18QLEaMV+Hlm/ij0NwMXIzxniU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-9NllnpAfPIeF7A2etoCwKg-1; Wed, 15 Jul 2026 06:11:12 -0400
X-MC-Unique: 9NllnpAfPIeF7A2etoCwKg-1
X-Mimecast-MFC-AGG-ID: 9NllnpAfPIeF7A2etoCwKg_1784110271
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493bfc3b84aso25839785e9.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jul 2026 03:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784110271; x=1784715071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MYLs8SsTwg44aYRzc9yzYhPrXdd8IrmzE9cKsD2QDVU=;
        b=HMaraWBO9AyZ6ik0zqTfqfhP4wHOm70Q6GgLxkKBbJYLPsIuL4DVv7LVwMMyCq50Ss
         dX4jm46ElYTGyylYFl1t8DywKCPX76V+lkSU6DEik5GPdM9BgE58jt1YvvSrJT3VmSkO
         loTy81+sSdvZvw0MoKUXsXwyDEa94KDgRJS3JxwKEU4Qk/1K4PR3ESH7nxkCm0/hVUA7
         sMBFQrZcK1tzzeYZ/erMYGtuWW12tDSVbSb28SfqHLlNNOQGLU7e4TjTsICPNQP9yfk0
         nLE8W0wtxy92D4LRBt9H3Y6NEvU/nYc86g0yOTanWXLX2tT8k98XdEdI5Zo59G1/eWol
         ZX8w==
X-Forwarded-Encrypted: i=1; AHgh+RohJ08SxrYd52iNF0zXTHcxgL2jbJ9tn04e1Ey+rHzXXu3b9x4w3Xo9SWgHsUfmzrYNZwnBmFXHVUgJCQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywdt8BlzvJErYZSg1B+PauvI+dg3YeZJRp+Clq4kEZ1AocmYnpt
	qnLi3tvat2D86GHX/H6IJ0E3ANIucruOilJNn1g4FEskXlLQCnNt2qs0u1oy57D7Ly4RfupWWMQ
	77l9Cgf4iC+nP6lv1zjFarWUjn8VvglTVHkmHykMFZ4NjnayZoL5YX3HbEBwvnGsYLg==
X-Gm-Gg: AfdE7clbQLhnkSkCCu61wIfI5H9J8s/XvaieO6lip3fmM6WlfWSmU73iD+g6KuEJhvl
	75b7hQ45pgAdGg9090CiQu5inYOlqS8Syudb3m1S4HBZHP6Rtc/jvhUKz0OFeGqc7Ru24LO0qTi
	JFbsVrWdNuwGLmtjC3WIE7kH/hIeGvdbuQKQ+NxajkZU92MauKUwV2fZzyJF0UOdv/ti+aLXCPM
	UQSPu77/byj8D/DAemkrphszSd2K2gNA1iD2P5E7zvvuMfzcePG2YlaOI1f9fS85W+Rsl+q9D9D
	tf/oAHyB5tTSY7bWPApj2JPgqMe0NY2Gg4qETSqXK0GWhWVJ+dP/y1a3QZsrQb+2m7CEAZLiztO
	FfOj4LVcv4/gUUuigAFsxUbPbdBFuJ6R1z5g0Ff989oQzm97ENUd65PDv8pH/
X-Received: by 2002:a05:600c:4342:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-495389cde01mr37536995e9.30.1784110270247;
        Wed, 15 Jul 2026 03:11:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4342:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-495389cde01mr37536465e9.30.1784110269408;
        Wed, 15 Jul 2026 03:11:09 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-2-113.pool.digikabel.hu. [85.67.2.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4953b35105esm66576375e9.9.2026.07.15.03.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 03:11:08 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
Date: Wed, 15 Jul 2026 12:11:01 +0200
Message-ID: <20260715101107.973997-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FnTP48-_G_jU9wn7YnIAYrXmHX4gqs1p4crLCqYaymY_1784110271
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,gmail.com,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-3899-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mszeredi@redhat.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:hsiangkao@linux.alibaba.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mszeredi@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3403B75CC9D

This is a prototype patch. Needs to be split up!

1) O_ALT / OPEN_TREE_ALT

  These open an alternative namespace rooted at dfd - instead of resolving
  the path in the real filesystem, it resolves it in a virtual tree that
  exposes metadata about that file.

  This is intended to provide an alternative to adding new ioctls:

   - provides structured namespace
   - allows accessing data through fs ops

  Could call this O_META, but O_ALT seems more generic and there could be
  uses beyond metadata (e.g. seekable, in-place decompression).

  This has been discussed previously:
  https://lore.kernel.org/all/CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com/

2/a) s_op.get_options(), sb_add_option()

  .get_options() is a generic version of .show_options().

  After converting everyting to seq_show_option() the rest is trivial:

   - change first arg to "struct sb_opt_ctx *ctx"
   - replace "seq_show_option(m" with "sb_add_option(ctx"

2/b) sb_add_option_path()

  The last arg is "struct path *".  This is for options that designate a
  path (e.g. stacked fs layers).

  Will allow opening the path through O_ALT.  Ignored when retrieving the
  string value of the option.

3) MNT_CLONABLE

  Allow an internal mount to be cloned.  Nsfs and pidfs are already special
  cased, move these over to this flag.

  Also allow overlayfs layers to be cloned.

4) mnt.mnt_devname -> sb.s_devname

  This is historical thing, mnt_devname was just copied when cloning the
  mount, sharing the same value for all mounts belonging to a super block.

5) mount options in metafs

  Support retrieving mount options through O_ALT opens:

     mount/options/OPT/N: Nth instance of OPT

  This will be a symlink pointint to the option value. If the option refers
  to a path (as per 2/b), following the symlink jumps to the given path.

  At this point only overlayfs and erofs are converted.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 Documentation/filesystems/vfs.rst |   2 +-
 fs/Makefile                       |   2 +
 fs/erofs/super.c                  |  29 +-
 fs/fcntl.c                        |   2 +-
 fs/internal.h                     |   1 +
 fs/metafs/Makefile                |   6 +
 fs/metafs/metafs.c                | 572 ++++++++++++++++++++++++++++++
 fs/metafs/metafs.h                |  15 +
 fs/mount.h                        |   1 -
 fs/namei.c                        |  16 +
 fs/namespace.c                    |  84 +++--
 fs/nsfs.c                         |   1 +
 fs/open.c                         |   5 +-
 fs/overlayfs/params.c             |  43 ++-
 fs/overlayfs/params.h             |   2 +-
 fs/overlayfs/super.c              |   5 +-
 fs/pidfs.c                        |   4 +-
 fs/proc_namespace.c               |  50 ++-
 fs/super.c                        |  12 +-
 include/linux/fcntl.h             |   2 +-
 include/linux/fs/super.h          |  10 +
 include/linux/fs/super_types.h    |   4 +
 include/linux/mount.h             |   3 +-
 include/linux/namei.h             |   3 +-
 include/linux/pidfs.h             |   1 -
 include/uapi/asm-generic/fcntl.h  |   4 +
 include/uapi/linux/mount.h        |   1 +
 scripts/gdb/linux/proc.py         |   5 +-
 28 files changed, 774 insertions(+), 111 deletions(-)
 create mode 100644 fs/metafs/Makefile
 create mode 100644 fs/metafs/metafs.c
 create mode 100644 fs/metafs/metafs.h

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7c753148af88..3dc431b6cdbb 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -314,7 +314,7 @@ or bottom half).
 ``show_devname``
 	Optional. Called by the VFS to show device name for
 	/proc/<pid>/{mounts,mountinfo,mountstats}. If not provided then
-	'(struct mount).mnt_devname' will be used.
+	'(struct super_block).s_devname' will be used.
 
 ``show_path``
 	Optional. Called by the VFS (for /proc/<pid>/mountinfo) to show
diff --git a/fs/Makefile b/fs/Makefile
index 89a8a9d207d1..87a4c23d5a08 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -58,6 +58,8 @@ obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
 obj-$(CONFIG_DLM)		+= dlm/
+
+obj-y				+= metafs/
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_NETFS_SUPPORT)	+= netfs/
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..257517c28e1d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1028,29 +1028,34 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static int erofs_show_options(struct seq_file *seq, struct dentry *root)
+static int erofs_get_options(struct sb_opt_ctx *ctx, struct dentry *root)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(root->d_sb);
 	struct erofs_mount_opts *opt = &sbi->opt;
 
+	if (sbi->dif0.file)
+		sb_add_option_path(ctx, "source", NULL, &sbi->dif0.file->f_path);
+
 	if (IS_ENABLED(CONFIG_EROFS_FS_XATTR))
-		seq_puts(seq, test_opt(opt, XATTR_USER) ?
-				",user_xattr" : ",nouser_xattr");
+		sb_add_option(ctx, test_opt(opt, XATTR_USER) ?
+			      "user_xattr" : "nouser_xattr", NULL);
 	if (IS_ENABLED(CONFIG_EROFS_FS_POSIX_ACL))
-		seq_puts(seq, test_opt(opt, POSIX_ACL) ? ",acl" : ",noacl");
+		sb_add_option(ctx, test_opt(opt, POSIX_ACL) ? "acl" : "noacl", NULL);
 	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP))
-		seq_printf(seq, ",cache_strategy=%s",
+		sb_add_option(ctx, "cache_strategy",
 			  erofs_param_cache_strategy[opt->cache_strategy].name);
 	if (test_opt(opt, DAX_ALWAYS))
-		seq_puts(seq, ",dax=always");
+		sb_add_option(ctx, "dax", "always");
 	if (test_opt(opt, DAX_NEVER))
-		seq_puts(seq, ",dax=never");
+		sb_add_option(ctx, "dax", "never");
 	if (erofs_is_fileio_mode(sbi) && test_opt(opt, DIRECT_IO))
-		seq_puts(seq, ",directio");
-	if (sbi->dif0.fsoff)
-		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
+		sb_add_option(ctx, "directio", NULL);
+	if (sbi->dif0.fsoff) {
+		char *val __free(kfree) = kasprintf(GFP_KERNEL, "%llu", sbi->dif0.fsoff);
+		sb_add_option(ctx, "fsoffset", val);
+	}
 	if (test_opt(opt, INODE_SHARE))
-		seq_puts(seq, ",inode_share");
+		sb_add_option(ctx, "inode_share", NULL);
 	return 0;
 }
 
@@ -1069,7 +1074,7 @@ const struct super_operations erofs_sops = {
 	.free_inode = erofs_free_inode,
 	.evict_inode = erofs_evict_inode,
 	.statfs = erofs_statfs,
-	.show_options = erofs_show_options,
+	.get_options = erofs_get_options,
 };
 
 module_init(erofs_module_init);
diff --git a/fs/fcntl.c b/fs/fcntl.c
index c158f082f1da..01b765cfac84 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(23 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __O_REGULAR));
diff --git a/fs/internal.h b/fs/internal.h
index 355d93f92208..e73a5c1d5b4e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -95,6 +95,7 @@ int path_umount(const struct path *path, int flags);
 int path_pivot_root(struct path *new, struct path *old);
 
 int show_path(struct seq_file *m, struct dentry *root);
+int mnt_show_options(struct seq_file *seq, struct vfsmount *mnt);
 
 /*
  * fs_struct.c
diff --git a/fs/metafs/Makefile b/fs/metafs/Makefile
new file mode 100644
index 000000000000..f855b48d9c2b
--- /dev/null
+++ b/fs/metafs/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for meta filesystem
+#
+
+obj-y := metafs.o
diff --git a/fs/metafs/metafs.c b/fs/metafs/metafs.c
new file mode 100644
index 000000000000..15ec0b6064da
--- /dev/null
+++ b/fs/metafs/metafs.c
@@ -0,0 +1,572 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * metafs - virtual filesystem for metadata access
+ *
+ * This provides a way to access metadata about files and filesystems
+ * through O_ALT file descriptors.
+ */
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/magic.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/slab.h>
+#include <linux/dcache.h>
+#include <linux/pseudo_fs.h>
+#include <linux/fs/super.h>
+#include "metafs.h"
+
+/*
+ * metafs superblock and mount
+ */
+static struct vfsmount *metafs_mnt __ro_after_init;
+
+static const struct super_operations metafs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= inode_just_drop,
+};
+
+static int metafs_init_fs_context(struct fs_context *fc)
+{
+	struct pseudo_fs_context *ctx = init_pseudo(fc, 0x4d455441); /* 'META' */
+	if (!ctx)
+		return -ENOMEM;
+	ctx->ops = &metafs_ops;
+	return 0;
+}
+
+static struct file_system_type metafs_type = {
+	.name = "metafs",
+	.init_fs_context = metafs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+/*
+ * Mount option collection structures
+ */
+enum metafs_dentry_type {
+	METAFS_ROOT,
+	METAFS_OPTION_VALUES,
+	METAFS_SYMLINK,
+};
+
+struct metafs_option_entry {
+	char *value;
+	struct path path;
+};
+
+struct metafs_dentry_info {
+	enum metafs_dentry_type type;
+	union {
+		struct {
+			struct file *base;
+		} root;
+		struct {
+			struct metafs_option_entry *entries;
+			int count;
+		} opt_values;
+		struct metafs_option_entry symlink;
+	};
+};
+
+struct metafs_collect_ctx {
+	struct sb_opt_ctx ctx;
+	const char *target_name;
+	struct super_block *sb;
+	struct metafs_option_entry *entries;
+	int count;
+	int size;
+	int err;
+	bool is_source;
+};
+
+/*
+ * Collect specific mount option values from the base filesystem
+ */
+static void metafs_collect_option(struct sb_opt_ctx *ctx, const char *name,
+				  const char *value, const struct path *path)
+{
+	struct metafs_collect_ctx *collect_ctx = ctx->data;
+	struct metafs_option_entry *entry;
+
+	if (strcmp(name, collect_ctx->target_name) != 0)
+		return;
+
+	if (!value && collect_ctx->is_source)
+		value = collect_ctx->sb->s_devname;
+
+	if (collect_ctx->count >= collect_ctx->size) {
+		int new_size = collect_ctx->size ? collect_ctx->size * 2 : 4;
+		struct metafs_option_entry *new_entries;
+
+		new_entries = krealloc_array(collect_ctx->entries, new_size, sizeof(*new_entries),
+					     GFP_KERNEL);
+		if (!new_entries) {
+			collect_ctx->err = -ENOMEM;
+			return;
+		}
+		collect_ctx->entries = new_entries;
+		collect_ctx->size = new_size;
+	}
+
+	entry = &collect_ctx->entries[collect_ctx->count];
+	entry->value = value ? kstrdup(value, GFP_KERNEL) : NULL;
+	if (!entry->value && value) {
+		collect_ctx->err = -ENOMEM;
+		return;
+	}
+	if (path) {
+		entry->path = *path;
+		path_get(&entry->path);
+	} else {
+		memset(&entry->path, 0, sizeof(entry->path));
+	}
+	collect_ctx->count++;
+}
+
+static void metafs_free_entries(struct metafs_option_entry *entries, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		kfree(entries[i].value);
+		if (entries[i].path.mnt)
+			path_put(&entries[i].path);
+	}
+	kfree(entries);
+}
+
+static int metafs_get_option_values(struct file *base, const char *option_name,
+				    struct metafs_option_entry **entries_out,
+				    int *count_out)
+{
+	const struct path *path = &base->f_path;
+	struct super_block *sb = path->mnt->mnt_sb;
+	struct metafs_collect_ctx collect_ctx = {
+		.ctx.data = &collect_ctx,
+		.ctx.actor = metafs_collect_option,
+		.target_name = option_name,
+		.sb = sb,
+		.is_source = !strcmp(option_name, "source"),
+	};
+	int ret;
+
+	if (sb->s_op->get_options) {
+		ret = sb->s_op->get_options(&collect_ctx.ctx, path->mnt->mnt_root);
+		if (ret || collect_ctx.err) {
+			metafs_free_entries(collect_ctx.entries, collect_ctx.count);
+			return ret ?: collect_ctx.err;
+		}
+	}
+
+	/* special case: add "source" option if filesystem didn't add one*/
+	if (!collect_ctx.count && collect_ctx.is_source) {
+		struct metafs_option_entry *ent __free(kfree) = kzalloc_obj(*ent);
+
+		if (!ent)
+			return -ENOMEM;
+
+		ent->value = kstrdup(sb->s_devname, GFP_KERNEL);
+		if (!ent->value)
+			return -ENOMEM;
+
+		collect_ctx.entries = no_free_ptr(ent);
+		collect_ctx.count = 1;
+	}
+
+	*entries_out = collect_ctx.entries;
+	*count_out = collect_ctx.count;
+	return 0;
+}
+
+/*
+ * metafs symlink operations
+ */
+static const char *metafs_get_link(struct dentry *dentry, struct inode *inode,
+				   struct delayed_call *done)
+{
+	struct metafs_dentry_info *info;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	info = dentry->d_fsdata;
+	if (info->symlink.path.mnt) {
+		int error;
+
+		path_get(&info->symlink.path);
+		error = nd_jump_link(&info->symlink.path);
+		return ERR_PTR(error);
+	}
+
+	return ERR_PTR(-ELOOP);
+}
+
+static int metafs_readlink(struct dentry *dentry, char __user *buffer,
+			   int buflen)
+{
+	struct metafs_dentry_info *info = dentry->d_fsdata;
+	const char *value = info->symlink.value;
+
+	if (!value)
+		value = "";
+
+	return readlink_copy(buffer, buflen, value, strlen(value));
+}
+
+static const struct inode_operations metafs_symlink_iops = {
+	.get_link	= metafs_get_link,
+	.readlink	= metafs_readlink,
+};
+
+/*
+ * Dentry operations - cleanup
+ */
+static void metafs_d_release(struct dentry *dentry)
+{
+	struct metafs_dentry_info *info = dentry->d_fsdata;
+
+	if (!info)
+		return;
+
+	switch (info->type) {
+	case METAFS_ROOT:
+		fput(info->root.base);
+		break;
+	case METAFS_OPTION_VALUES:
+		metafs_free_entries(info->opt_values.entries,
+				    info->opt_values.count);
+		break;
+	case METAFS_SYMLINK:
+		kfree(info->symlink.value);
+		if (info->symlink.path.mnt)
+			path_put(&info->symlink.path);
+		break;
+	default:
+		WARN_ON(1);
+	}
+	kfree(info);
+}
+
+static const struct dentry_operations metafs_dentry_ops = {
+	.d_release = metafs_d_release,
+};
+
+/*
+ * metafs directory operations - forward declarations
+ */
+static struct file *metafs_get_base_file(struct dentry *dentry);
+static struct dentry *metafs_root_lookup(struct inode *dir, struct dentry *dentry,
+					 unsigned int flags);
+static struct dentry *metafs_mount_lookup(struct inode *dir, struct dentry *dentry,
+					  unsigned int flags);
+static struct dentry *metafs_options_lookup(struct inode *dir, struct dentry *dentry,
+					    unsigned int flags);
+static struct dentry *metafs_option_values_lookup(struct inode *dir, struct dentry *dentry,
+						  unsigned int flags);
+
+static const struct inode_operations metafs_root_dir_iops = {
+	.lookup		= metafs_root_lookup,
+};
+
+static const struct inode_operations metafs_mount_dir_iops = {
+	.lookup		= metafs_mount_lookup,
+};
+
+static const struct inode_operations metafs_options_dir_iops = {
+	.lookup		= metafs_options_lookup,
+};
+
+static const struct inode_operations metafs_option_values_dir_iops = {
+	.lookup		= metafs_option_values_lookup,
+};
+
+/*
+ * Create a new inode in metafs
+ */
+static struct inode *metafs_get_inode(struct super_block *sb, umode_t mode,
+				      const struct inode_operations *iops)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (!inode)
+		return NULL;
+
+	inode->i_ino = get_next_ino();
+	inode->i_mode = mode;
+	simple_inode_init_ts(inode);
+
+	if (S_ISDIR(mode)) {
+		inode->i_op = iops;
+		inc_nlink(inode);
+	} else if (S_ISLNK(mode)) {
+		inode->i_op = &metafs_symlink_iops;
+	}
+
+	return inode;
+}
+
+/*
+ * Lookup in root directory (/)
+ * Only "mount" is valid here
+ */
+static struct dentry *metafs_root_lookup(struct inode *dir, struct dentry *dentry,
+					 unsigned int flags)
+{
+	const char *name = dentry->d_name.name;
+	struct inode *inode;
+
+	if (strcmp(name, "mount") != 0)
+		return ERR_PTR(-ENOENT);
+
+	inode = metafs_get_inode(dir->i_sb, S_IFDIR | 0555, &metafs_mount_dir_iops);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	d_add(dentry, inode);
+	d_mark_dontcache(inode);
+	return NULL;
+}
+
+/*
+ * Lookup in /mount directory
+ * Only "options" is valid here
+ */
+static struct dentry *metafs_mount_lookup(struct inode *dir, struct dentry *dentry,
+					  unsigned int flags)
+{
+	const char *name = dentry->d_name.name;
+	struct inode *inode;
+
+	if (strcmp(name, "options") != 0)
+		return ERR_PTR(-ENOENT);
+
+	inode = metafs_get_inode(dir->i_sb, S_IFDIR | 0555, &metafs_options_dir_iops);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	d_add(dentry, inode);
+	d_mark_dontcache(inode);
+	return NULL;
+}
+
+/*
+ * Lookup in /mount/options directory
+ * Collect values for the requested option name
+ */
+static struct dentry *metafs_options_lookup(struct inode *dir, struct dentry *dentry,
+					    unsigned int flags)
+{
+	const char *target_name = dentry->d_name.name;
+	struct file *base;
+	struct metafs_dentry_info *info;
+	struct metafs_option_entry *entries = NULL;
+	int count = 0;
+	struct inode *inode;
+	int ret;
+
+	base = metafs_get_base_file(dentry->d_parent);
+	if (!base)
+		return ERR_PTR(-ENOENT);
+
+	ret = metafs_get_option_values(base, target_name, &entries, &count);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (count == 0) {
+		kfree(entries);
+		return ERR_PTR(-ENOENT);
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		metafs_free_entries(entries, count);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	info->type = METAFS_OPTION_VALUES;
+	info->opt_values.entries = entries;
+	info->opt_values.count = count;
+
+	inode = metafs_get_inode(dir->i_sb, S_IFDIR | 0555, &metafs_option_values_dir_iops);
+	if (!inode) {
+		metafs_free_entries(entries, count);
+		kfree(info);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dentry->d_fsdata = info;
+	d_add(dentry, inode);
+	d_mark_dontcache(inode);
+	return NULL;
+}
+
+/*
+ * Lookup in option-specific directory (e.g., /mount/options/lowerdir/)
+ * Return numbered entries (0, 1, 2, ...) as symlinks
+ */
+static struct dentry *metafs_option_values_lookup(struct inode *dir,
+						  struct dentry *dentry,
+						  unsigned int flags)
+{
+	const char *target_name = dentry->d_name.name;
+	struct metafs_dentry_info *parent_info, *info;
+	struct metafs_option_entry *entry;
+	struct inode *inode;
+	unsigned long index;
+	int err;
+
+	parent_info = dentry->d_parent->d_fsdata;
+	if (WARN_ON(!parent_info || parent_info->type != METAFS_OPTION_VALUES))
+		return ERR_PTR(-ENOENT);
+
+	if (target_name[0] == '0' && target_name[1])
+		return ERR_PTR(-ENOENT);
+
+	err = kstrtoul(target_name, 10, &index);
+	if (err || index >= parent_info->opt_values.count)
+		return ERR_PTR(-ENOENT);
+
+	entry = &parent_info->opt_values.entries[index];
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->type = METAFS_SYMLINK;
+	if (entry->value) {
+		info->symlink.value = kstrdup(entry->value, GFP_KERNEL);
+		if (!info->symlink.value) {
+			kfree(info);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+	if (entry->path.mnt) {
+		info->symlink.path = entry->path;
+		path_get(&info->symlink.path);
+	}
+
+	inode = metafs_get_inode(dir->i_sb, S_IFLNK | 0777, NULL);
+	if (!inode) {
+		kfree(info->symlink.value);
+		if (info->symlink.path.mnt)
+			path_put(&info->symlink.path);
+		kfree(info);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dentry->d_fsdata = info;
+	d_add(dentry, inode);
+	d_mark_dontcache(inode);
+	return NULL;
+}
+
+/*
+ * Helper to get base file from any metafs dentry
+ */
+static struct file *metafs_get_base_file(struct dentry *dentry)
+{
+	while (dentry) {
+		struct metafs_dentry_info *info = dentry->d_fsdata;
+
+		if (info && info->type == METAFS_ROOT)
+			return info->root.base;
+		if (dentry == dentry->d_parent)
+			break;
+		dentry = dentry->d_parent;
+	}
+	return NULL;
+}
+
+/*
+ * Create the root directory structure for a metadata open
+ */
+static struct dentry *metafs_create_root(struct file *base)
+{
+	struct inode *inode;
+	struct dentry *root;
+	struct super_block *sb = metafs_mnt->mnt_sb;
+	struct metafs_dentry_info *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->type = METAFS_ROOT;
+	info->root.base = get_file(base);
+
+	inode = metafs_get_inode(sb, S_IFDIR | 0555, &metafs_root_dir_iops);
+	if (!inode) {
+		fput(info->root.base);
+		kfree(info);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	root = d_alloc_anon(sb);
+	if (!root) {
+		iput(inode);
+		fput(info->root.base);
+		kfree(info);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Store the info in d_fsdata before instantiating */
+	root->d_fsdata = info;
+	d_instantiate(root, inode);
+	d_mark_dontcache(inode);
+
+	return root;
+}
+
+/*
+ * Get metadata root path for a base file.
+ *
+ * This is called from path_init() when O_ALT is used.
+ * It returns a path in the metafs that serves as the root
+ * for the metadata lookup.
+ */
+int metafs_get_root(struct file *base, struct path *path)
+{
+	struct dentry *root;
+
+	if (!base)
+		return -EBADF;
+
+	/* Create the metadata root for this base file */
+	root = metafs_create_root(base);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	/*
+	 * Return the path to the metadata root.
+	 * Normal VFS lookup will take over from here.
+	 */
+	path->mnt = mntget(metafs_mnt);
+	path->dentry = root;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(metafs_get_root);
+
+static int __init metafs_init(void)
+{
+	int err;
+
+	err = register_filesystem(&metafs_type);
+	if (err)
+		return err;
+
+	metafs_mnt = kern_mount(&metafs_type);
+	if (IS_ERR(metafs_mnt)) {
+		err = PTR_ERR(metafs_mnt);
+		unregister_filesystem(&metafs_type);
+		return err;
+	}
+	set_default_d_op(metafs_mnt->mnt_sb, &metafs_dentry_ops);
+
+	return 0;
+}
+
+fs_initcall(metafs_init);
diff --git a/fs/metafs/metafs.h b/fs/metafs/metafs.h
new file mode 100644
index 000000000000..d257714260a7
--- /dev/null
+++ b/fs/metafs/metafs.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_METAFS_H
+#define _LINUX_METAFS_H
+
+struct path;
+struct file;
+
+/*
+ * Get metadata root path for a base file.
+ * Called from path_init() when O_ALT flag is used.
+ * Returns 0 on success with path filled in, -errno on error.
+ */
+int metafs_get_root(struct file *base, struct path *path);
+
+#endif /* _LINUX_METAFS_H */
diff --git a/fs/mount.h b/fs/mount.h
index 94fcc306d21e..69a953bc112b 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -65,7 +65,6 @@ struct mount {
 	struct mount * __aligned(1) *mnt_pprev_for_sb;
 					/* except that LSB of pprev is stolen */
 #define WRITE_HOLD 1			/* ... for use by mnt_hold_writers() */
-	const char *mnt_devname;	/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct list_head mnt_share;	/* circular list of shared mounts */
diff --git a/fs/namei.c b/fs/namei.c
index 19ce43c9a6e6..437a14c432e6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -45,6 +45,7 @@
 
 #include "internal.h"
 #include "mount.h"
+#include "metafs/metafs.h"
 
 /* [Feb-1997 T. Schoebel-Theuer]
  * Fundamental changes in the pathname lookup mechanisms (namei)
@@ -2753,6 +2754,21 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 				return ERR_PTR(-ENOENT);
 		}
 
+		if (unlikely(flags & LOOKUP_ALT)) {
+			if (flags & LOOKUP_RCU)
+				return ERR_PTR(-ECHILD);
+
+			/* Handle O_ALT: jump to metafs root */
+			error = metafs_get_root(fd_file(f), &nd->path);
+			if (error)
+				return ERR_PTR(error);
+
+			nd->inode = nd->path.dentry->d_inode;
+			nd->state |= ND_JUMPED;
+
+			return s;
+		}
+
 		dentry = fd_file(f)->f_path.dentry;
 
 		if (*s && unlikely(!d_can_lookup(dentry)))
diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05..62cc71c401a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -282,7 +282,7 @@ int mnt_get_count(struct mount *mnt)
 #endif
 }
 
-static struct mount *alloc_vfsmnt(const char *name)
+static struct mount *alloc_vfsmnt(void)
 {
 	struct mount *mnt = kmem_cache_zalloc(mnt_cache, GFP_KERNEL);
 	if (mnt) {
@@ -292,18 +292,10 @@ static struct mount *alloc_vfsmnt(const char *name)
 		if (err)
 			goto out_free_cache;
 
-		if (name)
-			mnt->mnt_devname = kstrdup_const(name,
-							 GFP_KERNEL_ACCOUNT);
-		else
-			mnt->mnt_devname = "none";
-		if (!mnt->mnt_devname)
-			goto out_free_id;
-
 #ifdef CONFIG_SMP
 		mnt->mnt_pcp = alloc_percpu(struct mnt_pcp);
 		if (!mnt->mnt_pcp)
-			goto out_free_devname;
+			goto out_free_id;
 
 		this_cpu_add(mnt->mnt_pcp->mnt_count, 1);
 #else
@@ -328,11 +320,9 @@ static struct mount *alloc_vfsmnt(const char *name)
 	return mnt;
 
 #ifdef CONFIG_SMP
-out_free_devname:
-	kfree_const(mnt->mnt_devname);
-#endif
 out_free_id:
 	mnt_free_id(mnt);
+#endif
 out_free_cache:
 	kmem_cache_free(mnt_cache, mnt);
 	return NULL;
@@ -725,7 +715,6 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 static void free_vfsmnt(struct mount *mnt)
 {
 	mnt_idmap_put(mnt_idmap(&mnt->mnt));
-	kfree_const(mnt->mnt_devname);
 #ifdef CONFIG_SMP
 	free_percpu(mnt->mnt_pcp);
 #endif
@@ -1180,7 +1169,7 @@ struct vfsmount *vfs_create_mount(struct fs_context *fc)
 	if (!fc->root)
 		return ERR_PTR(-EINVAL);
 
-	mnt = alloc_vfsmnt(fc->source);
+	mnt = alloc_vfsmnt();
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
@@ -1248,7 +1237,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	struct mount *mnt;
 	int err;
 
-	mnt = alloc_vfsmnt(old->mnt_devname);
+	mnt = alloc_vfsmnt();
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
@@ -2957,16 +2946,12 @@ static int do_change_type(const struct path *path, int ms_flags)
 static inline bool may_copy_tree(const struct path *path)
 {
 	struct mount *mnt = real_mount(path->mnt);
-	const struct dentry_operations *d_op;
 
 	if (check_mnt(mnt))
 		return true;
 
-	d_op = path->dentry->d_op;
-	if (d_op == &ns_dentry_operations)
-		return true;
-
-	if (d_op == &pidfs_dentry_operations)
+	/* Make an exception for internal mounts explicitly marked as clonable */
+	if (mnt->mnt_ns == MNT_NS_INTERNAL && mnt->mnt.mnt_flags & MNT_CLONABLE)
 		return true;
 
 	if (!is_mounted(path->mnt))
@@ -3201,7 +3186,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 	if (flags & ~(AT_EMPTY_PATH | AT_NO_AUTOMOUNT | AT_RECURSIVE |
 		      AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLONE |
-		      OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE))
+		      OPEN_TREE_CLOEXEC | OPEN_TREE_NAMESPACE | OPEN_TREE_ALT))
 		return ERR_PTR(-EINVAL);
 
 	if ((flags & (AT_RECURSIVE | OPEN_TREE_CLONE | OPEN_TREE_NAMESPACE)) ==
@@ -3215,6 +3200,8 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 		lookup_flags &= ~LOOKUP_AUTOMOUNT;
 	if (flags & AT_SYMLINK_NOFOLLOW)
 		lookup_flags &= ~LOOKUP_FOLLOW;
+	if (flags & OPEN_TREE_ALT)
+		lookup_flags |= LOOKUP_ALT;
 
 	/*
 	 * If we create a new mount namespace with the cloned mount tree we
@@ -5387,7 +5374,6 @@ static void statmount_fs_subtype(struct kstatmount *s, struct seq_file *seq)
 static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
 {
 	struct super_block *sb = s->mnt->mnt_sb;
-	struct mount *r = real_mount(s->mnt);
 
 	if (sb->s_op->show_devname) {
 		size_t start = seq->count;
@@ -5405,7 +5391,7 @@ static int statmount_sb_source(struct kstatmount *s, struct seq_file *seq)
 		seq->count = start;
 		seq_commit(seq, string_unescape_inplace(seq->buf + start, UNESCAPE_OCTAL));
 	} else {
-		seq_puts(seq, r->mnt_devname);
+		seq_puts(seq, sb->s_devname);
 	}
 	return 0;
 }
@@ -5416,6 +5402,40 @@ static void statmount_mnt_ns_id(struct kstatmount *s, struct mnt_namespace *ns)
 	s->sm.mnt_ns_id = ns->ns.ns_id;
 }
 
+void sb_add_option(struct sb_opt_ctx *ctx, const char *name, const char *value)
+{
+	sb_add_option_path(ctx, name, value, NULL);
+}
+
+void sb_add_option_path(struct sb_opt_ctx *ctx, const char *name, const char *value,
+			const struct path *path)
+{
+	ctx->actor(ctx, name, value, path);
+}
+
+static void do_show_option(struct sb_opt_ctx *ctx, const char *name, const char *value,
+			   const struct path *path)
+{
+	if (strcmp(name, "source") != 0)
+		seq_show_option(ctx->data, name, value);
+}
+
+int mnt_show_options(struct seq_file *seq, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+
+	if (sb->s_op->show_options)
+		return sb->s_op->show_options(seq, mnt->mnt_root);
+
+	if (sb->s_op->get_options) {
+		struct sb_opt_ctx ctx = { .data = seq, .actor = do_show_option };
+
+		return sb->s_op->get_options(&ctx, mnt->mnt_root);
+	}
+
+	return 0;
+}
+
 static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
@@ -5427,11 +5447,9 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	if (err)
 		return err;
 
-	if (sb->s_op->show_options) {
-		err = sb->s_op->show_options(seq, mnt->mnt_root);
-		if (err)
-			return err;
-	}
+	err = mnt_show_options(seq, mnt);
+	if (err)
+		return err;
 
 	if (unlikely(seq_has_overflowed(seq)))
 		return -EAGAIN;
@@ -5479,14 +5497,10 @@ static inline int statmount_opt_process(struct seq_file *seq, size_t start)
 static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
-	struct super_block *sb = mnt->mnt_sb;
 	size_t start = seq->count;
 	int err;
 
-	if (!sb->s_op->show_options)
-		return 0;
-
-	err = sb->s_op->show_options(seq, mnt->mnt_root);
+	err = mnt_show_options(seq, mnt);
 	if (err)
 		return err;
 
diff --git a/fs/nsfs.c b/fs/nsfs.c
index c3b6ae76594a..e110130d0760 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -684,6 +684,7 @@ void __init nsfs_init(void)
 	if (IS_ERR(nsfs_mnt))
 		panic("can't set nsfs up\n");
 	nsfs_mnt->mnt_sb->s_flags &= ~SB_NOUSER;
+	nsfs_mnt->mnt_flags |= MNT_CLONABLE;
 	nsfs_root_path.mnt = nsfs_mnt;
 	nsfs_root_path.dentry = nsfs_mnt->mnt_root;
 }
diff --git a/fs/open.c b/fs/open.c
index 408925d7bd0b..3a081a9e3062 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1131,7 +1131,8 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_EMPTYPATH)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_EMPTYPATH | \
+				 O_ALT)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1283,6 +1284,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_FOLLOW;
 	if (flags & O_EMPTYPATH)
 		lookup_flags |= LOOKUP_EMPTY;
+	if (flags & O_ALT)
+		lookup_flags |= LOOKUP_ALT;
 
 	if (how->resolve & RESOLVE_NO_XDEV)
 		lookup_flags |= LOOKUP_NO_XDEV;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c93fcaa45d4a..c5a9e858e366 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -1046,10 +1046,11 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
  * Prints the mount options for a given superblock.
  * Returns zero; does not fail.
  */
-int ovl_show_options(struct seq_file *m, struct dentry *dentry)
+int ovl_get_options(struct sb_opt_ctx *ctx, struct dentry *dentry)
 {
 	struct super_block *sb = dentry->d_sb;
 	struct ovl_fs *ofs = OVL_FS(sb);
+	struct path upperpath;
 	size_t nr, nr_merged_lower, nr_lower = 0;
 	char **lowerdirs = ofs->config.lowerdirs;
 
@@ -1062,43 +1063,47 @@ int ovl_show_options(struct seq_file *m, struct dentry *dentry)
 	 * with the new lowerdir+ and datadir+ mount options.
 	 */
 	if (lowerdirs[0]) {
-		seq_show_option(m, "lowerdir", lowerdirs[0]);
+		sb_add_option(ctx, "lowerdir", lowerdirs[0]);
 	} else {
 		nr_lower = ofs->numlayer;
 		nr_merged_lower = nr_lower - ofs->numdatalayer;
 	}
 	for (nr = 1; nr < nr_lower; nr++) {
+		struct path lowerpath = {
+			.mnt = ofs->layers[nr].mnt,
+			.dentry = ofs->layers[nr].mnt->mnt_root,
+		};
 		if (nr < nr_merged_lower)
-			seq_show_option(m, "lowerdir+", lowerdirs[nr]);
+			sb_add_option_path(ctx, "lowerdir+", lowerdirs[nr],
+					   &lowerpath);
 		else
-			seq_show_option(m, "datadir+", lowerdirs[nr]);
+			sb_add_option_path(ctx, "datadir+", lowerdirs[nr],
+					   &lowerpath);
 	}
 	if (ofs->config.upperdir) {
-		seq_show_option(m, "upperdir", ofs->config.upperdir);
-		seq_show_option(m, "workdir", ofs->config.workdir);
+		ovl_path_upper(sb->s_root, &upperpath);
+		sb_add_option_path(ctx, "upperdir", ofs->config.upperdir, &upperpath);
+		sb_add_option(ctx, "workdir", ofs->config.workdir);
 	}
 	if (ofs->config.default_permissions)
-		seq_puts(m, ",default_permissions");
+		sb_add_option(ctx, "default_permissions", NULL);
 	if (ofs->config.redirect_mode != ovl_redirect_mode_def())
-		seq_printf(m, ",redirect_dir=%s",
-			   ovl_redirect_mode(&ofs->config));
+		sb_add_option(ctx, "redirect_dir", ovl_redirect_mode(&ofs->config));
 	if (ofs->config.index != ovl_index_def)
-		seq_printf(m, ",index=%s", str_on_off(ofs->config.index));
+		sb_add_option(ctx, "index", str_on_off(ofs->config.index));
 	if (ofs->config.uuid != ovl_uuid_def())
-		seq_printf(m, ",uuid=%s", ovl_uuid_mode(&ofs->config));
+		sb_add_option(ctx, "uuid", ovl_uuid_mode(&ofs->config));
 	if (ofs->config.nfs_export != ovl_nfs_export_def)
-		seq_printf(m, ",nfs_export=%s",
-			   str_on_off(ofs->config.nfs_export));
+		sb_add_option(ctx, "nfs_export", str_on_off(ofs->config.nfs_export));
 	if (ofs->config.xino != ovl_xino_def() && !ovl_same_fs(ofs))
-		seq_printf(m, ",xino=%s", ovl_xino_mode(&ofs->config));
+		sb_add_option(ctx, "xino", ovl_xino_mode(&ofs->config));
 	if (ofs->config.metacopy != ovl_metacopy_def)
-		seq_printf(m, ",metacopy=%s", str_on_off(ofs->config.metacopy));
+		sb_add_option(ctx, "metacopy", str_on_off(ofs->config.metacopy));
 	if (ofs->config.fsync_mode != ovl_fsync_mode_def())
-		seq_printf(m, ",fsync=%s", ovl_fsync_mode(&ofs->config));
+		sb_add_option(ctx, "fsync", ovl_fsync_mode(&ofs->config));
 	if (ofs->config.userxattr)
-		seq_puts(m, ",userxattr");
+		sb_add_option(ctx, "userxattr", NULL);
 	if (ofs->config.verity_mode != ovl_verity_mode_def())
-		seq_printf(m, ",verity=%s",
-			   ovl_verity_mode(&ofs->config));
+		sb_add_option(ctx, "verity", ovl_verity_mode(&ofs->config));
 	return 0;
 }
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
index ffd53cdd8482..2cf9c4f188a9 100644
--- a/fs/overlayfs/params.h
+++ b/fs/overlayfs/params.h
@@ -40,5 +40,5 @@ int ovl_init_fs_context(struct fs_context *fc);
 void ovl_free_fs(struct ovl_fs *ofs);
 int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			 struct ovl_config *config);
-int ovl_show_options(struct seq_file *m, struct dentry *dentry);
+int ovl_get_options(struct sb_opt_ctx *ctx, struct dentry *dentry);
 const char *ovl_xino_mode(struct ovl_config *config);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 60f0b7ceef0a..4b57b2db0852 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -302,7 +302,7 @@ static const struct super_operations ovl_super_operations = {
 	.put_super	= ovl_put_super,
 	.sync_fs	= ovl_sync_fs,
 	.statfs		= ovl_statfs,
-	.show_options	= ovl_show_options,
+	.get_options	= ovl_get_options,
 };
 
 #define OVL_WORKDIR_NAME "work"
@@ -529,6 +529,7 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 
 	/* Don't inherit atime flags */
 	upper_mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
+	upper_mnt->mnt_flags |= MNT_CLONABLE;
 	upper_layer->mnt = upper_mnt;
 	upper_layer->idx = 0;
 	upper_layer->fsid = 0;
@@ -1105,7 +1106,7 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		 * Make lower layers R/O.  That way fchmod/fchown on lower file
 		 * will fail instead of modifying lower fs.
 		 */
-		mnt->mnt_flags |= MNT_READONLY | MNT_NOATIME;
+		mnt->mnt_flags |= MNT_READONLY | MNT_NOATIME | MNT_CLONABLE;
 
 		layers[ofs->numlayer].trap = trap;
 		layers[ofs->numlayer].mnt = mnt;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index aaa609ddab04..3843acd6594d 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -840,7 +840,7 @@ static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 	return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");
 }
 
-const struct dentry_operations pidfs_dentry_operations = {
+static const struct dentry_operations pidfs_dentry_operations = {
 	.d_dname	= pidfs_dname,
 	.d_prune	= stashed_dentry_prune,
 };
@@ -1151,6 +1151,8 @@ void __init pidfs_init(void)
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");
 
+	pidfs_mnt->mnt_flags |= MNT_CLONABLE;
+
 	pidfs_root_path.mnt = pidfs_mnt;
 	pidfs_root_path.dentry = pidfs_mnt->mnt_root;
 }
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 5c555db68aa2..94bc4c9aa43f 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -98,21 +98,27 @@ static void show_type(struct seq_file *m, struct super_block *sb)
 	}
 }
 
+static int show_devname(struct seq_file *m, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+
+	if (sb->s_op->show_devname)
+		return sb->s_op->show_devname(m, mnt->mnt_root);
+
+	mangle(m, sb->s_devname);
+	return 0;
+}
+
 static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct proc_mounts *p = m->private;
-	struct mount *r = real_mount(mnt);
 	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
 	struct super_block *sb = mnt_path.dentry->d_sb;
 	int err;
 
-	if (sb->s_op->show_devname) {
-		err = sb->s_op->show_devname(m, mnt_path.dentry);
-		if (err)
-			goto out;
-	} else {
-		mangle(m, r->mnt_devname);
-	}
+	err = show_devname(m, mnt);
+	if (err)
+		goto out;
 	seq_putc(m, ' ');
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
 	err = seq_path_root(m, &mnt_path, &p->root, " \t\n\\");
@@ -125,8 +131,7 @@ static int show_vfsmnt(struct seq_file *m, struct vfsmount *mnt)
 	if (err)
 		goto out;
 	show_vfsmnt_opts(m, mnt);
-	if (sb->s_op->show_options)
-		err = sb->s_op->show_options(m, mnt_path.dentry);
+	err = mnt_show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
 out:
 	return err;
@@ -172,19 +177,14 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 	seq_puts(m, " - ");
 	show_type(m, sb);
 	seq_putc(m, ' ');
-	if (sb->s_op->show_devname) {
-		err = sb->s_op->show_devname(m, mnt->mnt_root);
-		if (err)
-			goto out;
-	} else {
-		mangle(m, r->mnt_devname);
-	}
+	err = show_devname(m, mnt);
+	if (err)
+		goto out;
 	seq_puts(m, sb_rdonly(sb) ? " ro" : " rw");
 	err = show_sb_opts(m, sb);
 	if (err)
 		goto out;
-	if (sb->s_op->show_options)
-		err = sb->s_op->show_options(m, mnt->mnt_root);
+	err = mnt_show_options(m, mnt);
 	seq_putc(m, '\n');
 out:
 	return err;
@@ -193,21 +193,15 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
 {
 	struct proc_mounts *p = m->private;
-	struct mount *r = real_mount(mnt);
 	struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
 	struct super_block *sb = mnt_path.dentry->d_sb;
 	int err;
 
 	/* device */
 	seq_puts(m, "device ");
-	if (sb->s_op->show_devname) {
-		err = sb->s_op->show_devname(m, mnt_path.dentry);
-		if (err)
-			goto out;
-	} else {
-		mangle(m, r->mnt_devname);
-	}
-
+	err = show_devname(m, mnt);
+	if (err)
+		goto out;
 	/* mount point */
 	seq_puts(m, " mounted on ");
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
diff --git a/fs/super.c b/fs/super.c
index a8fd61136aaf..e5531cb88f89 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -280,6 +280,7 @@ static void destroy_super_work(struct work_struct *work)
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
+	kfree_const(s->s_devname);
 	for (int i = 0; i < SB_FREEZE_LEVELS; i++)
 		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
 	kfree(s);
@@ -315,7 +316,7 @@ static void destroy_unused_super(struct super_block *s)
  *	returns a pointer new superblock or %NULL if allocation had failed.
  */
 static struct super_block *alloc_super(struct file_system_type *type, int flags,
-				       struct user_namespace *user_ns)
+				       struct user_namespace *user_ns, const char *name)
 {
 	struct super_block *s = kzalloc_obj(struct super_block);
 	static const struct super_operations default_op;
@@ -344,6 +345,13 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	 */
 	down_write_nested(&s->s_umount, SINGLE_DEPTH_NESTING);
 
+	if (name)
+		s->s_devname = kstrdup_const(name, GFP_KERNEL_ACCOUNT);
+	else
+		s->s_devname = "none";
+	if (!s->s_devname)
+		goto fail;
+
 	if (security_sb_alloc(s))
 		goto fail;
 
@@ -763,7 +771,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	}
 	if (!s) {
 		spin_unlock(&sb_lock);
-		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
+		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns, fc->source);
 		if (!s)
 			return ERR_PTR(-ENOMEM);
 		goto retry;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 6ad6b9e7a226..f942411c8ed7 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -11,7 +11,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_EMPTYPATH | O_ALT)
 
 /* List of all valid flags for openat2(2)'s how->flags argument. */
 #define VALID_OPENAT2_FLAGS	(VALID_OPEN_FLAGS | OPENAT2_REGULAR)
diff --git a/include/linux/fs/super.h b/include/linux/fs/super.h
index 405612678115..6f0d778940f9 100644
--- a/include/linux/fs/super.h
+++ b/include/linux/fs/super.h
@@ -237,4 +237,14 @@ int thaw_super(struct super_block *super, enum freeze_holder who,
 
 int sb_init_dio_done_wq(struct super_block *sb);
 
+struct sb_opt_ctx {
+	void (*actor)(struct sb_opt_ctx *ctx, const char *name, const char *value,
+		      const struct path *path);
+	void *data;
+};
+
+void sb_add_option(struct sb_opt_ctx *ctx, const char *name, const char *value);
+void sb_add_option_path(struct sb_opt_ctx *ctx, const char *name, const char *value,
+			const struct path *path);
+
 #endif /* _LINUX_FS_SUPER_H */
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ef7941e9dc79..f205759af1a6 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -36,6 +36,7 @@ struct workqueue_struct;
 struct writeback_control;
 struct xattr_handler;
 struct fserror_event;
+struct sb_opt_ctx;
 
 extern struct super_block *blockdev_superblock;
 
@@ -99,6 +100,7 @@ struct super_operations {
 	int (*statfs)(struct dentry *dentry, struct kstatfs *kstatfs);
 	void (*umount_begin)(struct super_block *sb);
 
+	int (*get_options)(struct sb_opt_ctx *ctx, struct dentry *dentry);
 	int (*show_options)(struct seq_file *seq, struct dentry *dentry);
 	int (*show_devname)(struct seq_file *seq, struct dentry *dentry);
 	int (*show_path)(struct seq_file *seq, struct dentry *dentry);
@@ -283,6 +285,8 @@ struct super_block {
 	 */
 	atomic_t				s_isw_nr_in_flight;
 #endif
+	/* Name of device e.g. /dev/dsk/hda1 */
+	const char 				*s_devname;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..d071855ca4ed 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -44,6 +44,7 @@ enum mount_flags {
 	MNT_LOCKED		= 0x800000,
 	MNT_DOOMED		= 0x1000000,
 	MNT_SYNC_UMOUNT		= 0x2000000,
+	MNT_CLONABLE		= 0x4000000,
 	MNT_UMOUNT		= 0x8000000,
 
 	MNT_USER_SETTABLE_MASK  = MNT_NOSUID | MNT_NODEV | MNT_NOEXEC
@@ -52,7 +53,7 @@ enum mount_flags {
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
 	MNT_INTERNAL_FLAGS = MNT_INTERNAL | MNT_DOOMED |
-			     MNT_SYNC_UMOUNT | MNT_LOCKED
+			     MNT_SYNC_UMOUNT | MNT_LOCKED | MNT_CLONABLE
 };
 
 struct vfsmount {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index ebe6e29f7e93..c21dc6536900 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -25,7 +25,8 @@ enum { MAX_NESTED_LINKS = 8 };
 #define LOOKUP_RCU		BIT(8)	/* RCU pathwalk mode; semi-internal */
 #define LOOKUP_CACHED		BIT(9) /* Only do cached lookup */
 #define LOOKUP_PARENT		BIT(10)	/* Looking up final parent in path */
-/* 5 spare bits for pathwalk */
+#define LOOKUP_ALT		BIT(11) /* Look up in alternative namespace */
+/* 4 spare bits for pathwalk */
 
 /* These tell filesystem methods that we are dealing with the final component... */
 #define LOOKUP_OPEN		BIT(16)	/* ... in open */
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 0abf7da9ab23..fab6f48ff203 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -15,7 +15,6 @@ void pidfs_exit(struct task_struct *tsk);
 #ifdef CONFIG_COREDUMP
 void pidfs_coredump(const struct coredump_params *cprm);
 #endif
-extern const struct dentry_operations pidfs_dentry_operations;
 int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp);
 
 /**
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 883cfd7de2ef..70dbbac1c520 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -96,6 +96,10 @@
 #define O_EMPTYPATH	(1 << 26)	/* allow empty path */
 #endif
 
+#ifndef O_ALT
+#define O_ALT		(1 << 27)	/* Open in alternative namespace */
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2204708dbf7a..6e794d214cf9 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -63,6 +63,7 @@
  */
 #define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
 #define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
+#define OPEN_TREE_ALT		(1 << 2)	/* Lookup in alternative namespace */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
index 65dd1bd12964..5aaf2dd8db05 100644
--- a/scripts/gdb/linux/proc.py
+++ b/scripts/gdb/linux/proc.py
@@ -174,9 +174,6 @@ values of that process namespace"""
                   "mount", "super_block", "devname", "pathname", "fstype"))
 
         for mnt in rbtree.rb_inorder_for_each_entry(namespace['mounts'], mount_ptr_type, "mnt_node"):
-            devname = mnt['mnt_devname'].string()
-            devname = devname if devname else "none"
-
             pathname = ""
             parent = mnt
             while True:
@@ -190,6 +187,8 @@ values of that process namespace"""
                 pathname = "/"
 
             superblock = mnt['mnt']['mnt_sb']
+            devname = superblock['s_devname'].string()
+            devname = devname if devname else "none"
             fstype = superblock['s_type']['name'].string()
             s_flags = int(superblock['s_flags'])
             m_flags = int(mnt['mnt']['mnt_flags'])
-- 
2.54.0


