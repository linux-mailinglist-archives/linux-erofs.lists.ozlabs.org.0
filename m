Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59697A344
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495032;
	bh=bCX/VGnpSaFf2bcuOvskzF/4BX9NNeVk1l0oyYrgTyQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kwyVbrgsxb/PV+9SyjoZQ/N818I9aOcHg53sRMpjTRnXo9wD48ZVpywYEp2iCN+xD
	 J9B+U2dNbEFJTKqXtOcjMgylxVCt4eCduNNagDEEu8olErQaVqtR2PRkIikV0hNr63
	 sC/1wt/FiMvObGUNOKTwt8fsQT1Pgfx0wRTr9aqihpP/FfnE6pN0sseWcth/pLt0uF
	 UKiRT7SVAl/iKNEH76nG5dPjITOPjDanefDG5QaJV8EK4PpYFL61t4YB0g7ctTaWR/
	 Fm1MvDz2vNy3QGDiOEQuGU/SGrRCaxM1i+RB20BybE6kL+ToVUbHKxuEY+zyzZaDV9
	 qwcDmE3CPRRnA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgX3GlQz3c9w
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495029;
	cv=none; b=iBIv15ndVk0NgbpCw2CzmxPBrLWZl/Kwv19lALiTNwERUUwGR2x+PTpyQw6kiizp83XVQIisKT57saHvhdR4lVcoMVkHM7lt0mconYayRruqJmLLyplqXNaECSEqs2pH/D6JgOSVCstZbIl0ei1TGlA+VvL4QcXF09Dfpy5ssxFTSjbPg9p1yISEAkBHie3jT62lzFPqlKghSmJgGE1sIXqu2x4dawMQw0JLt849GVWNVQongBjjb245QN5E49ebUqerbaE/eHujDeEuSkKRVKdjlpl8dt+5s0/zTFOLfdfJmzcMszNG+ybwWx1pxT0AYtQk7hAqlGlnFF50efbzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495029; c=relaxed/relaxed;
	bh=bCX/VGnpSaFf2bcuOvskzF/4BX9NNeVk1l0oyYrgTyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCWaRULMqNUxWaQAzgdtQKgdPbcxgQeit2kdilTOqK3RnD7x/8lwuUvDciH4FJq7/MFdOQr2OevKZ2jDSSNL9wfWkkjYPmIuKHwdsbJWHj0Bfcv4nc/Mle5M3WAPrlizxIdyjlS9kLxxCP+CFynNBmAy8bXanFvQGKYwT1Togw8NhTjGyQy4MXIUG+J7PfVCuft/Mv5y/Kw9IkAOMfGy6j5mCo4dBMphRVDdaUf6WAhNiXFZ+Op32QUCH1bQQXB1c/evPOuWGvhZ4HpIx6chFMKm3J9ZBs9EyKfFdT++fIVtrdHAXR8FmUbCU6csQOD9VBjXdl7+sxIg01baUMV7Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=g8obcaLK; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=g8obcaLK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgT4C11z2yR3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:09 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CD5769989;
	Mon, 16 Sep 2024 09:57:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495027; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=bCX/VGnpSaFf2bcuOvskzF/4BX9NNeVk1l0oyYrgTyQ=;
	b=g8obcaLKn83twIxtsW1bMKexchJ/MixNaNHqV9/9wVbN1Tm0XJI+GQOH/h+dJ0gXl+uX7P
	7xEc4xBpK51y0PKnnS4/Ma7hE99UXXOx7ap0tAZcH9XaV3UtgfAojztOBAoCnvX/XThgaL
	MxKJNTvonxSeZQ4cikSnniS8pN4cmaMlU0svNBht1nckie5xXQMSKQfeKr4Q+ILgP6Nbpi
	7ZzdyLcmeRasnDv7/ROCWkaxoMufdke1WjhW5g8pTWWtQFc8Gou3JqwYHnM7Oer5rWrhgZ
	jD1dcmCu80OQR4cNzMMvsaFzmHW3FLjE+xnVgr7kC8EyxHAZt6ovnWDlORqLTQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 15/24] erofs: add iter methods in filesystem in Rust
Date: Mon, 16 Sep 2024 21:56:25 +0800
Message-ID: <20240916135634.98554-16-toolmanp@tlmp.cc>
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

Implement mapped iter that uses the MapIter and can yield data that is
backed by EROFS inode.

Implement continuous_iter and mapped_iter for filesystem which can
returns an iterator that yields raw data.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/data.rs               |  2 +
 .../rust/erofs_sys/data/raw_iters/ref_iter.rs | 63 +++++++++++++++++++
 .../rust/erofs_sys/data/raw_iters/traits.rs   |  4 ++
 fs/erofs/rust/erofs_sys/superblock.rs         | 13 ++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs     | 22 +++++++
 5 files changed, 104 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
index 483f3204ce42..21630673c24e 100644
--- a/fs/erofs/rust/erofs_sys/data.rs
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -2,6 +2,8 @@
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 pub(crate) mod backends;
 pub(crate) mod raw_iters;
+use super::inode::*;
+use super::map::*;
 use super::superblock::*;
 use super::*;
 
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
index 5aa2b7f44f3d..d39c9523b628 100644
--- a/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
@@ -4,6 +4,69 @@
 use super::super::*;
 use super::*;
 
+pub(crate) struct RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+    sb: &'a SuperBlock,
+    backend: &'a B,
+    map_iter: MapIter<'a, 'b, FS, I>,
+}
+
+impl<'a, 'b, FS, B, I> RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+    pub(crate) fn new(
+        sb: &'a SuperBlock,
+        backend: &'a B,
+        map_iter: MapIter<'a, 'b, FS, I>,
+    ) -> Self {
+        Self {
+            sb,
+            backend,
+            map_iter,
+        }
+    }
+}
+
+impl<'a, 'b, FS, B, I> Iterator for RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+    type Item = PosixResult<RefBuffer<'a>>;
+    fn next(&mut self) -> Option<Self::Item> {
+        match self.map_iter.next() {
+            Some(map) => match map {
+                Ok(m) => {
+                    let accessor = self.sb.blk_access(m.physical.start);
+                    let len = m.physical.len.min(accessor.len);
+                    match self.backend.as_buf(m.physical.start, len) {
+                        Ok(buf) => Some(Ok(buf)),
+                        Err(e) => Some(Err(e)),
+                    }
+                }
+                Err(e) => Some(Err(e)),
+            },
+            None => None,
+        }
+    }
+}
+
+impl<'a, 'b, FS, B, I> BufferMapIter<'a> for RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: Backend,
+    I: Inode,
+{
+}
+
 /// Continous Ref Buffer Iterator which iterates over a range of disk addresses within the
 /// the temp block size. Since the temp block is always the same size as page and it will not
 /// overflow.
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
index 90b6a51658a9..531e970cdb49 100644
--- a/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
@@ -3,6 +3,10 @@
 
 use super::super::*;
 
+/// Represents a basic iterator over a range of bytes from data backends.
+/// The access order is guided by the block maps from the filesystem.
+pub(crate) trait BufferMapIter<'a>: Iterator<Item = PosixResult<RefBuffer<'a>>> {}
+
 /// Represents a basic iterator over a range of bytes from data backends.
 /// Note that this is skippable and can be used to move the iterator's cursor forward.
 pub(crate) trait ContinuousBufferIter<'a>:
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index fc6b3cb00b18..f60657eff3d6 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -5,6 +5,7 @@
 use alloc::boxed::Box;
 use core::mem::size_of;
 
+use super::data::raw_iters::*;
 use super::data::*;
 use super::devices::*;
 use super::inode::*;
@@ -274,6 +275,18 @@ fn map(&self, inode: &I, offset: Off) -> MapResult {
             _ => todo!(),
         }
     }
+
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> PosixResult<Box<dyn BufferMapIter<'a> + 'b>>;
+
+    fn continuous_iter<'a>(
+        &'a self,
+        offset: Off,
+        len: Off,
+    ) -> PosixResult<Box<dyn ContinuousBufferIter<'a> + 'a>>;
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
diff --git a/fs/erofs/rust/erofs_sys/superblock/mem.rs b/fs/erofs/rust/erofs_sys/superblock/mem.rs
index 12bf797bd1e3..5756dc08744c 100644
--- a/fs/erofs/rust/erofs_sys/superblock/mem.rs
+++ b/fs/erofs/rust/erofs_sys/superblock/mem.rs
@@ -1,6 +1,7 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::alloc_helper::*;
 use super::data::raw_iters::ref_iter::*;
 use super::*;
 
@@ -33,6 +34,27 @@ fn as_filesystem(&self) -> &dyn FileSystem<I> {
         self
     }
 
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> PosixResult<Box<dyn BufferMapIter<'a> + 'b>> {
+        heap_alloc(RefMapIter::new(
+            &self.sb,
+            &self.backend,
+            MapIter::new(self, inode, offset),
+        ))
+        .map(|v| v as Box<dyn BufferMapIter<'a> + 'b>)
+    }
+    fn continuous_iter<'a>(
+        &'a self,
+        offset: Off,
+        len: Off,
+    ) -> PosixResult<Box<dyn ContinuousBufferIter<'a> + 'a>> {
+        heap_alloc(ContinuousRefIter::new(&self.sb, &self.backend, offset, len))
+            .map(|v| v as Box<dyn ContinuousBufferIter<'a> + 'a>)
+    }
+
     fn device_info(&self) -> &DeviceInfo {
         &self.device_info
     }
-- 
2.46.0

