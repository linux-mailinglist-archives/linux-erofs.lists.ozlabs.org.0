Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161F97A34E
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495043;
	bh=SF+isR41/QqrBfGfC6meT3Kg4eWEa6AIAKKhQ1hnyqE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=e9uYUWHxFI5I4EVAwDJ5qRJ1fm8m4jpUEVUliJO1X/mNQo8mthsmN6fzSFB1DCs5U
	 FzXHHaZf6m7HjgltzAFHxysylaWn6VEEtQKsydcQmK6VsHKAttgC03bWijhRBHqth0
	 lHJWV5Zl6s6VFYvWQCzZhp4OMqtXXj9IB9M8vGnBgVBRZeU69yrr11LLxtRYmdjntw
	 oNtxqCRyTM+3CAm35MzPyDf6lZr33szuyxagrQt5aCxu3kZ15fSRf77Jf12lazq1//
	 ZBvGe8UPj3xo1yLI5Ewac3A2rNgZ50PY8XwK9qiKqbVMXafusQ7lcS0B/qTfXVgaQR
	 J+8R+lIjahhWg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgl45GCz30Bp
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495042;
	cv=none; b=bbfkfAfc2eOfwg+2wGZO0ACegFiwIsavzP7LbB/KKRgwJTb1M3s1KUGlBDPT2EpmhNsbyz0SERV0dShl1qWEVevPpaAoipyWZTnBgUDbr2/w0y23ZFiaOuJsr5uvL9LEdNOFUGdYMng1TQ2IMM9uOv0MtXKhQ5/JAup7cKm8wS8GWxK0MfTTT7t7mkRJCwy2+sL00xIwSUU4sbMTR7q3YV4WmutlVBK71by0RH75Fv707+tQM1bbkYBNdSlg8d9d1pnvoDvyLLS6dcO36s+gVdsE8KQFtQaD2HwiNzlkf8s77lKlCRg1R4Y6CFI3dNwe76i6RF7NfqpaonAccl8YRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495042; c=relaxed/relaxed;
	bh=SF+isR41/QqrBfGfC6meT3Kg4eWEa6AIAKKhQ1hnyqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m4qNYmRx7qAk41dLFpRbPQ9uW3QaEeyhMig3iNX4ZpSC084QmN012AhO+OGl/08E183b4tymHf3/5HVMtXPRI1mNDABjJN/NAdyT52JeGMLlYSYFK13407r00QyTjmwpUyddZusggGAqgN4LCXSbnipDOvG1rrxEyJHyPYkQ/B2kQGMXnZAUdEfiJbENdF3f6aIMup3Mq6cUeYxfH1pKSJOr4a3p2BUClSNTCWQ+1Sf2KOK3uCoOXXDSeSRwZUMg9zzFnAJtAoTnwFlvQHBcwigMGOJ+JGlz70ijck/XMVepjsoFvYXBxXYv4RDDuRhfX/WY91/5vyhfZ2jrHavAkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=X5cUuPKc; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=X5cUuPKc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgk2S9hz2yQL
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:22 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 584C969839;
	Mon, 16 Sep 2024 09:57:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495039; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SF+isR41/QqrBfGfC6meT3Kg4eWEa6AIAKKhQ1hnyqE=;
	b=X5cUuPKcDAJD4qrkdbm0LQChHyRJrM+CjfZdi2pNiAo3Gu2Pbkbzoy2+ZgrhlD7ofI06mj
	blYOAEf2pYeemD0LXW0dKogk+HQaxnzrCt+pFL7ZMYsBWgy1bDVVrw+R4UTlgXG18IAIT0
	QRbBTNXXdkHc5dTL2oVYI/1RgPEYRt4oAbzo9+DfSQ4aNMPccOlygyOnfQPM5e3QAaSs8L
	5mrbOfVBY3lQiL15qkSsUCPmoNJ71ipLnZgDo/hFse/fb9t/BXtSixqvPCw+i0cMbk+pIg
	4imgAQxaMDCa/6rHNCewn5Uw3UcvIAe9dEz0QgMAI/PFjHEDSZtT4GX+V+OWTw==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 21/24] erofs: introduce erofs_map_blocks alternative to C
Date: Mon, 16 Sep 2024 21:56:31 +0800
Message-ID: <20240916135634.98554-22-toolmanp@tlmp.cc>
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

This patch introduces erofs_map_blocks alternative written in Rust,
which will be hooked inside the erofs_iomap_begin.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Makefile        |  2 +-
 fs/erofs/data.c          |  5 ++++
 fs/erofs/data_rs.rs      | 63 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/rust_bindings.h |  4 +++
 4 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 fs/erofs/data_rs.rs

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index e086487971b6..219ddca0642e 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,4 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
-erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o dir_rs.o rust_helpers.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o inode_rs.o namei_rs.o dir_rs.o data_rs.o rust_helpers.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 61debd799cf9..c9694661136b 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -293,7 +293,12 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	map.m_la = offset;
 	map.m_llen = length;
 
+#ifdef CONFIG_EROFS_FS_RUST
+	ret = erofs_map_blocks_rust(inode, &map);
+#else  
 	ret = erofs_map_blocks(inode, &map);
+#endif
+
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/erofs/data_rs.rs b/fs/erofs/data_rs.rs
new file mode 100644
index 000000000000..ac34a9dd2079
--- /dev/null
+++ b/fs/erofs/data_rs.rs
@@ -0,0 +1,63 @@
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
+use kernel::bindings::inode;
+use kernel::container_of;
+
+use rust::{erofs_sys::*, kinode::*, ksuperblock::*};
+
+#[repr(C)]
+struct ErofsBuf {
+    mapping: NonNull<c_void>,
+    page: NonNull<c_void>,
+    base: NonNull<c_void>,
+    kmap_type: c_int,
+}
+
+/// A helper sturct to map blocks for iomap_begin because iomap is not generated by bindgen
+#[repr(C)]
+pub struct ErofsMapBlocks {
+    buf: ErofsBuf,
+    pub(crate) m_pa: u64,
+    pub(crate) m_la: u64,
+    pub(crate) m_plen: u64,
+    pub(crate) m_llen: u64,
+    pub(crate) m_deviceid: u16,
+    pub(crate) m_flags: u32,
+}
+/// Exported as a replacement for erofs_map_blocks.
+#[no_mangle]
+pub unsafe extern "C" fn erofs_map_blocks_rust(
+    k_inode: NonNull<inode>,
+    mut map: NonNull<ErofsMapBlocks>,
+) -> c_int {
+    // SAFETY: super_block and superblockinfo is always initialized in k_inode.
+    let sbi = erofs_sbi(unsafe { NonNull::new(k_inode.as_ref().i_sb).unwrap() });
+    // SAFETY: We are sure that the inode is a Kernel Inode since alloc_inode is called
+    let erofs_inode = unsafe { &*container_of!(k_inode.as_ptr(), KernelInode, k_inode) };
+    // SAFETY: The map is always initialized in the caller.
+    match sbi
+        .filesystem
+        .map(erofs_inode, unsafe { map.as_ref().m_la } as Off)
+    {
+        Ok(m) => unsafe {
+            map.as_mut().m_pa = m.physical.start;
+            map.as_mut().m_la = map.as_ref().m_la;
+            map.as_mut().m_plen = m.physical.len;
+            map.as_mut().m_llen = m.physical.len;
+            map.as_mut().m_deviceid = m.device_id;
+            map.as_mut().m_flags = m.map_type.into();
+            0
+        },
+        Err(e) => i32::from(e) as c_int,
+    }
+}
diff --git a/fs/erofs/rust_bindings.h b/fs/erofs/rust_bindings.h
index 8b71d65e2c0b..ad9aa75a7a2c 100644
--- a/fs/erofs/rust_bindings.h
+++ b/fs/erofs/rust_bindings.h
@@ -24,4 +24,8 @@ extern struct dentry *erofs_lookup_rust(struct inode *inode, struct dentry *dent
 			      unsigned int flags);
 extern struct dentry *erofs_get_parent_rust(struct dentry *dentry);
 extern int erofs_readdir_rust(struct file *file, struct dir_context *ctx);
+
+struct erofs_map_blocks;
+extern int erofs_map_blocks_rust(struct inode *inode,
+				 struct erofs_map_blocks *map);
 #endif
-- 
2.46.0

