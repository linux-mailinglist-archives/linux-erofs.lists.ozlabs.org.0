Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03597A34A
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495040;
	bh=Wch3FBTJC/bfytZ3iSboViHurbJ2bB+wmP7ljpFHKFU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RPclmnkj00EPoaDGsTGRyEQfQuOW3PyzrTABv3o1tgrOaIOIqA18OxIEzavu3itOH
	 3ctXHnBmJZhzxOTbnbm0YnVW8aKVeI95Cy6/JgrPe/2hL0AZEDuYtq2Dz1urQSSjGn
	 T1DkYH8+qKgx/vSYLqE7qmqwmCZfn0yGE/VPlC0BFlbfWHoGlsrBleYXqbup3WlGpm
	 PEL5eTb+YCLL1iZRbhE62wT/f6kXseaSpXdzuMYd2229X8L0TBqSHuSwyLpCCikaKB
	 RS0ujYGrXeB5d5+ZggwheB4ld6K93DbIjVEtPIr6rL7463Z43JZfwkCmRb57ntVof2
	 reaH55bbsANcA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgh2Jfjz30Dw
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495037;
	cv=none; b=OgPL/a3n9WsBne3YtnY01rztyeOltbh/N8yfA+24j+ArWHZ7jvLsA6rwF0BaASZGWd9ciH62ZT9DKYKZdMQ/6kN9urHR6cf7NF1OCLhQDb01pncZ71/1u/f69tbFJ9nL0QEW3sNYt45NWdqfYNAnTR5/iRIlYT45KcLmGkHLTsODN3G/p6FP1zZMc2DWatFxnt7m7ZNRlXy/9caEPPFmjOrrN5KUfKXp7nwkZGHRFDM4ttLD9NDiD7mKe8BJqWgEn/qAEwX1lt95OsalGpv6NHRMo37ytpCudpWmjE4c7aVBJwdJEWyHPFOp7wrsZcM5JaYsXus8B0OIW7XEUaiLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495037; c=relaxed/relaxed;
	bh=Wch3FBTJC/bfytZ3iSboViHurbJ2bB+wmP7ljpFHKFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oNpueI8vGn3oImbcs7Vxk8df7BkPFwBhsbSkiKfMGZ8qQwxUL1MyPcL//Hy3keDMFGF2anp9UO/PWdber+u8lJV9pwAapYSJehNep54gBczSMaD3jySfkAHZl1i4NhlK4gzOwgjF5bTIH50KWkwBj3gV+XBXAfRJjogIaWCmTIXUvZQFUe0UlF8SZRNWGbK6QpSCbh95gPUn7RyeMNlzqOEDRue72XsnvCcKAW3YGBnyz7ev29IhUeRV+aIgc95qeKcl/53X4wJLQTnOr85ytiql9nrK/PfhsAotScBQB4yHGgL+sv2KYKBFGnu4gitIQ+MYo7ECjyH9SWuIWJMHJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=JAJ4mD6Y; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=JAJ4mD6Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgd3QkVz2yYK
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:17 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41C9B69988;
	Mon, 16 Sep 2024 09:57:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495035; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wch3FBTJC/bfytZ3iSboViHurbJ2bB+wmP7ljpFHKFU=;
	b=JAJ4mD6Y6Dz95HshWm2ZSD8lfpBJTL8YO+qZvc6z6pWLLcAayJcjvOqvAZ7DSODgg1RgQc
	ulM5shkDbh8AgRooTD35bJBgF+Uy2vhjqyq483jOhgeOZruvduGSyzLXRquBzadKyq/tvC
	Ya2JL42DKCXPN8vGkZa0NoRvWahIqemXs8weQq6S90d6Na4+dqhn+Y0hqtJNPAvksQcJbZ
	wqCTmbIlhY2WVrzzTlo2bmv+hswA9svhKXfpP3brGDVigu8wuftqOodhRHkIstiSdBCXvH
	oQRACxgsPBmL+zDXAOu4+sBPFEMypa/XBMn0r6GIJmyy6G4pXLse+Hue6vN8Vg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 19/24] erofs: introduce namei alternative to C
Date: Mon, 16 Sep 2024 21:56:29 +0800
Message-ID: <20240916135634.98554-20-toolmanp@tlmp.cc>
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

This patch introduces erofs_lookup_rust and erofs_get_parent_rust
written in Rust as an alternative to the original namei.c.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |  2 +-
 fs/erofs/internal.h      |  2 ++
 fs/erofs/namei.c         |  2 ++
 fs/erofs/namei_rs.rs     | 56 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/rust_bindings.h |  4 ++-
 fs/erofs/super.c         |  2 ++
 6 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 fs/erofs/namei_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 46de6f490ca2..0f748f3e0ff6 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o rust_helpers.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o rust_helpers.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 42ce84783be7..1d9dfae285d5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -442,6 +442,8 @@ int erofs_iget5_eq(struct inode *inode, void *opaque);
 int erofs_iget5_set(struct inode *inode, void *opaque);
 #ifdef CONFIG_EROFS_FS_RUST
 #define erofs_iget erofs_iget_rust
+#define erofs_get_parent erofs_get_parent_rust
+#define erofs_lookup erofs_lookup_rust
 #else
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 #endif
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index c94d0c1608a8..f657d475c4a1 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -7,6 +7,7 @@
 #include "xattr.h"
 #include <trace/events/erofs.h>
 
+#ifndef CONFIG_EROFS_FS_RUST
 struct erofs_qstr {
 	const unsigned char *name;
 	const unsigned char *end;
@@ -214,6 +215,7 @@ static struct dentry *erofs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = erofs_iget(dir->i_sb, nid);
 	return d_splice_alias(inode, dentry);
 }
+#endif
 
 const struct inode_operations erofs_dir_iops = {
 	.lookup = erofs_lookup,
diff --git a/fs/erofs/namei_rs.rs b/fs/erofs/namei_rs.rs
new file mode 100644
index 000000000000..d73a0a7bee1e
--- /dev/null
+++ b/fs/erofs/namei_rs.rs
@@ -0,0 +1,56 @@
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
+use kernel::bindings::{d_obtain_alias, d_splice_alias, dentry, inode};
+use kernel::container_of;
+
+use rust::{erofs_sys::operations::*, kinode::*, ksuperblock::*};
+
+/// Lookup function for dentry-inode lookup replacement.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_lookup_rust(
+    k_inode: NonNull<inode>,
+    dentry: NonNull<dentry>,
+    _flags: c_uint,
+) -> *mut c_void {
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
+    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: this is backed by qstr which is c representation of a valid slice.
+    let name = unsafe {
+        core::str::from_utf8_unchecked(core::slice::from_raw_parts(
+            dentry.as_ref().d_name.name,
+            dentry.as_ref().d_name.__bindgen_anon_1.__bindgen_anon_1.len as usize,
+        ))
+    };
+    let k_inode: *mut inode =
+        dir_lookup(sbi.filesystem.as_ref(), &mut sbi.inodes, erofs_inode, name)
+            .map_or(core::ptr::null_mut(), |result| result.k_inode.as_mut_ptr());
+
+    // SAFETY: We are sure that the inner k_inode has already been initialized.
+    unsafe { d_splice_alias(k_inode, dentry.as_ptr()).cast() }
+}
+
+/// Exported as a replacement of erofs_get_parent.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_get_parent_rust(child: NonNull<dentry>) -> *mut c_void {
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let k_inode = unsafe { child.as_ref().d_inode };
+    // SAFETY: The super_block is initialized when the erofs_alloc_sbi_rust is called.
+    let sbi = erofs_sbi(unsafe { NonNull::new((*k_inode).i_sb).unwrap() }); // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let inode = unsafe { &*container_of!(k_inode, KernelInode, k_inode) };
+    let k_inode: *mut inode = dir_lookup(sbi.filesystem.as_ref(), &mut sbi.inodes, inode, "..")
+        .map_or(core::ptr::null_mut(), |result| result.k_inode.as_mut_ptr());
+    // SAFETY: We are sure that the inner k_inode has already been initialized
+    unsafe { d_obtain_alias(k_inode).cast() }
+}
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index 657f109dd6e7..b35014aa5cae 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -6,7 +6,6 @@
 
 #include <linux/fs.h>
 
-
 typedef u64 erofs_nid_t;
 typedef u64 erofs_off_t;
 /* data type for filesystem-wide blocks number */
@@ -21,4 +20,7 @@ extern void *erofs_alloc_sbi_rust(struct super_block *sb);
 extern void *erofs_free_sbi_rust(struct super_block *sb);
 extern int erofs_iget5_eq_rust(struct inode *inode, void *opaque);
 extern struct inode *erofs_iget_rust(struct super_block *sb, erofs_nid_t nid);
+extern struct dentry *erofs_lookup_rust(struct inode *inode, struct dentry *dentry,
+			      unsigned int flags);
+extern struct dentry *erofs_get_parent_rust(struct dentry *dentry);
 #endif
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 659502bdf5fe..d49c804acf3d 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -554,6 +554,7 @@ static struct dentry *erofs_fh_to_parent(struct super_block *sb,
 				    erofs_nfs_get_inode);
 }
 
+#ifndef CONFIG_EROFS_FS_RUST
 static struct dentry *erofs_get_parent(struct dentry *child)
 {
 	erofs_nid_t nid;
@@ -565,6 +566,7 @@ static struct dentry *erofs_get_parent(struct dentry *child)
 		return ERR_PTR(err);
 	return d_obtain_alias(erofs_iget(child->d_sb, nid));
 }
+#endif
 
 static const struct export_operations erofs_export_ops = {
 	.encode_fh = generic_encode_ino32_fh,
-- 
2.46.0

