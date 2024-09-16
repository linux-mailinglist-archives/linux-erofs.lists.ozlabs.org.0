Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3FE97A34C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495040;
	bh=PJC+8jRBBBR/onvAu4WHTXjuB2eZs+/U1I9QC+qBq5s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Cr3Ia6ck/4SkNmIc3Ve4vyRA1jd25upjoWjRJVVHRkg7fwNUEknfWy7arDIDCLLNH
	 BlVvkwSDHPV7MW1LnabSug0wf3oO855Xju1ypyMl2P5mBmVXG8mt26v/qmJqM2zg+v
	 b209QMxNN+VDEzaTHDb9sLOnB5BwDC3SFTdeRjwB8yBjquNJOsLrT5VJi1++R16pmq
	 y4LHG24JbYlyJf+W5kTbPeMD1APAvIssRQ/Vj4XCOaJlzfCUAfVKQCx+95yEu0ksJ5
	 Xvy5uZ8a5UGpIrjv9NEXBDcRrjSmwIhEfeTJPPc6fcP3KtMyMFwLvIyUy6FIfX50AG
	 It1WjJOk74S7A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgh6nc9z3cHN
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495039;
	cv=none; b=TKGnpHpg7YlTuNet1LbjUGcv3geQuwP7OuMptcPGKtuxi6gGOKGAwb3MaUs9Iv+fkEsIzkslFcCXXzyGC+XwempRkGU8zEDNhB3TLwlNSuu5VApu+6KyBjL2c/UKBGe4YN9Gz2gXUJLOJIrYEGFM+E4K1CoKnDzh194kqYHreRxqqPrgrDxLaTEe5fPrg5GMNrKUwBxgFx+StTW2MRfqBgls8OYZHSKBhW0a9q4FrLR0xcl7XvIiAFnE+drB9nya608ElHvzWfEXHBh+RLF1ZV8zAiRJrSe2l0uiQpMdNEiV9yX1h2A91IPQn//OLbkvodTt8PQ1aLHCiNpbm+P00w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495039; c=relaxed/relaxed;
	bh=PJC+8jRBBBR/onvAu4WHTXjuB2eZs+/U1I9QC+qBq5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB3hcql4xCqgBuRh1Rz8zQeCd+/44dG5BHAvqH1EFYPcRtV9CL2S3WqF6PGteaIH9nfzN89PdY4pC1PM9Hn+iqrHEKXuB1/xC1k6CT9XE5humAJ1gLN57PJ7l84Y/zOMSjzLji8bLr/6DicVEKCs/VrSXfY2MB/rpwhd0rST5Qtzf/D2vPwBXJam6bYzb0bJrR+b+8utCuziBs/DHZa9FuNojPyPpEbYoKQcSMQNjNe8YYVx6/4Eo2b8V428qmNB4GG4BNrxQGk0Ik10Ps5mb0n9KjPumxl+H0FFzln2r3QyAYKDf3RPrGhfi1X3l8zun3Jget21trPcHDN9pBajJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=jWV+aFZQ; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=jWV+aFZQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgg2WTYz2ysB
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:19 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6959869981;
	Mon, 16 Sep 2024 09:57:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495037; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=PJC+8jRBBBR/onvAu4WHTXjuB2eZs+/U1I9QC+qBq5s=;
	b=jWV+aFZQUroYA6ESh1hKZd3vfmMWYPu9Uq2vVLl32hAOGy/VZ4pGNk96YKOUnWNudiIsg6
	DBPyRMbCZByWdUx9yyknSavniNyCSrExlnFblJaSXcN2HCBjj5PUaH8t5ENhZjeWH8t5Ao
	TXIVyB5Ai/Sw1UNP5SsxvgNd74GJog45DBCvPiuQKHsfR+lPDNj+11amvNszH/doWkk5PT
	HDpYpHIrFI/WObyup+4Tpk1wImstQ4X3n6RAT0a7E4f2XdZD+YtAz3g2v37TykytMMbm0w
	gEE4VS7I3E1eCL2M5WoPaRXv+s+He11gjIwtPoxaYmqlcrfBRmfbrTHS3Ghdxw==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 20/24] erofs: introduce readdir alternative to C
Date: Mon, 16 Sep 2024 21:56:30 +0800
Message-ID: <20240916135634.98554-21-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135634.98554-1-toolmanp@tlmp.cc>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduce erofs_readdir_rust as an alternative
for erofs_readdir written in Rust.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |  2 +-
 fs/erofs/dir.c           |  2 ++
 fs/erofs/dir_rs.rs       | 57 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/internal.h      |  1 +
 fs/erofs/rust_bindings.h |  1 +
 5 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/dir_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 0f748f3e0ff6..e086487971b6 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o rust_helpers.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o dir_rs.o rust_helpers.o
diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index c3b90abdee37..0f5df8a4169b 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -6,6 +6,7 @@
  */
 #include "internal.h"
 
+#ifndef CONFIG_EROFS_FS_RUST
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			       void *dentry_blk, struct erofs_dirent *de,
 			       unsigned int nameoff0, unsigned int maxsize)
@@ -92,6 +93,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 	erofs_put_metabuf(&buf);
 	return err < 0 ? err : 0;
 }
+#endif
 
 const struct file_operations erofs_dir_fops = {
 	.llseek		= generic_file_llseek,
diff --git a/fs/erofs/dir_rs.rs b/fs/erofs/dir_rs.rs
new file mode 100644
index 000000000000..d965e6076242
--- /dev/null
+++ b/fs/erofs/dir_rs.rs
@@ -0,0 +1,57 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+//! EROFS Rust Kernel Module Helpers Implementation
+//! This is only for experimental purpose. Feedback is always welcome.
+
+#[allow(dead_code)]
+#[allow(missing_docs)]
+pub(crate) mod rust;
+use core::ffi::*;
+use core::ptr::NonNull;
+
+use kernel::bindings::{dir_context, file};
+use kernel::container_of;
+
+use rust::{
+    erofs_sys::{inode::*, *},
+    kinode::*,
+    ksuperblock::*,
+};
+
+/// Exported as a replacement of erofs_readdir.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_readdir_rust(
+    f: NonNull<file>,
+    mut ctx: NonNull<dir_context>,
+) -> c_int {
+    // SAFETY: inode is always initialized in file.
+    let k_inode = unsafe { f.as_ref().f_inode };
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode, KernelInode, k_inode) };
+    // SAFETY: The super_block is always initialized when calling iget5_locked.
+    let sb = unsafe { (*k_inode).i_sb };
+    let sbi = erofs_sbi(NonNull::new(sb).unwrap());
+    // SAFETY: ctx is nonnull.
+    let offset = unsafe { ctx.as_ref().pos };
+    match sbi
+        .filesystem
+        .fill_dentries(erofs_inode, offset as Off, &mut |dir, pos| unsafe {
+            // inline expansion from dir_emit
+            ctx.as_ref().actor.unwrap()(
+                ctx.as_ptr(),
+                dir.name.as_ptr().cast(),
+                dir.name.len() as i32,
+                pos as i64,
+                dir.desc.nid as u64,
+                dir.desc.file_type as u32,
+            );
+            ctx.as_mut().pos = pos as i64;
+        }) {
+        Ok(_) => {
+            unsafe { ctx.as_mut().pos = erofs_inode.info().file_size() as i64 }
+            0
+        }
+        Err(e) => (i32::from(e)) as c_int,
+    }
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1d9dfae285d5..6f57bb866637 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -444,6 +444,7 @@ int erofs_iget5_set(struct inode *inode, void *opaque);
 #define erofs_iget erofs_iget_rust
 #define erofs_get_parent erofs_get_parent_rust
 #define erofs_lookup erofs_lookup_rust
+#define erofs_readdir erofs_readdir_rust
 #else
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 #endif
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index b35014aa5cae..8b71d65e2c0b 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -23,4 +23,5 @@ extern struct inode *erofs_iget_rust(struct super_block *sb, erofs_nid_t nid);
 extern struct dentry *erofs_lookup_rust(struct inode *inode, struct dentry *dentry,
 			      unsigned int flags);
 extern struct dentry *erofs_get_parent_rust(struct dentry *dentry);
+extern int erofs_readdir_rust(struct file *file, struct dir_context *ctx);
 #endif
-- 
2.46.0

