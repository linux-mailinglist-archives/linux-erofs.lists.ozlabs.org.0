Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69AE97A341
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495028;
	bh=oxWofg5jFESfQHz5d/1PUd3uyHaReZ7JPHv+SO4oHUc=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MXpt9TzjN1y397q/P4DdEaSgHyEU0fFTfy1e0NrP/nnmLUvMRGXktJ727Ml4nvZKe
	 pZdq3aDc5fk5erO48gpmoa/jOdEAKQhDqTCzl98erYyWt/eay3LY57WgbJHlVydUiU
	 pdcxMwIIRbWzzqvd4inbFpLATMP3By3Kg5SjlGptHw/6eGhK9AgB4rXTgymxgdWZ48
	 Fgs/n0BNASNjgXGrrhcgodjLlogQKTHODDcwbc91R/cDhCBBcrQh0sNsOoVSyZPYbt
	 X7tdkcpXVweixmDjC1qqsM/38O3zCutnarTCSsa6IQF8w4QorJUK1rSTIV5HrG3L2l
	 5a4WayEA1VWzQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgS1ktnz2yft
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495025;
	cv=none; b=cXQl5cLKpmqRIdUn5NAqmNnmrKcT7QcZ5WKI+srOuYmHfrKRmv0FHYH5sU7K3/RR63C001dROszFX7tQcOVLhx4tVBaSbiaWWSzrfmFCkgYYCV4KgyZb4AlXV07DO2NMtDVhVHeMT1yMu0ohPQ2HS1gPkB5VHoM9QF+bHI8fYOO/4OeQO1fWU+uEYT0WSoZf2MnqfIYpRQxgsPLHm4EtNBmGBhu6I5LjxWKNDTdIExU1NclY+pUL1x+KrfJbXDEsl6vm4mAMY7u3ffsnJwvUrWb7W5VTT4qGR7pSL8mVgVdAHB3mrxpkZn38WExutAmaHhEjgWHUX0HBs8e0eEyhew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495025; c=relaxed/relaxed;
	bh=oxWofg5jFESfQHz5d/1PUd3uyHaReZ7JPHv+SO4oHUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMKbAGwFp2Oja3eLBx05ZtMyy5LkwTJgM1LshsDT8jqJXTU0fHZAbw6IhjsWACoyjWXakC+FBtpzzaJT6lR0EGf6dKR89Y17mvLUQXxLZ+wdlcghUW6YhAH8Cp0cU427sMKxjALoZNl++X5MUyhLIkb84dfG71cpF1rjuOO/HprRk9Aumksog5JgXE7tRhD2uFoG9q0XKbB4Zzdf63u4WAbTX5I2cu0gQnT2OtNR9OYJLxfFJgpMQeb3JxiXAFKU8Uq4JmoSYnG9VSCeCqV2pb5fgZrKR8USKtVgnPLLJIp/hhaunm3WDzmiQ+6YpsfvcYtZJS3JH6zBn7Y2KWO4jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=iyxMeTP5; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=iyxMeTP5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgP4Z2zz2yYd
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:05 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F3BE69845;
	Mon, 16 Sep 2024 09:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495023; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=oxWofg5jFESfQHz5d/1PUd3uyHaReZ7JPHv+SO4oHUc=;
	b=iyxMeTP5+BeKjggayRCKmeQUH2EEpYvSo6si5ckLvAx3IFNHLw9orOVtF/5k9sS1xTNxP2
	xDg5HPPzRtAT4f5oSlGe3pFT7hCBW3swBEWilBYcGsnmbIqlpBj5QzD4B7EQPiKLPAdwGE
	aBNbuB4H6TdmePHGOvjutbgLPqxk5ZxDXU4Po9tQpNl6esC99WbYe1JDaBNF+UQkdsz301
	otoIKDnWnHIMjIdTFeZJgV+9aZjoilrigqC/p9w/+sMU4YFPjjUhpsgpePnxXlEwgYo/8P
	C/yC5mX36jvzDdpoAP1Ml6convjyt8zt/rmEWxaujFcYHc8WW1/PtFreMWBCfg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 13/24] erofs: add runtime filesystem and inode in Rust
Date: Mon, 16 Sep 2024 21:56:23 +0800
Message-ID: <20240916135634.98554-14-toolmanp@tlmp.cc>
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

This patch introduces Filesystem Trait and Inode trait in Rust.
It also implements a memory backed filesystem in Rust which can be later
hooks up the metabuf system in erofs.

This patch also comes with a InodeCollection trait which can be later be
hooked up with the iget5_locked.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs                |   2 +-
 fs/erofs/rust/erofs_sys/inode.rs          | 106 ++++++++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock.rs     |  42 ++++++++-
 fs/erofs/rust/erofs_sys/superblock/mem.rs |  61 +++++++++++++
 4 files changed, 209 insertions(+), 2 deletions(-)
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/mem.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 65dc563986c3..20c0aa81a800 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -32,7 +32,7 @@
 pub(crate) mod map;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
-pub(crate) use errnos::Errno;
+pub(crate) use errnos::{Errno, Errno::*};
 
 /// Helper macro to round up or down a number.
 #[macro_export]
diff --git a/fs/erofs/rust/erofs_sys/inode.rs b/fs/erofs/rust/erofs_sys/inode.rs
index 1762023e97f8..1ecd6147a126 100644
--- a/fs/erofs/rust/erofs_sys/inode.rs
+++ b/fs/erofs/rust/erofs_sys/inode.rs
@@ -1,3 +1,7 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::superblock::*;
 use super::xattrs::*;
 use super::*;
 use core::ffi::*;
@@ -289,3 +293,105 @@ pub(crate) fn xattr_count(&self) -> u16 {
 pub(crate) type CompactInodeInfoBuf = [u8; size_of::<CompactInodeInfo>()];
 pub(crate) type ExtendedInodeInfoBuf = [u8; size_of::<ExtendedInodeInfo>()];
 pub(crate) const DEFAULT_INODE_BUF: ExtendedInodeInfoBuf = [0; size_of::<ExtendedInodeInfo>()];
+
+/// The inode trait which represents the inode in the filesystem.
+pub(crate) trait Inode: Sized {
+    fn new(_sb: &SuperBlock, info: InodeInfo, nid: Nid) -> Self;
+    fn info(&self) -> &InodeInfo;
+    fn nid(&self) -> Nid;
+}
+
+/// Represents the error which occurs when trying to convert the inode.
+#[derive(Debug)]
+pub(crate) enum InodeError {
+    VersionError,
+    PosixError(Errno),
+}
+
+impl TryFrom<CompactInodeInfoBuf> for CompactInodeInfo {
+    type Error = InodeError;
+    fn try_from(value: CompactInodeInfoBuf) -> Result<Self, Self::Error> {
+        let inode: CompactInodeInfo = Self {
+            i_format: Format(u16::from_le_bytes([value[0], value[1]])),
+            i_xattr_icount: u16::from_le_bytes([value[2], value[3]]),
+            i_mode: u16::from_le_bytes([value[4], value[5]]),
+            i_nlink: u16::from_le_bytes([value[6], value[7]]),
+            i_size: u32::from_le_bytes([value[8], value[9], value[10], value[11]]),
+            i_reserved: value[12..16].try_into().unwrap(),
+            i_u: value[16..20].try_into().unwrap(),
+            i_ino: u32::from_le_bytes([value[20], value[21], value[22], value[23]]),
+            i_uid: u16::from_le_bytes([value[24], value[25]]),
+            i_gid: u16::from_le_bytes([value[26], value[27]]),
+            i_reserved2: value[28..32].try_into().unwrap(),
+        };
+        let ifmt = &inode.i_format;
+        match ifmt.version() {
+            Version::Compat => Ok(inode),
+            Version::Extended => Err(InodeError::VersionError),
+            _ => Err(InodeError::PosixError(EOPNOTSUPP)),
+        }
+    }
+}
+
+impl<I> TryFrom<(&dyn FileSystem<I>, Nid)> for InodeInfo
+where
+    I: Inode,
+{
+    type Error = Errno;
+    fn try_from(value: (&dyn FileSystem<I>, Nid)) -> Result<Self, Self::Error> {
+        let f = value.0;
+        let sb = f.superblock();
+        let nid = value.1;
+        let offset = sb.iloc(nid);
+        let accessor = sb.blk_access(offset);
+        let mut buf: ExtendedInodeInfoBuf = DEFAULT_INODE_BUF;
+        f.backend().fill(&mut buf[0..32], offset)?;
+        let compact_buf: CompactInodeInfoBuf = buf[0..32].try_into().unwrap();
+        let r: Result<CompactInodeInfo, InodeError> = CompactInodeInfo::try_from(compact_buf);
+        match r {
+            Ok(compact) => Ok(InodeInfo::Compact(compact)),
+            Err(e) => match e {
+                InodeError::VersionError => {
+                    let gotten = (sb.blksz() - accessor.off + 32).min(64);
+                    f.backend()
+                        .fill(&mut buf[32..(32 + gotten).min(64) as usize], offset + 32)?;
+
+                    if gotten < 32 {
+                        f.backend().fill(
+                            &mut buf[(32 + gotten) as usize..64],
+                            sb.blkpos(sb.blknr(offset) + 1),
+                        )?;
+                    }
+                    Ok(InodeInfo::Extended(ExtendedInodeInfo {
+                        i_format: Format(u16::from_le_bytes([buf[0], buf[1]])),
+                        i_xattr_icount: u16::from_le_bytes([buf[2], buf[3]]),
+                        i_mode: u16::from_le_bytes([buf[4], buf[5]]),
+                        i_reserved: buf[6..8].try_into().unwrap(),
+                        i_size: u64::from_le_bytes([
+                            buf[8], buf[9], buf[10], buf[11], buf[12], buf[13], buf[14], buf[15],
+                        ]),
+                        i_u: buf[16..20].try_into().unwrap(),
+                        i_ino: u32::from_le_bytes([buf[20], buf[21], buf[22], buf[23]]),
+                        i_uid: u32::from_le_bytes([buf[24], buf[25], buf[26], buf[27]]),
+                        i_gid: u32::from_le_bytes([buf[28], buf[29], buf[30], buf[31]]),
+                        i_mtime: u64::from_le_bytes([
+                            buf[32], buf[33], buf[34], buf[35], buf[36], buf[37], buf[38], buf[39],
+                        ]),
+                        i_mtime_nsec: u32::from_le_bytes([buf[40], buf[41], buf[42], buf[43]]),
+                        i_nlink: u32::from_le_bytes([buf[44], buf[45], buf[46], buf[47]]),
+                        i_reserved2: buf[48..64].try_into().unwrap(),
+                    }))
+                }
+                InodeError::PosixError(e) => Err(e),
+            },
+        }
+    }
+}
+
+/// Represents the inode collection which is a hashmap of inodes.
+pub(crate) trait InodeCollection {
+    type I: Inode + Sized;
+
+    fn iget(&mut self, nid: Nid, filesystem: &dyn FileSystem<Self::I>)
+        -> PosixResult<&mut Self::I>;
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index 213be6dbc553..940ab0b03a26 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -1,9 +1,15 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
-use super::*;
+pub(crate) mod mem;
+use alloc::boxed::Box;
 use core::mem::size_of;
 
+use super::data::*;
+use super::devices::*;
+use super::inode::*;
+use super::*;
+
 /// The ondisk superblock structure.
 #[derive(Debug, Clone, Copy, Default)]
 #[repr(C)]
@@ -130,3 +136,37 @@ pub(crate) fn iloc(&self, nid: Nid) -> Off {
         self.blkpos(self.meta_blkaddr) + ((nid as Off) << (5 as Off))
     }
 }
+
+pub(crate) trait FileSystem<I>
+where
+    I: Inode,
+{
+    fn superblock(&self) -> &SuperBlock;
+    fn backend(&self) -> &dyn Backend;
+    fn as_filesystem(&self) -> &dyn FileSystem<I>;
+    fn device_info(&self) -> &DeviceInfo;
+}
+
+pub(crate) struct SuperblockInfo<I, C, T>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    pub(crate) filesystem: Box<dyn FileSystem<I>>,
+    pub(crate) inodes: C,
+    pub(crate) opaque: T,
+}
+
+impl<I, C, T> SuperblockInfo<I, C, T>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    pub(crate) fn new(fs: Box<dyn FileSystem<I>>, c: C, opaque: T) -> Self {
+        Self {
+            filesystem: fs,
+            inodes: c,
+            opaque,
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock/mem.rs b/fs/erofs/rust/erofs_sys/superblock/mem.rs
new file mode 100644
index 000000000000..12bf797bd1e3
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/superblock/mem.rs
@@ -0,0 +1,61 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::data::raw_iters::ref_iter::*;
+use super::*;
+
+// Memory Mapped Device/File so we need to have some external lifetime on the backend trait.
+// Note that we do not want the lifetime to infect the MemFileSystem which may have a impact on
+// the content iter below. Just use HRTB to dodge the borrow checker.
+
+pub(crate) struct KernelFileSystem<B>
+where
+    B: Backend,
+{
+    backend: B,
+    sb: SuperBlock,
+    device_info: DeviceInfo,
+}
+
+impl<I, B> FileSystem<I> for KernelFileSystem<B>
+where
+    B: Backend,
+    I: Inode,
+{
+    fn superblock(&self) -> &SuperBlock {
+        &self.sb
+    }
+    fn backend(&self) -> &dyn Backend {
+        &self.backend
+    }
+
+    fn as_filesystem(&self) -> &dyn FileSystem<I> {
+        self
+    }
+
+    fn device_info(&self) -> &DeviceInfo {
+        &self.device_info
+    }
+}
+
+impl<B> KernelFileSystem<B>
+where
+    B: Backend,
+{
+    pub(crate) fn try_new(backend: B) -> PosixResult<Self> {
+        let mut buf = SUPERBLOCK_EMPTY_BUF;
+        backend.fill(&mut buf, EROFS_SUPER_OFFSET)?;
+        let sb: SuperBlock = buf.into();
+        let device_info = get_device_infos(&mut ContinuousRefIter::new(
+            &sb,
+            &backend,
+            sb.devt_slotoff as Off * 128,
+            sb.extra_devices as Off * 128,
+        ))?;
+        Ok(Self {
+            backend,
+            sb,
+            device_info,
+        })
+    }
+}
-- 
2.46.0

