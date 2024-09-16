Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8797A329
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494976;
	bh=3lB7vMUDAoeBGlHx0db3VH42iw8zhtpQjBkF7LrP3EU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nFsSNG6SrIJ6REdzzyOkd00zJxowLvHLY+/LArdPF+fPKt9VI4tTwzCErwAjgMHIg
	 FnZp3fS6tZaxSdAXww0h7vbANZrFi+Jv3gv9TWpuucE1ku4/3kQJ3QW9IbZBFlmZkM
	 gLLnl/EMe2VvM82M5KPYXqv7yh+MiJ/F2/4dN/Lth+pBFz7oHWGr9Y/XleCH/BvTg5
	 PvZptVPX3w22UZV7pKwqN7ABxEwRc3vG6iRgPzk7lypDH5acW6ufgaYl6sJDXMPMcS
	 QBd9J0otDSV/ed2k6z6OsatohqH9+twV4qEgNLJO6HCLYlQtdMfSdl2YBzDHiu1MQB
	 jPZr8EL23SkRQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfS3WRnz3cH4
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494973;
	cv=none; b=EhJKGBY40o/87vsmJvayM99CtHfMJ42j8FHPSOaVc1xN9Rx4yHc7RYNq9XlCDKAPOSGHw25m44952b/SrUPFc3jzkCMI4g09eypd7YA7hKrgqYNyyQUEIAzL4+usPZcvV4hmf+F0aeuYvJL7H7PBB57OFp5C8FTp+GEu3EST2YW7f+Wk8MAlBxCje6e+mcS20LhWKTMZ1e7JJnyp/Dxm5sH04fW06n4Ear0KJ0j4jo9GmcEg0xfgJ5pB+d+7X2WFYPBjVadUetzfivlKAsVdE4tBucPAVxJ4xb0NBeo1mSZEItGSvoPH4JChOo0TOCDbJIxKNFZOguFyBSlsldNAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494973; c=relaxed/relaxed;
	bh=3lB7vMUDAoeBGlHx0db3VH42iw8zhtpQjBkF7LrP3EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN0XEj44RIk+K4KXj91S5w9dNKIjUzXh3BOCqxniCx26yqO6RovosndOPVbm5xAqlOB/lz/W85cNHVvPMXVK4ghOyHx2tsHWCC0dQTyVyXUXDC58wxiWYY7O4qUgvUD9LfTTworkoHoXIwAWgK7yXOophitVSigdAssoX1maslr93itBK4c5q97ALKendK5v/gImPbwAswtFCddmU7c5vJeasglGowPmcfpudBP4ezfa49+OrFQ6Mr8YLcdGO9iOog3ySOJ/UlhmEETT16cX3RC8Arv6md2zQloLKtNMtm1/qgd91RVWvJ35l1AgqufgTlb5DPNtetfp4LquUxEFBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=UtsePRwI; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=UtsePRwI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfN6BB5z2ysb
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:12 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0826F6997E;
	Mon, 16 Sep 2024 09:56:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494970; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3lB7vMUDAoeBGlHx0db3VH42iw8zhtpQjBkF7LrP3EU=;
	b=UtsePRwIatPkFI6g47PQN+urQglWghy7rKD4qYfaMY4FAF4z5OzDxPTTk6gpz+Jigq9pCe
	pl8i1ARy+rPgNfNJTl6jhgPo8f8HIomuGZTdUYJEx+7EA0MtW0/owPnvnrQoKGVzi1mCzr
	c8thO7gcbdGFqC4ksq3XnA30zw06TcIDYt0+kXfh7Hjjv1yyh6YMUHquiG9DwXNOiQdO7K
	LnvGPgrtOAyUi0Yu1bnFW6t84EBtf1WiW5ZAv51o1YBPy7AsKlm8kJQRkQX5AKeZdO0H8+
	KuiOVntwIN0NHGAiYCm/rw7MRKXSByhEaVgeutTYkbNEcFerTEeCahwW5rqhRQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 05/24] erofs: add inode data structure in Rust
Date: Mon, 16 Sep 2024 21:55:22 +0800
Message-ID: <20240916135541.98096-6-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916135541.98096-1-toolmanp@tlmp.cc>
References: <20240916135541.98096-1-toolmanp@tlmp.cc>
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
Cc: linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch introduces the same on-disk erofs data structure
in rust and also introduces multiple helpers for inode i_format
and chunk_indexing and later can be used to implement map_blocks.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs       |   1 +
 fs/erofs/rust/erofs_sys/inode.rs | 291 +++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/inode.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 6f3c12665ed6..34267ec7772d 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -24,6 +24,7 @@
 pub(crate) type PosixResult<T> = Result<T, Errno>;
 
 pub(crate) mod errnos;
+pub(crate) mod inode;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
 pub(crate) use errnos::Errno;
diff --git a/fs/erofs/rust/erofs_sys/inode.rs b/fs/erofs/rust/erofs_sys/inode.rs
new file mode 100644
index 000000000000..1762023e97f8
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/inode.rs
@@ -0,0 +1,291 @@
+use super::xattrs::*;
+use super::*;
+use core::ffi::*;
+use core::mem::size_of;
+
+/// Represents the compact bitfield of the Erofs Inode format.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub(crate) struct Format(u16);
+
+pub(crate) const INODE_VERSION_MASK: u16 = 0x1;
+pub(crate) const INODE_VERSION_BIT: u16 = 0;
+
+pub(crate) const INODE_LAYOUT_BIT: u16 = 1;
+pub(crate) const INODE_LAYOUT_MASK: u16 = 0x7;
+
+/// Helper macro to extract property from the bitfield.
+macro_rules! extract {
+    ($name: expr, $bit: expr, $mask: expr) => {
+        ($name >> $bit) & ($mask)
+    };
+}
+
+/// The Version of the Inode which represents whether this inode is extended or compact.
+/// Extended inodes have more infos about nlinks + mtime.
+/// This is documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inodes
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) enum Version {
+    Compat,
+    Extended,
+    Unknown,
+}
+
+/// Represents the data layout backed by the Inode.
+/// As Documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inode-data-layouts
+#[repr(C)]
+#[derive(Clone, Copy, PartialEq)]
+pub(crate) enum Layout {
+    FlatPlain,
+    CompressedFull,
+    FlatInline,
+    CompressedCompact,
+    Chunk,
+    Unknown,
+}
+
+#[repr(C)]
+#[allow(non_camel_case_types)]
+#[derive(Clone, Copy, Debug, PartialEq)]
+pub(crate) enum Type {
+    Regular,
+    Directory,
+    Link,
+    Character,
+    Block,
+    Fifo,
+    Socket,
+    Unknown,
+}
+
+/// This is format extracted from i_format bit representation.
+/// This includes various infos and specs about the inode.
+impl Format {
+    pub(crate) fn version(&self) -> Version {
+        match extract!(self.0, INODE_VERSION_BIT, INODE_VERSION_MASK) {
+            0 => Version::Compat,
+            1 => Version::Extended,
+            _ => Version::Unknown,
+        }
+    }
+
+    pub(crate) fn layout(&self) -> Layout {
+        match extract!(self.0, INODE_LAYOUT_BIT, INODE_LAYOUT_MASK) {
+            0 => Layout::FlatPlain,
+            1 => Layout::CompressedFull,
+            2 => Layout::FlatInline,
+            3 => Layout::CompressedCompact,
+            4 => Layout::Chunk,
+            _ => Layout::Unknown,
+        }
+    }
+}
+
+/// Represents the compact inode which resides on-disk.
+/// This is documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inodes
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct CompactInodeInfo {
+    pub(crate) i_format: Format,
+    pub(crate) i_xattr_icount: u16,
+    pub(crate) i_mode: u16,
+    pub(crate) i_nlink: u16,
+    pub(crate) i_size: u32,
+    pub(crate) i_reserved: [u8; 4],
+    pub(crate) i_u: [u8; 4],
+    pub(crate) i_ino: u32,
+    pub(crate) i_uid: u16,
+    pub(crate) i_gid: u16,
+    pub(crate) i_reserved2: [u8; 4],
+}
+
+/// Represents the extended inode which resides on-disk.
+/// This is documented in https://erofs.docs.kernel.org/en/latest/core_ondisk.html#inodes
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct ExtendedInodeInfo {
+    pub(crate) i_format: Format,
+    pub(crate) i_xattr_icount: u16,
+    pub(crate) i_mode: u16,
+    pub(crate) i_reserved: [u8; 2],
+    pub(crate) i_size: u64,
+    pub(crate) i_u: [u8; 4],
+    pub(crate) i_ino: u32,
+    pub(crate) i_uid: u32,
+    pub(crate) i_gid: u32,
+    pub(crate) i_mtime: u64,
+    pub(crate) i_mtime_nsec: u32,
+    pub(crate) i_nlink: u32,
+    pub(crate) i_reserved2: [u8; 16],
+}
+
+/// Represents the inode info which is either compact or extended.
+#[derive(Clone, Copy)]
+pub(crate) enum InodeInfo {
+    Extended(ExtendedInodeInfo),
+    Compact(CompactInodeInfo),
+}
+
+pub(crate) const CHUNK_BLKBITS_MASK: u16 = 0x1f;
+pub(crate) const CHUNK_FORMAT_INDEX_BIT: u16 = 0x20;
+
+/// Represents on-disk chunk index of the file backing inode.
+#[repr(C)]
+#[derive(Clone, Copy, Debug)]
+pub(crate) struct ChunkIndex {
+    pub(crate) advise: u16,
+    pub(crate) device_id: u16,
+    pub(crate) blkaddr: u32,
+}
+
+impl From<[u8; 8]> for ChunkIndex {
+    fn from(u: [u8; 8]) -> Self {
+        let advise = u16::from_le_bytes([u[0], u[1]]);
+        let device_id = u16::from_le_bytes([u[2], u[3]]);
+        let blkaddr = u32::from_le_bytes([u[4], u[5], u[6], u[7]]);
+        ChunkIndex {
+            advise,
+            device_id,
+            blkaddr,
+        }
+    }
+}
+
+/// Chunk format used for indicating the chunkbits and chunkindex.
+#[repr(C)]
+#[derive(Clone, Copy, Debug)]
+pub(crate) struct ChunkFormat(pub(crate) u16);
+
+impl ChunkFormat {
+    pub(crate) fn is_chunkindex(&self) -> bool {
+        self.0 & CHUNK_FORMAT_INDEX_BIT != 0
+    }
+    pub(crate) fn chunkbits(&self) -> u16 {
+        self.0 & CHUNK_BLKBITS_MASK
+    }
+}
+
+/// Represents the inode spec which is either data or device.
+#[derive(Clone, Copy, Debug)]
+#[repr(u32)]
+pub(crate) enum Spec {
+    Chunk(ChunkFormat),
+    RawBlk(u32),
+    Device(u32),
+    CompressedBlocks(u32),
+    Unknown,
+}
+
+/// Convert the spec from the format of the inode based on the layout.
+impl From<(&[u8; 4], Layout)> for Spec {
+    fn from(value: (&[u8; 4], Layout)) -> Self {
+        match value.1 {
+            Layout::FlatInline | Layout::FlatPlain => Spec::RawBlk(u32::from_le_bytes(*value.0)),
+            Layout::CompressedFull | Layout::CompressedCompact => {
+                Spec::CompressedBlocks(u32::from_le_bytes(*value.0))
+            }
+            Layout::Chunk => Self::Chunk(ChunkFormat(u16::from_le_bytes([value.0[0], value.0[1]]))),
+            // We don't support compressed inlines or compressed chunks currently.
+            _ => Spec::Unknown,
+        }
+    }
+}
+
+/// Helper functions for Inode Info.
+impl InodeInfo {
+    const S_IFMT: u16 = 0o170000;
+    const S_IFSOCK: u16 = 0o140000;
+    const S_IFLNK: u16 = 0o120000;
+    const S_IFREG: u16 = 0o100000;
+    const S_IFBLK: u16 = 0o60000;
+    const S_IFDIR: u16 = 0o40000;
+    const S_IFCHR: u16 = 0o20000;
+    const S_IFIFO: u16 = 0o10000;
+    const S_ISUID: u16 = 0o4000;
+    const S_ISGID: u16 = 0o2000;
+    const S_ISVTX: u16 = 0o1000;
+    pub(crate) fn ino(&self) -> u32 {
+        match self {
+            Self::Extended(extended) => extended.i_ino,
+            Self::Compact(compact) => compact.i_ino,
+        }
+    }
+
+    pub(crate) fn format(&self) -> Format {
+        match self {
+            Self::Extended(extended) => extended.i_format,
+            Self::Compact(compact) => compact.i_format,
+        }
+    }
+
+    pub(crate) fn file_size(&self) -> Off {
+        match self {
+            Self::Extended(extended) => extended.i_size,
+            Self::Compact(compact) => compact.i_size as u64,
+        }
+    }
+
+    pub(crate) fn inode_size(&self) -> Off {
+        match self {
+            Self::Extended(_) => 64,
+            Self::Compact(_) => 32,
+        }
+    }
+
+    pub(crate) fn spec(&self) -> Spec {
+        let mode = match self {
+            Self::Extended(extended) => extended.i_mode,
+            Self::Compact(compact) => compact.i_mode,
+        };
+
+        let u = match self {
+            Self::Extended(extended) => &extended.i_u,
+            Self::Compact(compact) => &compact.i_u,
+        };
+
+        match mode & 0o170000 {
+            0o40000 | 0o100000 | 0o120000 => Spec::from((u, self.format().layout())),
+            // We don't support device inodes currently.
+            _ => Spec::Unknown,
+        }
+    }
+
+    pub(crate) fn inode_type(&self) -> Type {
+        let mode = match self {
+            Self::Extended(extended) => extended.i_mode,
+            Self::Compact(compact) => compact.i_mode,
+        };
+        match mode & Self::S_IFMT {
+            Self::S_IFDIR => Type::Directory, // Directory
+            Self::S_IFREG => Type::Regular,   // Regular File
+            Self::S_IFLNK => Type::Link,      // Symbolic Link
+            Self::S_IFIFO => Type::Fifo,      // FIFO
+            Self::S_IFSOCK => Type::Socket,   // Socket
+            Self::S_IFBLK => Type::Block,     // Block
+            Self::S_IFCHR => Type::Character, // Character
+            _ => Type::Unknown,
+        }
+    }
+
+    pub(crate) fn xattr_size(&self) -> Off {
+        match self {
+            Self::Extended(extended) => {
+                size_of::<XAttrSharedEntrySummary>() as Off
+                    + (size_of::<c_int>() as Off) * (extended.i_xattr_icount as Off - 1)
+            }
+            Self::Compact(_) => 0,
+        }
+    }
+
+    pub(crate) fn xattr_count(&self) -> u16 {
+        match self {
+            Self::Extended(extended) => extended.i_xattr_icount,
+            Self::Compact(compact) => compact.i_xattr_icount,
+        }
+    }
+}
+
+pub(crate) type CompactInodeInfoBuf = [u8; size_of::<CompactInodeInfo>()];
+pub(crate) type ExtendedInodeInfoBuf = [u8; size_of::<ExtendedInodeInfo>()];
+pub(crate) const DEFAULT_INODE_BUF: ExtendedInodeInfoBuf = [0; size_of::<ExtendedInodeInfo>()];
-- 
2.46.0

