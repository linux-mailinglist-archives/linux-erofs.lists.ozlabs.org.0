Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A784D94B002
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 20:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723056765;
	bh=suJBVpDXr1kUA9ccGtfWe9EdBvn4vAXKB/WD0d1K4cQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lC/rjsVBV74MWwZvgidVuNZgG3ZS5jLkAR7ZG2d9evjNa1Q6dZBarIReVEjab9/G/
	 IEarETKv2j3yxRy0CErZe3HOySKR5nNHgjNbbY+c49V0Zhu/u9SmhN9Uafwz4ke/wz
	 tZ07/caYGYMb0yQyYfr3IQN4hAZP2pWIJA6AdyYt/GpWf2zSAGlsUDW0Y1tLqFxFQK
	 L3uFc5Liw06FfQo/bzdG1zUixWomMy/WHdi6bX1fRrhCT98TaEM5WD0C07fWYyh9i5
	 NRCkHnvGXX0Xm546Hgq9E0RmV1f8DrxTq694i93FCAPjd0A3WSPFz+J8KfG5lePS/4
	 /vpoYG9Cyzkzw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfK713g2lz3dL2
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 04:52:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=cEUqUI3b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfK6k3s4Hz3d8M
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2024 04:52:30 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA57F6990A;
	Wed,  7 Aug 2024 14:47:22 -0400 (EDT)
To: hsiangkao@linux.alibaba.com
Subject: [RFC PATCH 1/3] erofs: add erofs_sys crate
Date: Thu,  8 Aug 2024 02:47:01 +0800
Message-ID: <20240807184703.722206-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807184703.722206-1-toolmanp@tlmp.cc>
References: <20240807184703.722206-1-toolmanp@tlmp.cc>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This commit imports a erofs rust implementation from the following repo [1].
This crate introduces several key traits with only transparent access,
it does not support compression backend. In kernel, the folio source is used
as the memory backend for this filesystem implementation.

Also this crate provides helper function for Box operations
to bridge the difference between heap allocations API from userspace.

However, since in-tree crate support is not yet completed, currently
the crate is imported as a module to the rust code.

[1]: https://github.com/ToolmanP/erofs-rs

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/alloc_helper.rs      |  57 ++
 fs/erofs/rust/erofs_sys/compression.rs       |  18 +
 fs/erofs/rust/erofs_sys/data.rs              | 640 +++++++++++++++++++
 fs/erofs/rust/erofs_sys/data/uncompressed.rs |  61 ++
 fs/erofs/rust/erofs_sys/devices.rs           |  53 ++
 fs/erofs/rust/erofs_sys/dir.rs               |  83 +++
 fs/erofs/rust/erofs_sys/inode.rs             | 407 ++++++++++++
 fs/erofs/rust/erofs_sys/map.rs               |  28 +
 fs/erofs/rust/erofs_sys/operations.rs        |  96 +++
 fs/erofs/rust/erofs_sys/superblock.rs        | 554 ++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock/file.rs   | 114 ++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs    | 156 +++++
 fs/erofs/rust/erofs_sys/xattrs.rs            | 175 +++++
 13 files changed, 2442 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/alloc_helper.rs
 create mode 100644 fs/erofs/rust/erofs_sys/compression.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/uncompressed.rs
 create mode 100644 fs/erofs/rust/erofs_sys/devices.rs
 create mode 100644 fs/erofs/rust/erofs_sys/dir.rs
 create mode 100644 fs/erofs/rust/erofs_sys/inode.rs
 create mode 100644 fs/erofs/rust/erofs_sys/map.rs
 create mode 100644 fs/erofs/rust/erofs_sys/operations.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/file.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/mem.rs
 create mode 100644 fs/erofs/rust/erofs_sys/xattrs.rs

diff --git a/fs/erofs/rust/erofs_sys/alloc_helper.rs b/fs/erofs/rust/erofs_sys/alloc_helper.rs
new file mode 100644
index 000000000000..931abfa71c45
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/alloc_helper.rs
@@ -0,0 +1,57 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+/// This module provides helper functions for the alloc crate
+/// Note that in linux kernel, the allocation is fallible however in userland it is not.
+/// Since most of the functions depend on infallible allocation, here we provide helper functions
+/// so that most of codes don't need to be changed.
+
+#[cfg(CONFIG_EROFS_FS = "y")]
+use kernel::prelude::*;
+
+use alloc::boxed::Box;
+use alloc::vec::Vec;
+
+pub(crate) fn push_vec<T>(v: &mut Vec<T>, value: T) {
+    match () {
+        #[cfg(CONFIG_EROFS_FS = "y")]
+        () => {
+            v.push(value, GFP_KERNEL).unwrap();
+        }
+        #[cfg(not(CONFIG_EROFS_FS = "y"))]
+        () => {
+            v.push(value);
+        }
+    }
+}
+
+pub(crate) fn extend_from_slice<T: Clone>(v: &mut Vec<T>, slice: &[T]) {
+    match () {
+        #[cfg(CONFIG_EROFS_FS = "y")]
+        () => {
+            v.extend_from_slice(slice, GFP_KERNEL).unwrap();
+        }
+        #[cfg(not(CONFIG_EROFS_FS = "y"))]
+        () => {
+            v.extend_from_slice(slice);
+        }
+    }
+}
+
+pub(crate) fn heap_alloc<T>(value: T) -> Box<T> {
+    match () {
+        #[cfg(CONFIG_EROFS_FS = "y")]
+        () => Box::new(value, GFP_KERNEL).unwrap(),
+        #[cfg(not(CONFIG_EROFS_FS = "y"))]
+        () => Box::new(value),
+    }
+}
+
+pub(crate) fn vec_with_capacity<T>(capacity: usize) -> Vec<T> {
+    match () {
+        #[cfg(CONFIG_EROFS_FS = "y")]
+        () => Vec::with_capacity(capacity, GFP_KERNEL).unwrap(),
+        #[cfg(not(CONFIG_EROFS_FS = "y"))]
+        () => Vec::with_capacity(capacity),
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/compression.rs b/fs/erofs/rust/erofs_sys/compression.rs
new file mode 100644
index 000000000000..6a7d84722350
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/compression.rs
@@ -0,0 +1,18 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+#[derive(Debug, Clone, Copy)]
+#[repr(C)]
+pub(crate) enum SuperblockCompressionInfo {
+    AvailableComprAlgs(u16),
+    Lz4MaxDistance(u16),
+}
+
+#[allow(dead_code)]
+pub(crate) enum InodeCompressionInfo {}
+
+impl Default for SuperblockCompressionInfo {
+    fn default() -> Self {
+        Self::AvailableComprAlgs(0)
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
new file mode 100644
index 000000000000..b047cf55d89f
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -0,0 +1,640 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+pub(crate) mod uncompressed;
+
+use alloc::boxed::Box;
+use alloc::vec::Vec;
+
+use super::alloc_helper::*;
+use super::dir::*;
+use super::inode::*;
+use super::map::*;
+use super::superblock::*;
+use super::*;
+
+use crate::round;
+
+#[derive(Debug)]
+pub(crate) enum SourceError {
+    Dummy,
+    OutBound,
+}
+
+#[derive(Debug)]
+pub(crate) enum BackendError {
+    Dummy,
+}
+
+pub(crate) type SourceResult<T> = Result<T, SourceError>;
+pub(crate) type BackendResult<T> = Result<T, BackendError>;
+
+/// Represent some sort of generic data source. This cound be file, memory or even network.
+/// Note that users should never use this directly please use backends instead.
+pub(crate) trait Source {
+    fn fill(&self, data: &mut [u8], offset: Off) -> SourceResult<u64>;
+    fn get_temp_buffer(&self, offset: Off, maxsize: Off) -> SourceResult<TempBuffer> {
+        let mut block: Page = EROFS_PAGE;
+        let pa = PageAddress::from(offset);
+        self.fill(&mut block, pa.page)
+            .map(|sz| TempBuffer::new(block, pa.pg_off as usize, sz.min(maxsize) as usize))
+    }
+}
+
+/// Represents a file source.
+pub(crate) trait FileSource: Source {}
+
+// Represents a memory source. Note that as_buf and as_buf_mut should only represent memory within
+// a page. Cross page memory is not supported and treated as an error.
+pub(crate) trait PageSource<'a>: Source {
+    fn as_buf(&'a self, offset: Off, len: Off) -> SourceResult<RefBuffer<'a>>;
+    fn as_buf_mut(&'a mut self, offset: Off, len: Off) -> SourceResult<RefBufferMut<'a>>;
+}
+
+/// Represents a generic data access backend that is backed by some sort of data source.
+/// This often has temporary buffers to decompress the data from the data source.
+/// The method signatures are the same as those of the Source trait.
+pub(crate) trait Backend {
+    fn fill(&self, data: &mut [u8], offset: Off) -> BackendResult<u64>;
+    fn get_temp_buffer(&self, offset: Off, maxsize: Off) -> BackendResult<TempBuffer>;
+}
+
+/// Represents a file backend whose source is a file.
+pub(crate) trait FileBackend: Backend {}
+
+/// Represents a memory backend whose source is memory.
+pub(crate) trait MemoryBackend<'a>: Backend {
+    fn as_buf(&'a self, offset: Off, len: Off) -> BackendResult<RefBuffer<'a>>;
+    fn as_buf_mut(&'a mut self, offset: Off, len: Off) -> BackendResult<RefBufferMut<'a>>;
+}
+
+/// Represents a TempBuffer which owns a temporary on-stack/on-heap buffer.
+/// Note that file or network backend can only use this since they can't access the data from the
+/// memory directly.
+pub(crate) struct TempBuffer {
+    block: Page,
+    start: usize,
+    maxsize: usize,
+}
+
+/// Represents a buffer trait which can yield its internal reference or be casted as an iterator of
+/// DirEntries.
+pub(crate) trait Buffer {
+    fn content(&self) -> &[u8];
+    fn iter_dir(&self) -> DirCollection<'_> {
+        DirCollection::new(self.content())
+    }
+}
+
+/// Represents a mutable buffer trait which can yield its internal mutable reference.
+pub(crate) trait BufferMut: Buffer {
+    fn content_mut(&mut self) -> &mut [u8];
+}
+
+impl TempBuffer {
+    pub(crate) fn new(block: Page, start: usize, maxsize: usize) -> Self {
+        Self {
+            block,
+            start,
+            maxsize,
+        }
+    }
+    pub(crate) const fn empty() -> Self {
+        Self {
+            block: EROFS_PAGE,
+            start: 0,
+            maxsize: 0,
+        }
+    }
+}
+
+impl Buffer for TempBuffer {
+    fn content(&self) -> &[u8] {
+        &self.block[self.start..self.start + self.maxsize]
+    }
+}
+
+impl BufferMut for TempBuffer {
+    fn content_mut(&mut self) -> &mut [u8] {
+        &mut self.block[self.start..self.maxsize + self.start]
+    }
+}
+
+/// Represents a buffer that holds a reference to a slice of data that
+/// is borrowed from the thin air.
+pub(crate) struct RefBuffer<'a> {
+    buf: &'a [u8],
+    start: usize,
+    len: usize,
+    put_buf: fn(*mut core::ffi::c_void),
+}
+
+impl Buffer for [u8] {
+    fn content(&self) -> &[u8] {
+        self
+    }
+}
+
+impl BufferMut for [u8] {
+    fn content_mut(&mut self) -> &mut [u8] {
+        self
+    }
+}
+
+impl<'a> Buffer for RefBuffer<'a> {
+    fn content(&self) -> &[u8] {
+        &self.buf[self.start..self.start + self.len]
+    }
+}
+
+impl<'a> RefBuffer<'a> {
+    pub(crate) fn new(
+        buf: &'a [u8],
+        start: usize,
+        len: usize,
+        put_buf: fn(*mut core::ffi::c_void),
+    ) -> Self {
+        Self {
+            buf,
+            start,
+            len,
+            put_buf,
+        }
+    }
+}
+
+impl<'a> Drop for RefBuffer<'a> {
+    fn drop(&mut self) {
+        (self.put_buf)(self.buf.as_ptr() as *mut core::ffi::c_void)
+    }
+}
+
+/// Represents a mutable buffer that holds a reference to a slice of data
+/// that is borrowed from the thin air.
+pub(crate) struct RefBufferMut<'a> {
+    buf: &'a mut [u8],
+    start: usize,
+    len: usize,
+    put_buf: fn(*mut core::ffi::c_void),
+}
+
+impl<'a> RefBufferMut<'a> {
+    pub(crate) fn new(
+        buf: &'a mut [u8],
+        start: usize,
+        len: usize,
+        put_buf: fn(*mut core::ffi::c_void),
+    ) -> Self {
+        Self {
+            buf,
+            start,
+            len,
+            put_buf,
+        }
+    }
+}
+
+impl<'a> Buffer for RefBufferMut<'a> {
+    fn content(&self) -> &[u8] {
+        &self.buf[self.start..self.start + self.len]
+    }
+}
+
+impl<'a> BufferMut for RefBufferMut<'a> {
+    fn content_mut(&mut self) -> &mut [u8] {
+        &mut self.buf[self.start..self.start + self.len]
+    }
+}
+
+impl<'a> Drop for RefBufferMut<'a> {
+    fn drop(&mut self) {
+        (self.put_buf)(self.buf.as_mut_ptr() as *mut core::ffi::c_void)
+    }
+}
+
+/// Iterates over the data map represented by an inode.
+pub(crate) struct MapIter<'a, 'b, FS, I>
+where
+    FS: FileSystem<I>,
+    I: Inode,
+{
+    sbi: &'a FS,
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
+    pub(crate) fn new(sbi: &'a FS, inode: &'b I, offset: Off) -> Self {
+        Self {
+            sbi,
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
+    type Item = Map;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.offset >= self.len {
+            None
+        } else {
+            let mut m = self.sbi.map(self.inode, self.offset);
+            let pa = PageAddress::from(m.physical.start);
+            let len = m.physical.len.min(pa.pg_len);
+            m.physical.len = len;
+            m.logical.len = len;
+            self.offset += len;
+            Some(m)
+        }
+    }
+}
+
+pub(crate) trait BufferMapIter<'a>: Iterator<Item = Box<dyn Buffer + 'a>> {}
+
+pub(crate) struct TempBufferMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: FileBackend,
+    I: Inode,
+{
+    backend: &'a B,
+    map_iter: MapIter<'a, 'b, FS, I>,
+}
+
+impl<'a, 'b, FS, B, I> TempBufferMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: FileBackend,
+    I: Inode,
+{
+    pub(crate) fn new(backend: &'a B, map_iter: MapIter<'a, 'b, FS, I>) -> Self {
+        Self { backend, map_iter }
+    }
+}
+
+impl<'a, 'b, FS, B, I> Iterator for TempBufferMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: FileBackend,
+    I: Inode,
+{
+    type Item = Box<dyn Buffer + 'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        match self.map_iter.next() {
+            Some(m) => {
+                if m.logical.len < EROFS_PAGE_SZ as Off {
+                    let mut block = EROFS_PAGE;
+                    match self
+                        .backend
+                        .fill(&mut block[0..m.physical.len as usize], m.physical.start)
+                    {
+                        Ok(rlen) => Some(heap_alloc(TempBuffer::new(block, 0, rlen as usize))),
+                        Err(_) => None,
+                    }
+                } else {
+                    match self
+                        .backend
+                        .get_temp_buffer(m.physical.start, m.logical.len)
+                    {
+                        Ok(buffer) => Some(heap_alloc(buffer)),
+                        Err(_) => None,
+                    }
+                }
+            }
+            None => None,
+        }
+    }
+}
+
+impl<'a, 'b, FS, B, I> BufferMapIter<'a> for TempBufferMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: FileBackend,
+    I: Inode,
+{
+}
+
+pub(crate) struct RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: MemoryBackend<'a>,
+    I: Inode,
+{
+    backend: &'a B,
+    map_iter: MapIter<'a, 'b, FS, I>,
+}
+
+impl<'a, 'b, FS, B, I> RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: MemoryBackend<'a>,
+    I: Inode,
+{
+    pub(crate) fn new(backend: &'a B, map_iter: MapIter<'a, 'b, FS, I>) -> Self {
+        Self { backend, map_iter }
+    }
+}
+
+impl<'a, 'b, FS, B, I> Iterator for RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: MemoryBackend<'a>,
+    I: Inode,
+{
+    type Item = Box<dyn Buffer + 'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        match self.map_iter.next() {
+            Some(m) => match self
+                .backend
+                .as_buf(m.physical.start, m.physical.len.min(EROFS_PAGE_SZ))
+            {
+                Ok(buf) => Some(heap_alloc(buf)),
+                Err(_) => None,
+            },
+            None => None,
+        }
+    }
+}
+
+impl<'a, 'b, FS, B, I> BufferMapIter<'a> for RefMapIter<'a, 'b, FS, B, I>
+where
+    FS: FileSystem<I>,
+    B: MemoryBackend<'a>,
+    I: Inode,
+{
+}
+
+pub(crate) struct ContinuousTempBufferIter<'a, B>
+where
+    B: FileBackend,
+{
+    backend: &'a B,
+    offset: Off,
+    len: Off,
+}
+
+impl<'a, B> ContinuousTempBufferIter<'a, B>
+where
+    B: FileBackend,
+{
+    pub(crate) fn new(backend: &'a B, offset: Off, len: Off) -> Self {
+        Self {
+            backend,
+            offset,
+            len,
+        }
+    }
+}
+
+impl<'a, B> Iterator for ContinuousTempBufferIter<'a, B>
+where
+    B: FileBackend,
+{
+    type Item = Box<dyn Buffer + 'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.len == 0 {
+            return None;
+        }
+
+        let result: Option<Self::Item> = self
+            .backend
+            .get_temp_buffer(self.offset, self.len)
+            .map_or_else(
+                |_| None,
+                |buffer| {
+                    self.offset += buffer.content().len() as Off;
+                    self.len -= buffer.content().len() as Off;
+                    Some(heap_alloc(buffer) as Box<dyn Buffer + 'a>)
+                },
+            );
+        result
+    }
+}
+
+pub(crate) struct ContinuousRefIter<'a, B>
+where
+    B: MemoryBackend<'a>,
+{
+    backend: &'a B,
+    offset: Off,
+    len: Off,
+    first: bool,
+}
+
+impl<'a, B> ContinuousRefIter<'a, B>
+where
+    B: MemoryBackend<'a>,
+{
+    pub(crate) fn new(backend: &'a B, offset: Off, len: Off) -> Self {
+        Self {
+            backend,
+            offset,
+            len,
+            first: true,
+        }
+    }
+}
+
+/// Represents a basic iterator over a range of bytes from data backends.
+/// Note that this is skippable and can be used to move the iterator's cursor forward.
+pub(crate) trait ContinousBufferIter<'a>: Iterator<Item = Box<dyn Buffer + 'a>> {
+    fn advance_off(&mut self, offset: Off);
+}
+
+impl<'a, B> ContinousBufferIter<'a> for ContinuousTempBufferIter<'a, B>
+where
+    B: FileBackend,
+{
+    fn advance_off(&mut self, offset: Off) {
+        self.offset += offset;
+        self.len -= offset;
+    }
+}
+
+impl<'a, B> Iterator for ContinuousRefIter<'a, B>
+where
+    B: MemoryBackend<'a>,
+{
+    type Item = Box<dyn Buffer + 'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.len == 0 {
+            return None;
+        }
+
+        let pa = PageAddress::from(self.offset);
+        let len = pa.pg_len.min(self.len);
+        let result: Option<Self::Item> = self.backend.as_buf(self.offset, len).map_or_else(
+            |_| None,
+            |x| {
+                self.offset += x.content().len() as Off;
+                self.len -= x.content().len() as Off;
+                Some(heap_alloc(x) as Box<dyn Buffer + 'a>)
+            },
+        );
+        result
+    }
+}
+
+impl<'a, B> ContinousBufferIter<'a> for ContinuousRefIter<'a, B>
+where
+    B: MemoryBackend<'a>,
+{
+    fn advance_off(&mut self, offset: Off) {
+        self.offset += offset;
+        self.len -= offset
+    }
+}
+
+/// This is used as a iterator to read the metadata buffer. The metadata buffer is a continous 4
+/// bytes aligned collection of integers. This is used primarily when reading an inode's xattrs
+/// indexe.
+pub(crate) struct MetadataBufferIter<'a> {
+    backend: &'a dyn Backend,
+    buffer: TempBuffer,
+    offset: Off,
+    total: usize,
+}
+
+impl<'a> MetadataBufferIter<'a> {
+    pub(crate) fn new(backend: &'a dyn Backend, offset: Off, total: usize) -> Self {
+        Self {
+            backend,
+            buffer: TempBuffer::empty(),
+            offset,
+            total,
+        }
+    }
+}
+
+impl<'a> Iterator for MetadataBufferIter<'a> {
+    type Item = Vec<u8>;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.total == 0 {
+            return None;
+        }
+
+        if self.buffer.start == self.buffer.maxsize {
+            self.buffer = self
+                .backend
+                .get_temp_buffer(self.offset, EROFS_PAGE_SZ)
+                .unwrap();
+            self.offset += self.buffer.maxsize as Off;
+        }
+
+        let data = self.buffer.content();
+        let size = u16::from_le_bytes([data[0], data[1]]) as usize;
+        let mut result: Vec<u8> = Vec::new();
+        extend_from_slice(&mut result, &data[2..size + 2]);
+        self.buffer.start = round!(UP, self.buffer.start + size + 2, 4);
+        self.total -= 1;
+        Some(result)
+    }
+}
+
+/// Represents a skippable continuous buffer iterator. This is used primarily for reading the
+/// extended attributes. Since the key-value is flattened out in its original format.
+pub(crate) struct SkippableContinousIter<'a> {
+    iter: Box<dyn ContinousBufferIter<'a> + 'a>,
+    data: Box<dyn Buffer + 'a>,
+    d_off: Off,
+}
+
+impl<'a> SkippableContinousIter<'a> {
+    pub(crate) fn new(mut iter: Box<dyn ContinousBufferIter<'a> + 'a>) -> Self {
+        let data = iter.next().unwrap();
+        Self {
+            iter,
+            data,
+            d_off: 0,
+        }
+    }
+    pub(crate) fn skip(&mut self, offset: Off) {
+        let d_len = self.data.content().len() as Off - self.d_off;
+
+        if offset < d_len {
+            self.d_off += offset;
+        } else {
+            self.d_off = 0;
+            self.iter.advance_off(d_len);
+            self.data = self.iter.next().unwrap();
+        }
+    }
+
+    pub(crate) fn read(&mut self, buf: &mut [u8]) {
+        let mut d_len = self.data.content().len() as Off - self.d_off;
+        let mut b_off = 0 as Off;
+        let b_len = buf.len() as Off;
+        if d_len != 0 && d_len >= b_len {
+            buf.clone_from_slice(
+                &self.data.content()[self.d_off as usize..(self.d_off + b_len) as usize],
+            );
+            self.d_off += b_len;
+        } else {
+            buf[b_off as usize..(b_off + d_len) as usize]
+                .copy_from_slice(&self.data.content()[self.d_off as usize..]);
+            b_off += d_len;
+            while b_off < b_len {
+                self.d_off = 0;
+                self.data = self.iter.next().unwrap();
+                d_len = self.data.content().len() as Off;
+                if d_len >= b_len - b_off {
+                    buf[b_off as usize..]
+                        .copy_from_slice(&self.data.content()[..(b_len - b_off) as usize]);
+                    self.d_off = b_len - b_off;
+                    return;
+                } else {
+                    buf[b_off as usize..(b_off + d_len) as usize]
+                        .copy_from_slice(self.data.content());
+                    b_off += d_len;
+                }
+            }
+        }
+    }
+
+    pub(crate) fn try_cmp(&mut self, buf: &[u8]) -> Result<(), u64> {
+        let d_len = self.data.content().len() as Off - self.d_off;
+        let b_len = buf.len() as Off;
+        let mut b_off = 0 as Off;
+
+        if d_len != 0 && d_len >= b_len {
+            if self.data.content()[self.d_off as usize..(self.d_off + b_len) as usize]
+                == buf[0..b_len as usize]
+            {
+                Ok(())
+            } else {
+                Err(b_len)
+            }
+        } else {
+            if d_len != 0 {
+                let cmp_len = d_len.min(b_len);
+                b_off += cmp_len;
+                if self.data.content()[self.d_off as usize..(self.d_off + cmp_len) as usize]
+                    != buf[0..cmp_len as usize]
+                {
+                    return Err(b_off);
+                }
+            }
+            while b_off < b_len {
+                self.d_off = 0;
+                self.data = self.iter.next().unwrap();
+                let d_len = self.data.content().len() as Off;
+                let cmp_len = d_len.min(b_len - b_off);
+                b_off += cmp_len;
+                if self.data.content()[0..cmp_len as usize] != buf[b_off as usize..] {
+                    return Err(b_off);
+                }
+            }
+            Ok(())
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/data/uncompressed.rs b/fs/erofs/rust/erofs_sys/data/uncompressed.rs
new file mode 100644
index 000000000000..7b194c5d5e39
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/uncompressed.rs
@@ -0,0 +1,61 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use super::*;
+
+pub(crate) struct UncompressedBackend<T>
+where
+    T: Source,
+{
+    source: T,
+}
+
+impl<T> Backend for UncompressedBackend<T>
+where
+    T: Source,
+{
+    fn fill(&self, data: &mut [u8], offset: Off) -> BackendResult<u64> {
+        self.source
+            .fill(data, offset)
+            .map_or_else(|_| Err(BackendError::Dummy), Ok)
+    }
+    fn get_temp_buffer(&self, offset: Off, maxsize: Off) -> BackendResult<TempBuffer> {
+        match self.source.get_temp_buffer(offset, maxsize) {
+            Ok(buffer) => Ok(buffer),
+            Err(_) => Err(BackendError::Dummy),
+        }
+    }
+}
+
+impl<T> FileBackend for UncompressedBackend<T> where T: Source {}
+
+impl<'a, T> MemoryBackend<'a> for UncompressedBackend<T>
+where
+    T: PageSource<'a>,
+{
+    fn as_buf(&'a self, offset: Off, len: Off) -> BackendResult<RefBuffer<'a>> {
+        self.source
+            .as_buf(offset, len)
+            .map_err(|_| BackendError::Dummy)
+    }
+    fn as_buf_mut(&'a mut self, offset: Off, len: Off) -> BackendResult<RefBufferMut<'a>> {
+        self.source
+            .as_buf_mut(offset, len)
+            .map_err(|_| BackendError::Dummy)
+    }
+}
+
+impl<T: Source> UncompressedBackend<T> {
+    pub(crate) fn new(source: T) -> Self {
+        Self { source }
+    }
+}
+
+impl<T> From<T> for UncompressedBackend<T>
+where
+    T: Source,
+{
+    fn from(value: T) -> Self {
+        Self::new(value)
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys/devices.rs
new file mode 100644
index 000000000000..ea951f2ef517
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/devices.rs
@@ -0,0 +1,53 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use super::alloc_helper::*;
+use super::data::*;
+use alloc::vec::Vec;
+
+#[derive(Copy, Clone, Debug)]
+pub(crate) struct DeviceSpec {
+    pub(crate) tags: [u8; 64],
+    pub(crate) blocks: u32,
+    pub(crate) mapped_blocks: u32,
+}
+
+#[derive(Copy, Clone, Debug)]
+#[repr(C)]
+pub(crate) struct DeviceSlot {
+    tags: [u8; 64],
+    blocks: u32,
+    mapped_blocks: u32,
+    reserved: [u8; 56],
+}
+
+pub(crate) struct DeviceInfo {
+    pub(crate) mask: u16,
+    pub(crate) specs: Vec<DeviceSpec>,
+}
+
+pub(crate) fn get_device_infos<'a>(iter: &mut (dyn ContinousBufferIter<'a> + 'a)) -> DeviceInfo {
+    let mut specs = Vec::new();
+    for data in iter {
+        let slots = unsafe {
+            core::slice::from_raw_parts(
+                data.content().as_ptr() as *const DeviceSlot,
+                data.content().len() >> 7,
+            )
+        };
+        for slot in slots {
+            push_vec(
+                &mut specs,
+                DeviceSpec {
+                    tags: slot.tags,
+                    blocks: slot.blocks,
+                    mapped_blocks: slot.mapped_blocks,
+                },
+            );
+        }
+    }
+    DeviceInfo {
+        mask: specs.len().next_power_of_two() as u16,
+        specs,
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/dir.rs b/fs/erofs/rust/erofs_sys/dir.rs
new file mode 100644
index 000000000000..e60fa69329e9
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/dir.rs
@@ -0,0 +1,83 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+/// On-disk Directory Descriptor Format for EROFS
+/// Documented on [EROFS Directory](https://erofs.docs.kernel.org/en/latest/core_ondisk.html#directories)
+#[repr(C, packed)]
+pub(crate) struct DirentDesc {
+    pub(crate) nid: u64,
+    pub(crate) nameoff: u16,
+    pub(crate) file_type: u8,
+    pub(crate) reserved: u8,
+}
+
+/// In memory representation of a real directory entry.
+pub(crate) struct Dirent<'a> {
+    pub(crate) desc: &'a DirentDesc,
+    pub(crate) name: &'a [u8],
+}
+
+/// Create a collection of directory entries from a buffer.
+/// This is a helper struct to iterate over directory entries.
+pub(crate) struct DirCollection<'a> {
+    data: &'a [u8],
+    offset: usize,
+    total: usize,
+}
+
+impl<'a> DirCollection<'a> {
+    pub(crate) fn new(buffer: &'a [u8]) -> Self {
+        let desc: &DirentDesc = unsafe { &*(buffer.as_ptr() as *const DirentDesc) };
+        Self {
+            data: buffer,
+            offset: 0,
+            total: desc.nameoff as usize / core::mem::size_of::<DirentDesc>(),
+        }
+    }
+    pub(crate) fn dirent(&self, index: usize) -> Option<Dirent<'a>> {
+        //SAFETY: Note that DirentDesc is yet another ffi-safe type and the size of Block is larger
+        //than that of DirentDesc. It's safe to allow this unsafe cast.
+        let descs: &'a [DirentDesc] = unsafe {
+            core::slice::from_raw_parts(self.data.as_ptr() as *const DirentDesc, self.total)
+        };
+        if index >= self.total {
+            None
+        } else if index == self.total - 1 {
+            let len = self.data.len() - descs[self.total - 1].nameoff as usize;
+            Some(Dirent {
+                desc: &descs[index],
+                name: &self.data
+                    [descs[index].nameoff as usize..(descs[index].nameoff as usize) + len],
+            })
+        } else {
+            let len = (descs[index + 1].nameoff - descs[index].nameoff) as usize;
+            Some(Dirent {
+                desc: &descs[index],
+                name: &self.data
+                    [descs[index].nameoff as usize..(descs[index].nameoff as usize) + len],
+            })
+        }
+    }
+    pub(crate) fn skip_dir(&mut self, offset: usize) {
+        self.offset += offset;
+    }
+    pub(crate) fn total(&self) -> usize {
+        self.total
+    }
+}
+
+impl<'a> Iterator for DirCollection<'a> {
+    type Item = Dirent<'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        self.dirent(self.offset).map(|x| {
+            self.offset += 1;
+            x
+        })
+    }
+}
+
+impl<'a> Dirent<'a> {
+    pub(crate) fn dirname(&self) -> &'a [u8] {
+        self.name
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/inode.rs b/fs/erofs/rust/erofs_sys/inode.rs
new file mode 100644
index 000000000000..18710deef85a
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/inode.rs
@@ -0,0 +1,407 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use super::superblock::*;
+use super::*;
+use core::mem::size_of;
+
+/// Represents the compact bitfield of the Erofs Inode format.
+#[repr(transparent)]
+#[derive(Clone, Copy)]
+pub(crate) struct Format(u16);
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
+        match (self.0) & ((1 << 1) - 1) {
+            0 => Version::Compat,
+            1 => Version::Extended,
+            _ => Version::Unknown,
+        }
+    }
+
+    pub(crate) fn layout(&self) -> Layout {
+        match (self.0 >> 1) & ((1 << 3) - 1) {
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
+pub(crate) const CHUNK_FORMAT_INDEXES: u16 = 0x20;
+
+/// Represents on-disk chunk index of the file backing inode.
+#[repr(C)]
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
+/// Represents the data spec of the inode which is either consequentive raw blocks or in sparse chunk format.
+#[derive(Clone, Copy, Debug)]
+pub(crate) enum DataSpec {
+    RawBlk(u32),
+    ChunkFormat(u16),
+}
+
+/// Represents the inode spec which is either data or device.
+#[derive(Clone, Copy, Debug)]
+pub(crate) enum Spec {
+    Data(DataSpec),
+    Device(u32),
+    Unknown,
+}
+
+/// Convert the spec from the format of the inode based on the layout.
+impl Spec {
+    pub(crate) fn data(u: &[u8; 4], layout: Layout) -> Self {
+        match layout {
+            Layout::FlatInline | Layout::FlatPlain => {
+                Spec::Data(DataSpec::RawBlk(u32::from_le_bytes(*u)))
+            }
+            Layout::Chunk => {
+                let chunkformat = u16::from_le_bytes([u[0], u[1]]);
+                Spec::Data(DataSpec::ChunkFormat(chunkformat))
+            }
+            _ => Spec::Unknown,
+        }
+    }
+}
+
+/// Helper functions for Inode Info.
+impl InodeInfo {
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
+    pub(crate) fn xattr_size(&self) -> Off {
+        match self {
+            Self::Extended(extended) => 12 + 4 * (extended.i_xattr_icount as u64 - 1),
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
+            0o40000 => Spec::data(u, self.format().layout()),
+            0o100000 => Spec::data(u, self.format().layout()),
+            0o120000 => Spec::data(u, self.format().layout()), // Real Data
+            0o10000 => Spec::Device(0),                        // FIFO
+            0o140000 => Spec::Device(0),                       // Socket
+            0o60000 => unimplemented!(),                       // Block
+            0o20000 => unimplemented!(),                       // Character
+            _ => Spec::Unknown,
+        }
+    }
+
+    pub(crate) fn inode_type(&self) -> Type {
+        let mode = match self {
+            Self::Extended(extended) => extended.i_mode,
+            Self::Compact(compact) => compact.i_mode,
+        };
+        match mode & 0o170000 {
+            0o40000 => Type::Directory, // Directory
+            0o100000 => Type::Regular,  // Regular File
+            0o120000 => Type::Link,     // Symbolic Link
+            0o10000 => Type::Fifo,      // FIFO
+            0o140000 => Type::Socket,   // Socket
+            0o60000 => Type::Block,     // Block
+            0o20000 => Type::Character, // Character
+            _ => Type::Unknown,
+        }
+    }
+}
+
+pub(crate) type CompactInodeInfoBuf = [u8; size_of::<CompactInodeInfo>()];
+pub(crate) type ExtendedInodeInfoBuf = [u8; size_of::<ExtendedInodeInfo>()];
+pub(crate) const DEFAULT_INODE_BUF: ExtendedInodeInfoBuf = [0; size_of::<ExtendedInodeInfo>()];
+
+pub(crate) trait Inode: Sized {
+    fn new(
+        _sb: &SuperBlock,
+        info: InodeInfo,
+        nid: Nid,
+        xattrs_header: xattrs::MemEntryIndexHeader,
+    ) -> Self;
+    fn info(&self) -> &InodeInfo;
+    fn xattrs_header(&self) -> &xattrs::MemEntryIndexHeader;
+    fn nid(&self) -> Nid;
+}
+
+#[derive(Debug)]
+pub(crate) enum InodeError {
+    VersionError,
+    UnknownError,
+}
+
+type InodeResult<T> = Result<T, InodeError>;
+
+impl TryFrom<CompactInodeInfoBuf> for CompactInodeInfo {
+    type Error = InodeError;
+    fn try_from(value: CompactInodeInfoBuf) -> Result<Self, Self::Error> {
+        //SAFETY: all the types present are ffi-safe. safe to cast here since only [u8;64] could be
+        //passed into this function and it's definitely safe.
+        let inode: CompactInodeInfo = Self {
+            i_format: Format(u16::from_le_bytes(value[0..2].try_into().unwrap())),
+            i_xattr_icount: u16::from_le_bytes(value[2..4].try_into().unwrap()),
+            i_mode: u16::from_le_bytes(value[4..6].try_into().unwrap()),
+            i_nlink: u16::from_le_bytes(value[6..8].try_into().unwrap()),
+            i_size: u32::from_le_bytes(value[8..12].try_into().unwrap()),
+            i_reserved: value[12..16].try_into().unwrap(),
+            i_u: value[16..20].try_into().unwrap(),
+            i_ino: u32::from_le_bytes(value[20..24].try_into().unwrap()),
+            i_uid: u16::from_le_bytes(value[24..26].try_into().unwrap()),
+            i_gid: u16::from_le_bytes(value[26..28].try_into().unwrap()),
+            i_reserved2: value[28..32].try_into().unwrap(),
+        };
+        let ifmt = &inode.i_format;
+        match ifmt.version() {
+            Version::Compat => Ok(inode),
+            Version::Extended => Err(InodeError::VersionError),
+            _ => Err(InodeError::UnknownError),
+        }
+    }
+}
+
+impl TryFrom<ExtendedInodeInfoBuf> for InodeInfo {
+    type Error = InodeError;
+    fn try_from(value: ExtendedInodeInfoBuf) -> Result<Self, Self::Error> {
+        let compact_buf: CompactInodeInfoBuf = value[0..32].try_into().unwrap();
+        let r: Result<CompactInodeInfo, Self::Error> = CompactInodeInfo::try_from(compact_buf);
+
+        match r {
+            Ok(compact) => Ok(InodeInfo::Compact(compact)),
+            Err(e) => match e {
+                //SAFETY: Note that try_into will return VersionError. This suggests that current
+                //buffer contains the extended inode. Since the types used are FFI-safe, it's safe
+                //to transtmute it here.
+                InodeError::VersionError => Ok(InodeInfo::Extended(ExtendedInodeInfo {
+                    i_format: Format(u16::from_le_bytes(value[0..2].try_into().unwrap())),
+                    i_xattr_icount: u16::from_le_bytes(value[2..4].try_into().unwrap()),
+                    i_mode: u16::from_le_bytes(value[4..6].try_into().unwrap()),
+                    i_reserved: value[6..8].try_into().unwrap(),
+                    i_size: u64::from_le_bytes(value[8..16].try_into().unwrap()),
+                    i_u: value[16..20].try_into().unwrap(),
+                    i_ino: u32::from_le_bytes(value[20..24].try_into().unwrap()),
+                    i_uid: u32::from_le_bytes(value[24..28].try_into().unwrap()),
+                    i_gid: u32::from_le_bytes(value[28..32].try_into().unwrap()),
+                    i_mtime: u64::from_le_bytes(value[32..40].try_into().unwrap()),
+                    i_mtime_nsec: u32::from_le_bytes(value[40..44].try_into().unwrap()),
+                    i_nlink: u32::from_le_bytes(value[44..48].try_into().unwrap()),
+                    i_reserved2: value[48..64].try_into().unwrap(),
+                })),
+                _ => Err(e),
+            },
+        }
+    }
+}
+
+pub(crate) trait InodeCollection {
+    type I: Inode + Sized;
+
+    fn iget(&mut self, nid: Nid, filesystem: &dyn FileSystem<Self::I>) -> &mut Self::I;
+}
+
+#[cfg(test)]
+pub(crate) mod tests {
+
+    extern crate std;
+    use super::*;
+    use crate::xattrs;
+    use std::collections::{hash_map::Entry, HashMap};
+
+    #[test]
+    fn test_inode_size() {
+        assert_eq!(core::mem::size_of::<CompactInodeInfo>(), 32);
+        assert_eq!(core::mem::size_of::<ExtendedInodeInfo>(), 64);
+    }
+
+    pub(crate) struct SimpleInode {
+        info: InodeInfo,
+        xattr_header: xattrs::MemEntryIndexHeader,
+        nid: Nid,
+    }
+
+    impl Inode for SimpleInode {
+        fn new(
+            _sb: &SuperBlock,
+            info: InodeInfo,
+            nid: Nid,
+            xattr_header: xattrs::MemEntryIndexHeader,
+        ) -> Self {
+            Self {
+                info,
+                xattr_header,
+                nid,
+            }
+        }
+        fn xattrs_header(&self) -> &xattrs::MemEntryIndexHeader {
+            &self.xattr_header
+        }
+        fn nid(&self) -> Nid {
+            self.nid
+        }
+        fn info(&self) -> &InodeInfo {
+            &self.info
+        }
+    }
+
+    impl InodeCollection for HashMap<Nid, SimpleInode> {
+        type I = SimpleInode;
+        fn iget(&mut self, nid: Nid, f: &dyn FileSystem<Self::I>) -> &mut Self::I {
+            match self.entry(nid) {
+                Entry::Vacant(v) => v.insert(Self::I::new(
+                    f.superblock(),
+                    f.read_inode_info(nid),
+                    nid,
+                    f.read_inode_xattrs_index(nid),
+                )),
+                Entry::Occupied(o) => o.into_mut(),
+            }
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/map.rs b/fs/erofs/rust/erofs_sys/map.rs
new file mode 100644
index 000000000000..bf75981bcd4a
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/map.rs
@@ -0,0 +1,28 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use super::*;
+
+pub(crate) const MAP_MAPPED: u32 = 0x0001;
+pub(crate) const MAP_META: u32 = 0x0002;
+pub(crate) const MAP_ENCODED: u32 = 0x0004;
+pub(crate) const MAP_FULL_MAPPED: u32 = 0x0008;
+pub(crate) const MAP_FRAGMENT: u32 = 0x0010;
+pub(crate) const MAP_PARTIAL_REF: u32 = 0x0020;
+
+#[derive(Debug, Default)]
+#[repr(C)]
+pub(crate) struct AddressMap {
+    pub(crate) start: Off,
+    pub(crate) len: Off,
+}
+
+#[derive(Debug, Default)]
+#[repr(C)]
+pub(crate) struct Map {
+    pub(crate) logical: AddressMap,
+    pub(crate) physical: AddressMap,
+    pub(crate) device_id: u16,
+    pub(crate) algorithm_format: u16,
+    pub(crate) flags: u32,
+}
diff --git a/fs/erofs/rust/erofs_sys/operations.rs b/fs/erofs/rust/erofs_sys/operations.rs
new file mode 100644
index 000000000000..afb6e232fde5
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/operations.rs
@@ -0,0 +1,96 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use alloc::vec::Vec;
+
+use super::alloc_helper::*;
+use super::data::*;
+use super::inode::*;
+use super::superblock::*;
+use super::xattrs;
+use super::*;
+
+// Because of the brain dead features of borrow-checker, it cannot statically analyze which part of the struct is exclusively borrowed.
+// Refactor out the real file operations, so that we can make sure things will get compiled.
+
+pub(crate) fn read_inode<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    nid: Nid,
+) -> &'a mut I
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    collection.iget(nid, filesystem)
+}
+
+pub(crate) fn ilookup<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    name: &str,
+) -> Option<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    let mut nid = filesystem.superblock().root_nid as Nid;
+    for part in name.split('/') {
+        if part.is_empty() {
+            continue;
+        }
+        let inode = read_inode(filesystem, collection, nid); // this part collection is reborrowed for shorter
+                                                             // lifetime inside the loop;
+        nid = filesystem.find_nid(inode, part)?
+    }
+    Some(read_inode(filesystem, collection, nid))
+}
+
+pub(crate) fn dir_walk<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    inode: &I,
+    name: &str,
+) -> Option<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    let mut nid = inode.nid();
+    for part in name.split('/') {
+        if part.is_empty() {
+            continue;
+        }
+        let inode = read_inode(filesystem, collection, nid); // this part collection is reborrowed for shorter
+                                                             // lifetime inside the loop;
+        nid = filesystem.find_nid(inode, part)?
+    }
+    Some(read_inode(filesystem, collection, nid))
+}
+
+pub(crate) fn dir_lookup<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    inode: &I,
+    name: &str,
+) -> Option<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    filesystem
+        .find_nid(inode, name)
+        .map(|nid| read_inode(filesystem, collection, nid))
+}
+
+pub(crate) fn get_xattr_prefixes(sb: &SuperBlock, backend: &dyn Backend) -> Vec<xattrs::Prefix> {
+    let mut result: Vec<xattrs::Prefix> = Vec::new();
+    for data in MetadataBufferIter::new(
+        backend,
+        (sb.xattr_prefix_start << 2) as Off,
+        sb.xattr_prefix_count as usize,
+    ) {
+        push_vec(&mut result, xattrs::Prefix(data));
+    }
+    result
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
new file mode 100644
index 000000000000..452e0aefb4f6
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -0,0 +1,554 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use alloc::boxed::Box;
+use alloc::vec::Vec;
+
+use crate::round;
+
+use super::alloc_helper::*;
+use super::data::*;
+use super::devices::*;
+use super::dir::*;
+use super::inode::*;
+use super::map::*;
+use super::xattrs;
+use super::xattrs::*;
+use super::*;
+
+use core::mem::size_of;
+
+pub(crate) mod file;
+pub(crate) mod mem;
+
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
+// SAFETY: SuperBlock uses all ffi-safe types.
+impl TryFrom<&[u8]> for SuperBlock {
+    type Error = core::array::TryFromSliceError;
+    fn try_from(value: &[u8]) -> Result<Self, Self::Error> {
+        value[0..128].try_into()
+    }
+}
+
+// SAFETY: SuperBlock uses all ffi-safe types.
+impl From<[u8; 128]> for SuperBlock {
+    fn from(value: [u8; 128]) -> Self {
+        Self {
+            magic: u32::from_le_bytes(value[0..4].try_into().unwrap()),
+            checksum: i32::from_le_bytes(value[4..8].try_into().unwrap()),
+            feature_compat: i32::from_le_bytes(value[8..12].try_into().unwrap()),
+            blkszbits: value[12],
+            sb_extslots: value[13],
+            root_nid: i16::from_le_bytes(value[14..16].try_into().unwrap()),
+            inos: i64::from_le_bytes(value[16..24].try_into().unwrap()),
+            build_time: i64::from_le_bytes(value[24..32].try_into().unwrap()),
+            build_time_nsec: i32::from_le_bytes(value[32..36].try_into().unwrap()),
+            blocks: i32::from_le_bytes(value[36..40].try_into().unwrap()),
+            meta_blkaddr: u32::from_le_bytes(value[40..44].try_into().unwrap()),
+            xattr_blkaddr: u32::from_le_bytes(value[44..48].try_into().unwrap()),
+            uuid: value[48..64].try_into().unwrap(),
+            volume_name: value[64..80].try_into().unwrap(),
+            feature_incompat: i32::from_le_bytes(value[80..84].try_into().unwrap()),
+            compression: i16::from_le_bytes(value[84..86].try_into().unwrap()),
+            extra_devices: i16::from_le_bytes(value[86..88].try_into().unwrap()),
+            devt_slotoff: i16::from_le_bytes(value[88..90].try_into().unwrap()),
+            dirblkbits: value[90],
+            xattr_prefix_count: value[91],
+            xattr_prefix_start: i32::from_le_bytes(value[92..96].try_into().unwrap()),
+            packed_nid: i64::from_le_bytes(value[96..104].try_into().unwrap()),
+            xattr_filter_reserved: value[104],
+            reserved: value[105..128].try_into().unwrap(),
+        }
+    }
+}
+
+pub(crate) type SuperBlockBuf = [u8; size_of::<SuperBlock>()];
+pub(crate) const SUPERBLOCK_EMPTY_BUF: SuperBlockBuf = [0; size_of::<SuperBlock>()];
+
+pub(crate) trait FileSystem<I>
+where
+    I: Inode,
+{
+    fn superblock(&self) -> &SuperBlock;
+    fn device_info(&self) -> &DeviceInfo;
+    fn backend(&self) -> &dyn Backend;
+    fn blknr(&self, pos: Off) -> Blk {
+        (pos >> self.superblock().blkszbits) as Blk
+    }
+
+    fn blkpos(&self, blk: Blk) -> Off {
+        (blk as Off) << self.superblock().blkszbits
+    }
+
+    fn blkoff(&self, offset: Off) -> Off {
+        offset & (self.blksz() - 1)
+    }
+
+    fn blksz(&self) -> Off {
+        1 << self.superblock().blkszbits
+    }
+
+    fn blk_round_up(&self, addr: Off) -> Blk {
+        ((addr + self.blksz() - 1) >> self.superblock().blkszbits) as Blk
+    }
+
+    fn iloc(&self, nid: Nid) -> Off {
+        let sb = &self.superblock();
+        self.blkpos(sb.meta_blkaddr) + ((nid as Off) << (5 as Off))
+    }
+
+    fn read_inode_info(&self, nid: Nid) -> InodeInfo {
+        let offset = self.iloc(nid);
+        let mut buf: ExtendedInodeInfoBuf = DEFAULT_INODE_BUF;
+        self.backend().fill(&mut buf, offset).unwrap();
+        InodeInfo::try_from(buf).unwrap()
+    }
+
+    fn xattr_prefixes(&self) -> &Vec<xattrs::Prefix>;
+
+    // Currently we eagerly initialized all xattrs;
+    //
+    fn read_inode_xattrs_index(&self, nid: Nid) -> xattrs::MemEntryIndexHeader {
+        let offset = self.iloc(nid);
+        let pa = PageAddress::from(offset);
+
+        let mut buf = EROFS_PAGE;
+        let mut indexes: Vec<u32> = Vec::new();
+
+        let rlen = self
+            .backend()
+            .fill(&mut buf[0..pa.pg_len as usize], offset)
+            .unwrap();
+
+        let header: xattrs::DiskEntryIndexHeader =
+            unsafe { *(buf.as_ptr() as *const xattrs::DiskEntryIndexHeader) };
+        let inline_count =
+            (((rlen - xattrs::XATTRS_HEADER_SIZE) >> 2) as usize).min(header.shared_count as usize);
+        let outbound_count = header.shared_count as usize - inline_count;
+
+        extend_from_slice(&mut indexes, unsafe {
+            core::slice::from_raw_parts(
+                (buf[xattrs::XATTRS_HEADER_SIZE as usize..pa.pg_len as usize])
+                    .as_ptr()
+                    .cast(),
+                inline_count,
+            )
+        });
+
+        if outbound_count == 0 {
+            xattrs::MemEntryIndexHeader {
+                name_filter: header.name_filter,
+                shared_indexes: indexes,
+            }
+        } else {
+            for block in self.continous_iter(
+                round!(UP, offset, EROFS_PAGE_SZ),
+                (outbound_count << 2) as Off,
+            ) {
+                let data = block.content();
+                extend_from_slice(&mut indexes, unsafe {
+                    core::slice::from_raw_parts(data.as_ptr().cast(), data.len() >> 2)
+                });
+            }
+            xattrs::MemEntryIndexHeader {
+                name_filter: header.name_filter,
+                shared_indexes: indexes,
+            }
+        }
+    }
+    fn flatmap(&self, inode: &I, offset: Off, inline: bool) -> Map {
+        let nblocks = self.blk_round_up(inode.info().file_size());
+
+        let blkaddr = match inode.info().spec() {
+            Spec::Data(ds) => match ds {
+                DataSpec::RawBlk(blkaddr) => blkaddr,
+                _ => unimplemented!(),
+            },
+            _ => unimplemented!(),
+        };
+
+        let lastblk = if inline { nblocks - 1 } else { nblocks };
+        let len = inode.info().file_size() - offset;
+        if offset < self.blkpos(lastblk) {
+            Map {
+                logical: AddressMap { start: offset, len },
+                physical: AddressMap {
+                    start: self.blkpos(blkaddr) + offset,
+                    len,
+                },
+                algorithm_format: 0,
+                device_id: 0,
+                flags: MAP_MAPPED,
+            }
+        } else if inline {
+            Map {
+                logical: AddressMap { start: offset, len },
+                physical: AddressMap {
+                    start: self.iloc(inode.nid())
+                        + inode.info().inode_size()
+                        + inode.info().xattr_size()
+                        + self.blkoff(offset),
+                    len,
+                },
+                algorithm_format: 0,
+                device_id: 0,
+                flags: MAP_MAPPED | MAP_META,
+            }
+        } else {
+            unimplemented!()
+        }
+    }
+
+    fn chunk_map(&self, inode: &I, offset: Off) -> Map {
+        let cs = match inode.info().spec() {
+            Spec::Data(ds) => match ds {
+                DataSpec::ChunkFormat(cs) => cs,
+                _ => unimplemented!(),
+            },
+            _ => unimplemented!(),
+        };
+        let chunkbits = ((cs & CHUNK_BLKBITS_MASK) + self.superblock().blkszbits as u16) as Off;
+
+        let chunknr = offset >> chunkbits;
+        if cs & CHUNK_FORMAT_INDEXES != 0 {
+            let unit = size_of::<ChunkIndex>() as Off;
+            let pos = round!(
+                UP,
+                self.iloc(inode.nid())
+                    + inode.info().inode_size()
+                    + inode.info().xattr_size()
+                    + unit * chunknr,
+                unit
+            );
+            let mut buf = [0u8; size_of::<ChunkIndex>()];
+            self.backend().fill(&mut buf, pos).unwrap();
+            let chunk_index = ChunkIndex::from(buf);
+
+            if chunk_index.blkaddr == u32::MAX {
+                Map::default()
+            } else {
+                Map {
+                    logical: AddressMap {
+                        start: chunknr << chunkbits,
+                        len: 1 << chunkbits,
+                    },
+                    physical: AddressMap {
+                        start: self.blkpos(chunk_index.blkaddr),
+                        len: 1 << chunkbits,
+                    },
+                    algorithm_format: 0,
+                    device_id: chunk_index.device_id & self.device_info().mask,
+                    flags: MAP_MAPPED,
+                }
+            }
+        } else {
+            let unit = 4;
+            let pos = round!(
+                UP,
+                self.iloc(inode.nid())
+                    + inode.info().inode_size()
+                    + inode.info().xattr_size()
+                    + unit * chunknr,
+                unit
+            );
+            let mut buf = [0u8; 4];
+            self.backend().fill(&mut buf, pos).unwrap();
+            let blkaddr = u32::from_le_bytes(buf);
+            if blkaddr == u32::MAX {
+                Map::default()
+            } else {
+                Map {
+                    logical: AddressMap {
+                        start: chunknr << chunkbits,
+                        len: 1 << chunkbits,
+                    },
+                    physical: AddressMap {
+                        start: self.blkpos(blkaddr),
+                        len: 1 << chunkbits,
+                    },
+                    algorithm_format: 0,
+                    device_id: 0,
+                    flags: MAP_MAPPED,
+                }
+            }
+        }
+    }
+
+    fn map(&self, inode: &I, offset: Off) -> Map {
+        match inode.info().format().layout() {
+            Layout::FlatInline => self.flatmap(inode, offset, true),
+            Layout::FlatPlain => self.flatmap(inode, offset, false),
+            Layout::Chunk => self.chunk_map(inode, offset),
+            _ => todo!(),
+        }
+    }
+
+    // TODO:: Remove the Box<dyn Iterator> here
+    // Maybe create another wrapper type and we implement the Iterator there?
+    // Seems unachievable because of static dispatch of Buffer is not allowed at compile time
+    // If we want to have trait object that can be exported to c_void
+    // Leave it as it is for tradeoffs
+
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> Box<dyn BufferMapIter<'a> + 'b>;
+
+    fn continous_iter<'a>(&'a self, offset: Off, len: Off)
+        -> Box<dyn ContinousBufferIter<'a> + 'a>;
+
+    fn fill_dentries(&self, inode: &I, offset: Off, emitter: &mut dyn FnMut(Dirent<'_>, Off)) {
+        if offset > inode.info().file_size() {
+            return;
+        }
+
+        let map_offset = round!(DOWN, offset, self.blksz());
+        let blk_offset = round!(UP, self.blkoff(offset), size_of::<DirentDesc>() as Off);
+
+        let mut map_iter = self.mapped_iter(inode, map_offset);
+        let first_buf = map_iter.next().unwrap();
+        let mut collection = first_buf.iter_dir();
+
+        let mut pos: Off = map_offset + blk_offset;
+
+        if blk_offset as usize / size_of::<DirentDesc>() <= collection.total() {
+            collection.skip_dir(blk_offset as usize / size_of::<DirentDesc>());
+            for dirent in collection {
+                emitter(dirent, pos);
+                pos += size_of::<DirentDesc>() as Off;
+            }
+        }
+
+        pos = round!(UP, pos, self.blksz());
+
+        for buf in map_iter {
+            for dirent in buf.iter_dir() {
+                emitter(dirent, pos);
+                pos += size_of::<DirentDesc>() as Off;
+            }
+            pos = round!(UP, pos, self.blksz());
+        }
+    }
+
+    fn find_nid(&self, inode: &I, name: &str) -> Option<Nid> {
+        for buf in self.mapped_iter(inode, 0) {
+            for dirent in buf.iter_dir() {
+                if dirent.dirname() == name.as_bytes() {
+                    return Some(dirent.desc.nid);
+                }
+            }
+        }
+        None
+    }
+
+    fn get_xattr(&self, inode: &I, index: u32, name: &[u8], buffer: &mut [u8]) -> bool {
+        let count = inode.info().xattr_count();
+        let shared_count = inode.xattrs_header().shared_indexes.len();
+        let inline_count = count as usize - shared_count;
+
+        let inline_offset = self.iloc(inode.nid())
+            + inode.info().inode_size() as Off
+            + size_of::<DiskEntryIndexHeader>() as Off
+            + shared_count as Off * 4;
+
+        {
+            let mut inline_provider =
+                SkippableContinousIter::new(self.continous_iter(inline_offset, u64::MAX));
+            for _ in 0..inline_count {
+                let header = inline_provider.get_entry_header();
+                if inline_provider.get_xattr_value(
+                    self.xattr_prefixes(),
+                    &header,
+                    name,
+                    index,
+                    buffer,
+                ) {
+                    return true;
+                }
+            }
+        }
+
+        for index in inode.xattrs_header().shared_indexes.iter() {
+            let mut provider = SkippableContinousIter::new(self.continous_iter(
+                self.blkpos(self.superblock().xattr_blkaddr) + (*index as Off) * 4,
+                u64::MAX,
+            ));
+            let header = provider.get_entry_header();
+            if provider.get_xattr_value(self.xattr_prefixes(), &header, name, *index, buffer) {
+                return true;
+            }
+        }
+        false
+    }
+
+    fn list_xattrs(&self, inode: &I, buffer: &mut [u8]) {
+        let count = inode.info().xattr_count();
+        let shared_count = inode.xattrs_header().shared_indexes.len();
+        let inline_count = count as usize - shared_count;
+        let inline_offset = self.iloc(inode.nid())
+            + inode.info().inode_size() as Off
+            + size_of::<DiskEntryIndexHeader>() as Off
+            + shared_count as Off * 4;
+
+        let mut offset = 0;
+        {
+            let mut inline_provider =
+                SkippableContinousIter::new(self.continous_iter(inline_offset, u64::MAX));
+            for _ in 0..inline_count {
+                let header = inline_provider.get_entry_header();
+                offset += inline_provider.get_xattr_name(
+                    self.xattr_prefixes(),
+                    &header,
+                    &mut buffer[offset..],
+                );
+            }
+        }
+
+        for index in inode.xattrs_header().shared_indexes.iter() {
+            let mut provider = SkippableContinousIter::new(self.continous_iter(
+                self.blkpos(self.superblock().xattr_blkaddr) + (*index as Off) * 4,
+                u64::MAX,
+            ));
+            let header = provider.get_entry_header();
+            offset +=
+                provider.get_xattr_name(self.xattr_prefixes(), &header, &mut buffer[offset..]);
+        }
+    }
+}
+
+pub(crate) struct SuperblockInfo<I, C>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    pub(crate) filesystem: Box<dyn FileSystem<I>>,
+    pub(crate) inodes: C,
+}
+
+impl<I, C> SuperblockInfo<I, C>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    pub(crate) fn new(fs: Box<dyn FileSystem<I>>, c: C) -> Self {
+        Self {
+            filesystem: fs,
+            inodes: c,
+        }
+    }
+}
+
+#[cfg(test)]
+pub(crate) mod tests {
+    extern crate std;
+
+    use alloc::string::ToString;
+
+    use super::*;
+    use crate::inode::tests::*;
+    use crate::operations::*;
+    use hex_literal::hex;
+    use sha2::{Digest, Sha512};
+    use std::collections::HashMap;
+    use std::format;
+    use std::fs::File;
+    use std::path::Path;
+    use std::vec;
+
+    pub(crate) const SB_MAGIC: u32 = 0xE0F5E1E2;
+
+    pub(crate) type SimpleBufferedFileSystem =
+        SuperblockInfo<SimpleInode, HashMap<Nid, SimpleInode>>;
+
+    pub(crate) fn load_fixtures() -> impl Iterator<Item = File> {
+        vec![512, 1024, 2048, 4096].into_iter().map(|num| {
+            let mut s = env!("CARGO_MANIFEST_DIR").to_string();
+            s.push_str(&format!("/tests/sample_{num}.img"));
+            File::options()
+                .read(true)
+                .write(true)
+                .open(Path::new(&s))
+                .unwrap()
+        })
+    }
+
+    fn test_superblock_def(sbi: &mut SimpleBufferedFileSystem) {
+        assert_eq!(sbi.filesystem.superblock().magic, SB_MAGIC);
+    }
+
+    fn test_filesystem_ilookup(sbi: &mut SimpleBufferedFileSystem) {
+        const LIPSUM_HEX: [u8;64] = hex!("6846740fd4c03c86524d39e0012ec8eb1e4b87e8a90c65227904148bc0e4d0592c209151a736946133cd57f7ec59c4e8a445e7732322dda9ce356f8d0100c4ca");
+        const LIPSUM_FILE_SIZE: u64 = 5060;
+        const LIPSUM_TYPE: Type = Type::Regular;
+        let inode = ilookup(&*sbi.filesystem, &mut sbi.inodes, "/texts/lipsum.txt").unwrap();
+        assert_eq!(inode.info().inode_type(), LIPSUM_TYPE);
+        assert_eq!(inode.info().file_size(), LIPSUM_FILE_SIZE);
+
+        let mut hasher = Sha512::new();
+        for block in sbi.filesystem.mapped_iter(inode, 0) {
+            hasher.update(block.content());
+        }
+        let result = hasher.finalize();
+        assert_eq!(result[..], LIPSUM_HEX);
+    }
+
+    fn test_continous_iter(sbi: &mut SimpleBufferedFileSystem) {
+        const README_HEX: [u8; 64] = hex!("99fffc75aec028f417d9782fffed6c5d877a29ad1b16fc62bfeb168cdaf8db6db2bad1814904cd0fa18a2396c2c618041682a010601f4052b9895138d4ed6f16");
+        const README_FILE_SIZE: u64 = 38;
+        const README_TYPE: Type = Type::Regular;
+        let inode = ilookup(&*sbi.filesystem, &mut sbi.inodes, "/README.md").unwrap();
+        assert_eq!(inode.info().inode_type(), README_TYPE);
+        assert_eq!(inode.info().file_size(), README_FILE_SIZE);
+        let map = sbi.filesystem.map(inode, 0);
+
+        let mut hasher = Sha512::new();
+        for block in sbi
+            .filesystem
+            .continous_iter(map.physical.start, map.physical.len)
+        {
+            hasher.update(block.content());
+        }
+        let result = hasher.finalize();
+        assert_eq!(result[..], README_HEX);
+    }
+
+    pub(crate) fn test_filesystem(sbi: &mut SimpleBufferedFileSystem) {
+        test_superblock_def(sbi);
+        test_filesystem_ilookup(sbi);
+        test_continous_iter(sbi);
+    }
+
+    #[test]
+    fn test_superblock_size() {
+        assert_eq!(core::mem::size_of::<SuperBlock>(), 128);
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock/file.rs b/fs/erofs/rust/erofs_sys/superblock/file.rs
new file mode 100644
index 000000000000..812a8046f0dc
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/superblock/file.rs
@@ -0,0 +1,114 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use self::operations::get_xattr_prefixes;
+
+use super::*;
+
+pub(crate) struct ImageFileSystem<B>
+// Only support standard file/device io. Not a continguous region of memory.
+where
+    B: FileBackend,
+{
+    backend: B,
+    prefixes: Vec<xattrs::Prefix>,
+    sb: SuperBlock,
+    device_info: DeviceInfo,
+}
+
+impl<I, B> FileSystem<I> for ImageFileSystem<B>
+where
+    B: FileBackend,
+    I: Inode,
+{
+    fn superblock(&self) -> &SuperBlock {
+        &self.sb
+    }
+    fn backend(&self) -> &dyn Backend {
+        &self.backend
+    }
+
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> Box<dyn BufferMapIter<'a> + 'b> {
+        heap_alloc(TempBufferMapIter::new(
+            &self.backend,
+            MapIter::new(self, inode, offset),
+        ))
+    }
+    fn continous_iter<'a>(
+        &'a self,
+        offset: Off,
+        len: Off,
+    ) -> Box<dyn ContinousBufferIter<'a> + 'a> {
+        heap_alloc(ContinuousTempBufferIter::new(&self.backend, offset, len))
+    }
+    fn xattr_prefixes(&self) -> &Vec<xattrs::Prefix> {
+        &self.prefixes
+    }
+    fn device_info(&self) -> &DeviceInfo {
+        &self.device_info
+    }
+}
+
+impl<T> ImageFileSystem<T>
+where
+    T: FileBackend,
+{
+    pub(crate) fn new(backend: T) -> Self {
+        let mut buf = SUPERBLOCK_EMPTY_BUF;
+        backend.fill(&mut buf, EROFS_SUPER_OFFSET).unwrap();
+        let sb: SuperBlock = buf.into();
+        let prefixes = get_xattr_prefixes(&sb, &backend);
+
+        let device_info = get_device_infos(&mut ContinuousTempBufferIter::new(
+            &backend,
+            sb.devt_slotoff as Off * 128,
+            sb.extra_devices as Off * 128,
+        ));
+
+        Self {
+            backend,
+            sb,
+            prefixes,
+            device_info,
+        }
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    extern crate alloc;
+    extern crate std;
+    use super::*;
+    use crate::inode::tests::*;
+    use crate::superblock::tests::*;
+    use crate::superblock::uncompressed::*;
+    use alloc::boxed::Box;
+    use std::collections::HashMap;
+    use std::fs::File;
+    use std::os::unix::fs::FileExt;
+
+    impl Source for File {
+        fn fill(&self, data: &mut [u8], offset: Off) -> SourceResult<u64> {
+            self.read_at(data, offset)
+                .map_or(Err(SourceError::Dummy), |size| Ok(size as u64))
+        }
+    }
+
+    impl FileSource for File {}
+
+    #[test]
+    fn test_uncompressed_img_filesystem() {
+        for file in load_fixtures() {
+            let mut sbi: SuperblockInfo<SimpleInode, HashMap<Nid, SimpleInode>> =
+                SuperblockInfo::new(
+                    Box::new(ImageFileSystem::new(UncompressedBackend::new(file))),
+                    HashMap::new(),
+                );
+            test_filesystem(&mut sbi);
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock/mem.rs b/fs/erofs/rust/erofs_sys/superblock/mem.rs
new file mode 100644
index 000000000000..c5bb5135dc85
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/superblock/mem.rs
@@ -0,0 +1,156 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use self::operations::get_xattr_prefixes;
+
+use super::*;
+
+// Memory Mapped Device/File so we need to have some external lifetime on the backend trait.
+// Note that we do not want the lifetime to infect the MemFileSystem which may have a impact on
+// the content iter below. Just use HRTB to dodge the borrow checker.
+
+pub(crate) struct MemFileSystem<T>
+where
+    T: for<'a> MemoryBackend<'a>,
+{
+    backend: T,
+    sb: SuperBlock,
+    prefixes: Vec<xattrs::Prefix>,
+    device_info: DeviceInfo,
+}
+
+impl<I, T> FileSystem<I> for MemFileSystem<T>
+where
+    T: for<'a> MemoryBackend<'a>,
+    I: Inode,
+{
+    fn superblock(&self) -> &SuperBlock {
+        &self.sb
+    }
+    fn backend(&self) -> &dyn Backend {
+        &self.backend
+    }
+
+    fn mapped_iter<'b, 'a: 'b>(
+        &'a self,
+        inode: &'b I,
+        offset: Off,
+    ) -> Box<dyn BufferMapIter<'a> + 'b> {
+        heap_alloc(RefMapIter::new(
+            &self.backend,
+            MapIter::new(self, inode, offset),
+        ))
+    }
+    fn continous_iter<'a>(
+        &'a self,
+        offset: Off,
+        len: Off,
+    ) -> Box<dyn ContinousBufferIter<'a> + 'a> {
+        heap_alloc(ContinuousRefIter::new(&self.backend, offset, len))
+    }
+    fn xattr_prefixes(&self) -> &Vec<xattrs::Prefix> {
+        &self.prefixes
+    }
+    fn device_info(&self) -> &DeviceInfo {
+        &self.device_info
+    }
+}
+
+impl<T> MemFileSystem<T>
+where
+    T: for<'a> MemoryBackend<'a>,
+{
+    pub(crate) fn new(backend: T) -> Self {
+        let mut buf = SUPERBLOCK_EMPTY_BUF;
+        backend.fill(&mut buf, EROFS_SUPER_OFFSET).unwrap();
+        let sb: SuperBlock = buf.into();
+        let prefixes = get_xattr_prefixes(&sb, &backend);
+        let device_info = get_device_infos(&mut ContinuousRefIter::new(
+            &backend,
+            sb.devt_slotoff as Off * 128,
+            sb.extra_devices as Off * 128,
+        ));
+        Self {
+            backend,
+            sb,
+            prefixes,
+            device_info,
+        }
+    }
+}
+
+#[cfg(test)]
+mod tests {
+    extern crate std;
+    use super::*;
+    use crate::data::RefBuffer;
+    use crate::inode::tests::*;
+    use crate::superblock::tests::*;
+    use crate::superblock::uncompressed::*;
+    use crate::superblock::PageSource;
+    use crate::Off;
+    use memmap2::MmapMut;
+    use std::collections::HashMap;
+
+    // Impl MmapMut to simulate a in-memory image/filesystem
+    impl Source for MmapMut {
+        fn fill(&self, data: &mut [u8], offset: Off) -> SourceResult<u64> {
+            self.as_buf(offset, data.len() as u64).map(|buf| {
+                let len = buf.content().len();
+                data[..len].clone_from_slice(buf.content());
+                len as Off
+            })
+        }
+    }
+
+    impl<'a> PageSource<'a> for MmapMut {
+        fn as_buf(&'a self, offset: crate::Off, len: crate::Off) -> SourceResult<RefBuffer<'a>> {
+            let pa = PageAddress::from(offset);
+            if pa.pg_off + len > EROFS_PAGE_SZ {
+                Err(SourceError::OutBound)
+            } else {
+                let rlen = len.min(self.len() as u64 - offset);
+                let buf =
+                    &self[(pa.page as usize)..self.len().min((pa.page + EROFS_PAGE_SZ) as usize)];
+                Ok(RefBuffer::new(
+                    buf,
+                    pa.pg_off as usize,
+                    rlen as usize,
+                    |_| {},
+                ))
+            }
+        }
+
+        fn as_buf_mut(&'a mut self, offset: Off, len: Off) -> SourceResult<RefBufferMut<'a>> {
+            let pa = PageAddress::from(offset);
+            let maxsize = self.len();
+            if pa.pg_off + len > EROFS_PAGE_SZ {
+                Err(SourceError::OutBound)
+            } else {
+                let rlen = len.min(self.len() as u64 - offset);
+                let buf =
+                    &mut self[(pa.page as usize)..maxsize.min((pa.page + EROFS_PAGE_SZ) as usize)];
+                Ok(RefBufferMut::new(
+                    buf,
+                    pa.pg_off as usize,
+                    rlen as usize,
+                    |_| {},
+                ))
+            }
+        }
+    }
+
+    #[test]
+    fn test_uncompressed_mmap_filesystem() {
+        for file in load_fixtures() {
+            let mut sbi: SuperblockInfo<SimpleInode, HashMap<Nid, SimpleInode>> =
+                SuperblockInfo::new(
+                    Box::new(MemFileSystem::new(UncompressedBackend::new(unsafe {
+                        MmapMut::map_mut(&file).unwrap()
+                    }))),
+                    HashMap::new(),
+                );
+            test_filesystem(&mut sbi);
+        }
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/xattrs.rs b/fs/erofs/rust/erofs_sys/xattrs.rs
new file mode 100644
index 000000000000..26912c597560
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/xattrs.rs
@@ -0,0 +1,175 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-only
+
+use super::data::*;
+use super::*;
+
+use alloc::vec::Vec;
+
+/// The header of the xattr entry index.
+/// This is used to describe the superblock's xattrs collection.
+#[derive(Clone, Copy)]
+#[repr(C)]
+pub(crate) struct DiskEntryIndexHeader {
+    pub(crate) name_filter: u32,
+    pub(crate) shared_count: u8,
+    pub(crate) reserved: [u8; 7],
+}
+
+impl From<[u8; 12]> for DiskEntryIndexHeader {
+    fn from(value: [u8; 12]) -> Self {
+        unsafe { core::mem::transmute(value) }
+    }
+}
+
+pub(crate) const XATTRS_HEADER_SIZE: u64 = core::mem::size_of::<DiskEntryIndexHeader>() as u64;
+
+/// Represented as a inmemory memory entry index header used by SuperBlockInfo.
+pub(crate) struct MemEntryIndexHeader {
+    pub(crate) name_filter: u32,
+    pub(crate) shared_indexes: Vec<u32>,
+}
+
+/// This is on-disk representation of xattrs entry header.
+/// This is used to describe one extended attribute.
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct EntryHeader {
+    pub(crate) name_len: u8,
+    pub(crate) name_index: u8,
+    pub(crate) value_len: u16,
+}
+
+impl From<[u8; 4]> for EntryHeader {
+    fn from(value: [u8; 4]) -> Self {
+        unsafe { core::mem::transmute(value) }
+    }
+}
+
+/// This is real index data of the xattrs entry index.
+pub(crate) struct Prefix(pub(crate) Vec<u8>);
+
+impl Prefix {
+    fn index(&self) -> u8 {
+        self.0[0]
+    }
+    fn name(&self) -> &[u8] {
+        &self.0[1..]
+    }
+}
+
+pub(crate) trait XAttrsEntryProvider {
+    fn get_entry_header(&mut self) -> EntryHeader;
+    fn get_xattr_name(&mut self, pfs: &[Prefix], header: &EntryHeader, buffer: &mut [u8]) -> usize;
+    fn get_xattr_value(
+        &mut self,
+        pfs: &[Prefix],
+        header: &EntryHeader,
+        name: &[u8],
+        index: u32,
+        buffer: &mut [u8],
+    ) -> bool;
+    fn fill_xattr_value(&mut self, data: &mut [u8]);
+}
+
+pub(crate) const EROFS_XATTR_LONG_PREFIX: u8 = 0x80;
+pub(crate) const EROFS_XATTR_LONG_MASK: u8 = 0x7f;
+
+#[allow(unused_macros)]
+macro_rules! static_cstr {
+    ($l:expr) => {
+        unsafe { ::core::ffi::CStr::from_bytes_with_nul_unchecked(concat!($l, "\0").as_bytes()) }
+    };
+}
+
+/// Supported xattr prefixes
+pub(crate) const EROFS_XATTRS_PREFIXS: [(&str, usize); 7] = [
+    ("", 0),
+    ("user.", 5),
+    ("system.posix_acl_access", 24),
+    ("system.posix_acl_default", 25),
+    ("trusted.", 8),
+    ("", 0),
+    ("security.", 9),
+];
+
+/// An iterator to read xattrs by comparing the entry's name one by one and reads its value
+/// correspondingly.
+impl<'a> XAttrsEntryProvider for SkippableContinousIter<'a> {
+    fn get_entry_header(&mut self) -> EntryHeader {
+        let mut buf: [u8; 4] = [0; 4];
+        self.read(&mut buf);
+        EntryHeader::from(buf)
+    }
+
+    fn get_xattr_name(&mut self, pfs: &[Prefix], header: &EntryHeader, buffer: &mut [u8]) -> usize {
+        let n_len = if header.name_index & EROFS_XATTR_LONG_PREFIX != 0 {
+            let pf = pfs
+                .get((header.name_index & EROFS_XATTR_LONG_MASK) as usize)
+                .unwrap();
+            let pf_index = pf.index();
+            let (prefix, p_len) = EROFS_XATTRS_PREFIXS[pf_index as usize];
+            buffer[..p_len].copy_from_slice(&prefix.as_bytes()[..p_len]);
+            buffer[p_len..pf.name().len() + p_len].copy_from_slice(pf.name());
+            p_len + pf.name().len()
+        } else {
+            let (prefix, p_len) = EROFS_XATTRS_PREFIXS[header.name_index as usize];
+            buffer[..p_len].copy_from_slice(&prefix.as_bytes()[..p_len]);
+            p_len
+        };
+        self.read(&mut buffer[n_len..n_len + header.name_len as usize]);
+        n_len + header.name_len as usize
+    }
+    fn get_xattr_value(
+        &mut self,
+        pfs: &[Prefix],
+        header: &EntryHeader,
+        name: &[u8],
+        index: u32,
+        buffer: &mut [u8],
+    ) -> bool {
+        let n_len = name.len();
+        let skip_off = header.name_len as Off + header.value_len as Off;
+        let n_off = if header.name_index & EROFS_XATTR_LONG_PREFIX != 0 {
+            let infix_index = (header.name_index & EROFS_XATTR_LONG_MASK) as usize;
+            if infix_index >= pfs.len() {
+                return false;
+            }
+
+            let pf = pfs.get(infix_index).unwrap();
+
+            let infix_len = pf.name().len();
+
+            if index != pf.index() as u32 || n_len != infix_len + header.name_len as usize {
+                return false;
+            }
+            if name[..infix_len] != *pf.name() {
+                return false;
+            }
+
+            infix_len
+        } else {
+            if header.name_index as u32 != index || header.name_len as usize != name.len() {
+                return false;
+            }
+            0
+        };
+        match self.try_cmp(&name[n_off..]) {
+            Ok(()) => {
+                self.fill_xattr_value(&mut buffer[..header.value_len as usize]);
+                true
+            }
+            Err(off) => {
+                self.skip(skip_off - off as Off);
+                false
+            }
+        }
+    }
+
+    fn fill_xattr_value(&mut self, data: &mut [u8]) {
+        self.read(data);
+    }
+}
+
+#[cfg(test)]
+pub(crate) mod tests {}
-- 
2.45.2

