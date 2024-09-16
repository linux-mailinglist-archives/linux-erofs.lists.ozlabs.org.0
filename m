Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFB97A333
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495006;
	bh=eiSTaIp2oxZp3XntcBK5EeEI9ViTxMs6XcQ702Or/vY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=PVrb8TT9OX/p/I39dMqXXQGak4kDBRs0hjN0cvczGQY/sugM9yDAOgxC3SfMpYqh+
	 4Lt5zsF4F/+R2QEytf2dkD2GEBlru8tESgPNDne37mEY7e4oM4PF41T81esYkkYgg6
	 soNLHemPW0J5Go8ZlAiWl9nxS7pZhWDAj/WAyIncLvq/V4uR1K1us09gQ+murM9wt0
	 77TtH/R2xkPxqHdeXx/kS7bpp/4N+QKNBbPqxF1rOHviJvnOwl1v33D6Ao9sdxma2V
	 QrQxU9uyep+HS3LJf6bL7fEwv6DHypQBwim+u7BO3TqEnux1ktsLrGpCi/Xbzz8prO
	 5Q2eXLytmsE3Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mg23ZlLz2ywh
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495004;
	cv=none; b=Fy5gRc9UenvK3tSd17vg/MQKltXqU/7qwZSqvyxcOlDtX/qsAfyBpAKycrmh+smmHM5v6aVB0DoscP3NqbVP8/XK1sJC5W/BzWXSCI+pbYvVg0jMBzE+g9QJAsyd4vcbzTRAc7vYUWooWf6OGZc2ygpzZLzt7vH19Dzdi0F2WHuoFStS7PUyMI6Up6HUK9jhZkSD/8lV1hN80cRs7AhEKBytt2KKKqXmNRku3IclDxX5ApbUBEbUvEiMiinExbo5wmnA8TP1k0SP24aZ1qD8MPHE4ZaFyNrf1dvU8dFLtriJCzk2LMJznSUKwnK7NW5GPiwYP//X1L6Xd84L7x9B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495004; c=relaxed/relaxed;
	bh=eiSTaIp2oxZp3XntcBK5EeEI9ViTxMs6XcQ702Or/vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgfzZBQEtvNHHY3d1l4iSQqt2yJGIx5DipLMLaVt/7CP9mBjxn1zdwRcZxtX8h+I0r7VurHZd5fEFtTBeLsrQMFCagOdWizcrbJFAzHcwm817nGKNllBZmBkdnTscMzWYQDlvOPZfDR78b4usWv1YqYwA5eZtVKahSDHW1V9gcrQoG2vP0j/F2T9Kr2P+K/lff5Xc3ZIxKEDCT0rzKmEQvXUaY0qum5bIiXRwj8uUjYNMzYlZnU9UPNGizQ/KIfllCP3TbllZaaq6Aj5GEfqvZT9kq9ywbRv/9xNULKCXcP+TS9s7po92bhPSZpU6dwiVFKtFQG7apktSM3wxcVElw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=EXrdKMbP; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=EXrdKMbP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mg01hMrz2yPR
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:44 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A8176983D;
	Mon, 16 Sep 2024 09:56:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495002; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eiSTaIp2oxZp3XntcBK5EeEI9ViTxMs6XcQ702Or/vY=;
	b=EXrdKMbPRSLWjUM9rpjDioPo1pyJcUduJGi9/DcPSUznc4+n3PK+QocMh5/3zd5PEb+T1I
	YRcB2n2fyzAcWZwwf1x8r2KQmlq6J4K5JQvfg4s+6GGtMZsBRkedc66rf1mDJIKEQ/X5hP
	pkDmgPNP4cuhtoSUWOoBzpATRGIYwu0Ik16Pm7SIcU03oydEj7wY68Y//2CZPg1pSF59FC
	lTGyi9FjWi9q1YWpDnxQiLyvRugQXGa5w2I4jlum9qaViG9tL16UoCpoEL+oezba+vps0Q
	dBRUkamfzg3bffUqyoJzfRAhdgDJB7KyE0fXR+BcuA1OYY5yVbxV72L5+vAJ8Q==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 02/24] erofs: add superblock data structure in Rust
Date: Mon, 16 Sep 2024 21:56:12 +0800
Message-ID: <20240916135634.98554-3-toolmanp@tlmp.cc>
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

This patch adds a compilable super_rs.rs and introduces superblock
data structure in Rust. Note that this patch leaves C-side code
untouched.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/Kconfig                      |  10 ++
 fs/erofs/Makefile                     |   1 +
 fs/erofs/rust/erofs_sys.rs            |  22 +++++
 fs/erofs/rust/erofs_sys/superblock.rs | 132 ++++++++++++++++++++++++++
 fs/erofs/rust/mod.rs                  |   4 +
 fs/erofs/super_rs.rs                  |   9 ++
 6 files changed, 178 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock.rs
 create mode 100644 fs/erofs/rust/mod.rs
 create mode 100644 fs/erofs/super_rs.rs

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 6ea60661fa55..e2883efbf497 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -178,3 +178,13 @@ config EROFS_FS_PCPU_KTHREAD_HIPRI
 	  at higher priority.
 
 	  If unsure, say N.
+
+config EROFS_FS_RUST
+	bool "EROFS use RUST Replacement (EXPERIMENTAL)"
+	depends on EROFS_FS && RUST
+	help
+	  This permits EROFS to use EXPERIMENTAL Rust implementation
+	  for EROFS. This should be considered as an experimental
+	  feature for now.
+
+	  If unsure, say N.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 4331d53c7109..fb46a2c7fb50 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -9,3 +9,4 @@ erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_BACKED_BY_FILE) += fileio.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
+erofs-$(CONFIG_EROFS_FS_RUST) += super_rs.o
diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
new file mode 100644
index 000000000000..0f1400175fc2
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -0,0 +1,22 @@
+#![allow(dead_code)]
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+//! A pure Rust implementation of the EROFS filesystem.
+//! Technical Details are documented in the [EROFS Documentation](https://erofs.docs.kernel.org/en/latest/)
+
+// It's unavoidable to import alloc here. Since there are so many backends there and if we want to
+// to use trait object to export Filesystem pointer. The alloc crate here is necessary.
+
+#[cfg(not(CONFIG_EROFS_FS = "y"))]
+extern crate alloc;
+
+/// Erofs requires block index to a 32 bit unsigned integer.
+pub(crate) type Blk = u32;
+/// Erofs requires normal offset to be a 64bit unsigned integer.
+pub(crate) type Off = u64;
+/// Erofs requires inode nid to be a 64bit unsigned integer.
+pub(crate) type Nid = u64;
+/// Erofs Super Offset to read the ondisk superblock
+pub(crate) const EROFS_SUPER_OFFSET: Off = 1024;
+pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
new file mode 100644
index 000000000000..213be6dbc553
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -0,0 +1,132 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::*;
+use core::mem::size_of;
+
+/// The ondisk superblock structure.
+#[derive(Debug, Clone, Copy, Default)]
+#[repr(C)]
+pub(crate) struct SuperBlock {
+    pub(crate) magic: u32,
+    pub(crate) checksum: i32,
+    pub(crate) feature_compat: i32,
+    pub(crate) blkszbits: u8,
+    pub(crate) sb_extslots: u8,
+    pub(crate) root_nid: i16,
+    pub(crate) inos: i64,
+    pub(crate) build_time: i64,
+    pub(crate) build_time_nsec: i32,
+    pub(crate) blocks: i32,
+    pub(crate) meta_blkaddr: u32,
+    pub(crate) xattr_blkaddr: u32,
+    pub(crate) uuid: [u8; 16],
+    pub(crate) volume_name: [u8; 16],
+    pub(crate) feature_incompat: i32,
+    pub(crate) compression: i16,
+    pub(crate) extra_devices: i16,
+    pub(crate) devt_slotoff: i16,
+    pub(crate) dirblkbits: u8,
+    pub(crate) xattr_prefix_count: u8,
+    pub(crate) xattr_prefix_start: i32,
+    pub(crate) packed_nid: i64,
+    pub(crate) xattr_filter_reserved: u8,
+    pub(crate) reserved: [u8; 23],
+}
+
+impl TryFrom<&[u8]> for SuperBlock {
+    type Error = core::array::TryFromSliceError;
+    fn try_from(value: &[u8]) -> Result<Self, Self::Error> {
+        value[0..128].try_into()
+    }
+}
+
+impl From<[u8; 128]> for SuperBlock {
+    fn from(value: [u8; 128]) -> Self {
+        Self {
+            magic: u32::from_le_bytes([value[0], value[1], value[2], value[3]]),
+            checksum: i32::from_le_bytes([value[4], value[5], value[6], value[7]]),
+            feature_compat: i32::from_le_bytes([value[8], value[9], value[10], value[11]]),
+            blkszbits: value[12],
+            sb_extslots: value[13],
+            root_nid: i16::from_le_bytes([value[14], value[15]]),
+            inos: i64::from_le_bytes([
+                value[16], value[17], value[18], value[19], value[20], value[21], value[22],
+                value[23],
+            ]),
+            build_time: i64::from_le_bytes([
+                value[24], value[25], value[26], value[27], value[28], value[29], value[30],
+                value[31],
+            ]),
+            build_time_nsec: i32::from_le_bytes([value[32], value[33], value[34], value[35]]),
+            blocks: i32::from_le_bytes([value[36], value[37], value[38], value[39]]),
+            meta_blkaddr: u32::from_le_bytes([value[40], value[41], value[42], value[43]]),
+            xattr_blkaddr: u32::from_le_bytes([value[44], value[45], value[46], value[47]]),
+            uuid: value[48..64].try_into().unwrap(),
+            volume_name: value[64..80].try_into().unwrap(),
+            feature_incompat: i32::from_le_bytes([value[80], value[81], value[82], value[83]]),
+            compression: i16::from_le_bytes([value[84], value[85]]),
+            extra_devices: i16::from_le_bytes([value[86], value[87]]),
+            devt_slotoff: i16::from_le_bytes([value[88], value[89]]),
+            dirblkbits: value[90],
+            xattr_prefix_count: value[91],
+            xattr_prefix_start: i32::from_le_bytes([value[92], value[93], value[94], value[95]]),
+            packed_nid: i64::from_le_bytes([
+                value[96], value[97], value[98], value[99], value[100], value[101], value[102],
+                value[103],
+            ]),
+            xattr_filter_reserved: value[104],
+            reserved: value[105..128].try_into().unwrap(),
+        }
+    }
+}
+
+pub(crate) type SuperBlockBuf = [u8; size_of::<SuperBlock>()];
+pub(crate) const SUPERBLOCK_EMPTY_BUF: SuperBlockBuf = [0; size_of::<SuperBlock>()];
+
+/// Used for external address calculation.
+pub(crate) struct Accessor {
+    pub(crate) base: Off,
+    pub(crate) off: Off,
+    pub(crate) len: Off,
+    pub(crate) nr: Off,
+}
+
+impl Accessor {
+    pub(crate) fn new(address: Off, bits: Off) -> Self {
+        let sz = 1 << bits;
+        let mask = sz - 1;
+        Accessor {
+            base: (address >> bits) << bits,
+            off: address & mask,
+            len: sz - (address & mask),
+            nr: address >> bits,
+        }
+    }
+}
+
+impl SuperBlock {
+    pub(crate) fn blk_access(&self, address: Off) -> Accessor {
+        Accessor::new(address, self.blkszbits as Off)
+    }
+
+    pub(crate) fn blknr(&self, pos: Off) -> Blk {
+        (pos >> self.blkszbits) as Blk
+    }
+
+    pub(crate) fn blkpos(&self, blk: Blk) -> Off {
+        (blk as Off) << self.blkszbits
+    }
+
+    pub(crate) fn blksz(&self) -> Off {
+        1 << self.blkszbits
+    }
+
+    pub(crate) fn blk_round_up(&self, addr: Off) -> Blk {
+        ((addr + self.blksz() - 1) >> self.blkszbits) as Blk
+    }
+
+    pub(crate) fn iloc(&self, nid: Nid) -> Off {
+        self.blkpos(self.meta_blkaddr) + ((nid as Off) << (5 as Off))
+    }
+}
diff --git a/fs/erofs/rust/mod.rs b/fs/erofs/rust/mod.rs
new file mode 100644
index 000000000000..e6c0731f2533
--- /dev/null
+++ b/fs/erofs/rust/mod.rs
@@ -0,0 +1,4 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+pub(crate) mod erofs_sys;
diff --git a/fs/erofs/super_rs.rs b/fs/erofs/super_rs.rs
new file mode 100644
index 000000000000..4b8cbef507e3
--- /dev/null
+++ b/fs/erofs/super_rs.rs
@@ -0,0 +1,9 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+//! EROFS Rust Kernel Module Helpers Implementation
+//! This is only for experimental purpose. Feedback is always welcome.
+
+#[allow(dead_code)]
+#[allow(missing_docs)]
+pub(crate) mod rust;
-- 
2.46.0

