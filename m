Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E997A343
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495031;
	bh=OlEgwvboFeWlv8zS3o2IBrRUjCWpIFBmMrHI8v0zFQI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TmhY7AdSrpVWVzMPR842bz+KIG5fuWgGUgxjoMdfEhCcVUl3pz6FFf8D/v6dnHOSK
	 L+F8D6fau9nDeqLrerjne7Y3OrXcjJjEhqVFNqJ4mLJav4CsagCCrOxqRgdsyDstWf
	 rqeTDzMZld9PBZwBXYrL2zArcbbNxbfsPOYL9kEX6tYpV1OHaipXaKkLUg7yp30uKo
	 BiCLy4Jd0zeWbKoXhJfJUFBDROUxbRB/PgY2WLqfIBo3K8pgfatULrI0lziZbSP7Cn
	 b9Ca4IBGTn6qfCPi22bW0JWF3eWj+mte8qCrxYK+H3V1FT9M5dLs3zPObvmYYVIZIk
	 K9YMK6o/cNc0A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgW5zcDz302N
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495028;
	cv=none; b=gGtdyFyGp25+SE7iqyBagAo6tvNvdo09qErYKNL6U+pCCUrBGtcMYhdrxgu7V/7FdOZh4/2LUVoZgxdOK9gpebeSQ0bfaz47Jyh/UFmypt1ZNJ6bMpuKN84BnDeW5k6Zk0dpeq3S11B/usQ6Qj/exTBtBmYu3lp9oZe5Uf9YuV2QrTcwgCDmNDuPeSlyL8Hsdas44sUTfw44rfFGwkiAplgGtD+TrKXoxVYjCPXSdk6/kx5ocJS3YnN2hMmvN6E+Vdpxx+0CE924s9eE6WOC+AcvUBCsxIENUXiJ4CQfcXVtcJXgpX8o09Il5Pf+/Hr367PyMeQXBqlnbEJ2KZ5bYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495028; c=relaxed/relaxed;
	bh=OlEgwvboFeWlv8zS3o2IBrRUjCWpIFBmMrHI8v0zFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8HzEipg6cjMt02vTcbv6+sw0v6gbEr2kweTHcr892bg9Dbm1jmPlwPKKg7pQhvbnz+aTYthByUs532168UixD/SFuBhsmyQDrL20xRg34scZV+Wnc5AeUI0z+FT4UZ0ELyRM1qQkBoC4+R0ZtQi2VKKfPG+IPJEFG9aZVef2IGxyG7s1X4uq4ynqwS/3C3CyUNo5VD1HaKmwLhkmYswzt7FTby44FDlwPHMDDFQdhtnXoCpnuavOHSsNoufNbKoWyoCvcCXe0bukFvW5JPOrVku+OWgXDNL4AOV4VKhnPXnb9K2RyEmN9qWFhj/IzSESG/W7B8C3z5o+0Mw7/56ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=OhDZuHKS; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=OhDZuHKS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgS406Lz30WS
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:08 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9630369981;
	Mon, 16 Sep 2024 09:57:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495025; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OlEgwvboFeWlv8zS3o2IBrRUjCWpIFBmMrHI8v0zFQI=;
	b=OhDZuHKSiJhuEfIz7ReFU6eFI5k+gYwPu8MhBCsYM0T+rbRh1gmc0xESMjiFWkMKIaETSE
	aeFmGCTipcRxNiqkaUFiBcrhcMp1evf73Hjpd0ch8pPOyiYhYktNJIX0eFU38Tes9ukbGz
	dJk391kNAqq8b+adb78FQt+O9/CMAY2FUShVMt/GxyRpy8vt+TQ7Qymfz3neRkBUKz+Elp
	EFOlAeF3mN2pPmnJzf6bKc1fSmCPQeIvXo3iBTbtPn35EhmJCQwvPTb7jyNupjdyAPVN8r
	Daw8vcQjXsI1uhZ7Izjwt45aelZ/hE2wUyBBlIUQELOydvanyHcIIkTQ+dDS1w==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 14/24] erofs: add block mapping capability in Rust
Date: Mon, 16 Sep 2024 21:56:24 +0800
Message-ID: <20240916135634.98554-15-toolmanp@tlmp.cc>
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

Implement block mapping in rust and implement map iterators
over Inode which will be used in data access.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/map.rs        |  54 +++++++++++
 fs/erofs/rust/erofs_sys/superblock.rs | 129 ++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/map.rs b/fs/erofs/rust/erofs_sys/map.rs
index 757e8083c8f1..f56f31cefcd5 100644
--- a/fs/erofs/rust/erofs_sys/map.rs
+++ b/fs/erofs/rust/erofs_sys/map.rs
@@ -1,7 +1,10 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::inode::*;
+use super::superblock::*;
 use super::*;
+
 pub(crate) const MAP_MAPPED: u32 = 0x0001;
 pub(crate) const MAP_META: u32 = 0x0002;
 pub(crate) const MAP_ENCODED: u32 = 0x0004;
@@ -43,3 +46,54 @@ fn from(value: MapType) -> Self {
 }
 
 pub(crate) type MapResult = PosixResult<Map>;
+
+/// Iterates over the data map represented by an inode.
+pub(crate) struct MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    fs: &'a FS,
+    inode: &'b I,
+    offset: Off,
+    len: Off,
+}
+
+impl<'a, 'b, FS, I> MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    pub(crate) fn new(fs: &'a FS, inode: &'b I, offset: Off) -> Self {
+        Self {
+            fs,
+            inode,
+            offset,
+            len: inode.info().file_size(),
+        }
+    }
+}
+
+impl<'a, 'b, FS, I> Iterator for MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    type Item = MapResult;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.offset >= self.len {
+            None
+        } else {
+            let result = self.fs.map(self.inode, self.offset);
+            match result {
+                Ok(m) => {
+                    let accessor = self.fs.superblock().blk_access(m.physical.start);
+                    let len = m.physical.len.min(accessor.len);
+                    self.offset += len;
+                    Some(Ok(m))
+                }
+                Err(e) => Some(Err(e)),
+            }
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index 940ab0b03a26..fc6b3cb00b18 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -8,8 +8,11 @@
 use super::data::*;
 use super::devices::*;
 use super::inode::*;
+use super::map::*;
 use super::*;
 
+use crate::round;
+
 /// The ondisk superblock structure.
 #[derive(Debug, Clone, Copy, Default)]
 #[repr(C)]
@@ -135,6 +138,10 @@ pub(crate) fn blk_round_up(&self, addr: Off) -> Blk {
     pub(crate) fn iloc(&self, nid: Nid) -> Off {
         self.blkpos(self.meta_blkaddr) + ((nid as Off) << (5 as Off))
     }
+    pub(crate) fn chunk_access(&self, format: ChunkFormat, address: Off) -> Accessor {
+        let chunkbits = format.chunkbits() + self.blkszbits as u16;
+        Accessor::new(address, chunkbits as Off)
+    }
 }
 
 pub(crate) trait FileSystem<I>
@@ -145,6 +152,128 @@ pub(crate) trait FileSystem<I>
     fn backend(&self) -> &dyn Backend;
     fn as_filesystem(&self) -> &dyn FileSystem<I>;
     fn device_info(&self) -> &DeviceInfo;
+    fn flatmap(&self, inode: &I, offset: Off, inline: bool) -> MapResult {
+        let sb = self.superblock();
+        let nblocks = sb.blk_round_up(inode.info().file_size());
+        let blkaddr = match inode.info().spec() {
+            Spec::RawBlk(blkaddr) => Ok(blkaddr),
+            _ => Err(EUCLEAN),
+        }?;
+
+        let lastblk = if inline { nblocks - 1 } else { nblocks };
+        if offset < sb.blkpos(lastblk) {
+            let len = inode.info().file_size().min(sb.blkpos(lastblk)) - offset;
+            Ok(Map {
+                logical: Segment { start: offset, len },
+                physical: Segment {
+                    start: sb.blkpos(blkaddr) + offset,
+                    len,
+                },
+                algorithm_format: 0,
+                device_id: 0,
+                map_type: MapType::Normal,
+            })
+        } else if inline {
+            let len = inode.info().file_size() - offset;
+            let accessor = sb.blk_access(offset);
+            Ok(Map {
+                logical: Segment { start: offset, len },
+                physical: Segment {
+                    start: sb.iloc(inode.nid())
+                        + inode.info().inode_size()
+                        + inode.info().xattr_size()
+                        + accessor.off,
+                    len,
+                },
+                algorithm_format: 0,
+                device_id: 0,
+                map_type: MapType::Meta,
+            })
+        } else {
+            Err(EUCLEAN)
+        }
+    }
+
+    fn chunk_map(&self, inode: &I, offset: Off) -> MapResult {
+        let sb = self.superblock();
+        let chunkformat = match inode.info().spec() {
+            Spec::Chunk(chunkformat) => Ok(chunkformat),
+            _ => Err(EUCLEAN),
+        }?;
+        let accessor = sb.chunk_access(chunkformat, offset);
+
+        if chunkformat.is_chunkindex() {
+            let unit = size_of::<ChunkIndex>() as Off;
+            let pos = round!(
+                UP,
+                self.superblock().iloc(inode.nid())
+                    + inode.info().inode_size()
+                    + inode.info().xattr_size()
+                    + unit * accessor.nr,
+                unit
+            );
+            let mut buf = [0u8; size_of::<ChunkIndex>()];
+            self.backend().fill(&mut buf, pos)?;
+            let chunk_index = ChunkIndex::from(buf);
+            if chunk_index.blkaddr == u32::MAX {
+                Err(EUCLEAN)
+            } else {
+                Ok(Map {
+                    logical: Segment {
+                        start: accessor.base + accessor.off,
+                        len: accessor.len,
+                    },
+                    physical: Segment {
+                        start: sb.blkpos(chunk_index.blkaddr) + accessor.off,
+                        len: accessor.len,
+                    },
+                    algorithm_format: 0,
+                    device_id: chunk_index.device_id & self.device_info().mask,
+                    map_type: MapType::Normal,
+                })
+            }
+        } else {
+            let unit = 4;
+            let pos = round!(
+                UP,
+                sb.iloc(inode.nid())
+                    + inode.info().inode_size()
+                    + inode.info().xattr_size()
+                    + unit * accessor.nr,
+                unit
+            );
+            let mut buf = [0u8; 4];
+            self.backend().fill(&mut buf, pos)?;
+            let blkaddr = u32::from_le_bytes(buf);
+            let len = accessor.len.min(inode.info().file_size() - offset);
+            if blkaddr == u32::MAX {
+                Err(EUCLEAN)
+            } else {
+                Ok(Map {
+                    logical: Segment {
+                        start: accessor.base + accessor.off,
+                        len,
+                    },
+                    physical: Segment {
+                        start: sb.blkpos(blkaddr) + accessor.off,
+                        len,
+                    },
+                    algorithm_format: 0,
+                    device_id: 0,
+                    map_type: MapType::Normal,
+                })
+            }
+        }
+    }
+
+    fn map(&self, inode: &I, offset: Off) -> MapResult {
+        match inode.info().format().layout() {
+            Layout::FlatInline => self.flatmap(inode, offset, true),
+            Layout::FlatPlain => self.flatmap(inode, offset, false),
+            Layout::Chunk => self.chunk_map(inode, offset),
+            _ => todo!(),
+        }
+    }
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
-- 
2.46.0

