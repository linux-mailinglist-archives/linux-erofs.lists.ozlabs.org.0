Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E3597A33A
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495017;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=YPf/VyLTBr9XQQ1VqDDK20pYB7lgm2NMooBc6pr+vs4Nrve3sELJjIgzhOaU1offG
	 YgdiMVdlvf8efxCWUWREf1KKgylIupvmWN4XN0o1q2yG/CX9mMtwoCkwQhhreFn38N
	 8hlB5tsdZl2mRTjYAbIyN+pxSZ7nPgx0gcXZkyQd+nLw5nQCiyVKPlWePSPZJtEzQ+
	 /dFVGGecq4m8LLiA3MjkdummpMDnz77iQQftXZKXglf8w2Kzow8NMpjRyiinzyl0Iy
	 EZ60RyFdHhTHrtTlexBdFrT/HCqaRqI3x5eIQcWvj6vvV5OrPhY55NxeyMam+HGf2N
	 kXjLhD3FC7yiQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgF3W6mz2ywM
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495015;
	cv=none; b=kvcCux6lK+om48+lmd+BHCOFYBtMY83e+F+V94nQwJVlEZaqh3q145evFTWXmjUiGkkHPjzXMT/i9XEt//kor0/vH4tf+SGXOuE3u9vBj5LA7FXiIZTxeGHIQlTu5bnxxzyHuY3fAm7/2giDDwv9rZiOdlegithLFEMy74k3D0+XWvRorTy9fVVB9xN9JluwfhafjEnm4/BIfbCvZN5H8hkpIBT5Tqlzjf7RL451rVkM3Qj2Awko4NCypECY5TjHAQn2ztiSyO5D07zcGyQrY54c/zLrTT4HEqHohKHRFjX6zjp5E1tLPl4VsZJr50Z4WewESE7O4SaMZC7Ss9L/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495015; c=relaxed/relaxed;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XOPmVUlCLr2Kq1jfx7Zfteyjn0eiYqrP5LP7EW7ifcTnsPqzaFRtdxQ/3Wbzc6GEf0stB/6IiJdzVuWv0neJUF27D3+Nh9kodHc+VtjPHf7mRzCDLjwaacdseT1a1917Uzlh7uBHeUMY731xTow18p+bG83ENhBUn6CJmH2b2U/LFLQ2ycEOuSu2OfZbQ9qjBV5N12uQUOr3mqEnMhvmY4d3lybuVXpRZBGGluclsbXzOofCKAPLePjyv7+z1GNP5AHPv/rADrPXxV89DMilJeX6i4M5zVhdOTGM5grVgn3rUJQFHlXqSJ7KpiCp9R7VJhg0lh4pgxqigrF9QvxZ5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=LAMjNb0+; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=LAMjNb0+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgB65jKz2yVX
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:54 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE5A469845;
	Mon, 16 Sep 2024 09:56:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495012; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	b=LAMjNb0+UX4m/k3RsK6wT8HZizF4XRS4pWMkT3XIpMeyZODYVcCr/cX08ee6ki7sDofY8K
	wKyFuPiNDpIQv6dZXjCjd5/Mgb49MBfsF8oeaD7EpIq9Pk56a8U9P8wq47/FNco/Q4rNMC
	gayBmAMNRRRiqDIDvPo8PkkGYrkJ2mK0SilBw3emy2ULWn07fEFQE4vAxkahSmLGK37N0o
	8nswnBd+Oe/o8El8ukDg+Xy2DL1Nb7CMMly5UVuoHsol4D4Qce6LsbTd1/07PST8V3e2K9
	OYrMX0k7gIOgqGTpau4Pb4C0vsm56chcwnIDNyJs7NLLD/lHWXEq+52xoKY2ww==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 07/24] erofs: add data abstraction in Rust
Date: Mon, 16 Sep 2024 21:56:17 +0800
Message-ID: <20240916135634.98554-8-toolmanp@tlmp.cc>
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

Introduce Buffer, Source, Backend traits.

Implement Uncompressed Backend and RefBuffer to be
used in future data operations.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs                    |  1 +
 fs/erofs/rust/erofs_sys/data.rs               | 62 +++++++++++++++++++
 fs/erofs/rust/erofs_sys/data/backends.rs      |  4 ++
 .../erofs_sys/data/backends/uncompressed.rs   | 39 ++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/data.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index c6fd7f78ac97..8cca2cd9b75f 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -24,6 +24,7 @@
 pub(crate) type PosixResult<T> = Result<T, Errno>;
 
 pub(crate) mod alloc_helper;
+pub(crate) mod data;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
new file mode 100644
index 000000000000..284c8b1f3bd4
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -0,0 +1,62 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+pub(crate) mod backends;
+use super::*;
+
+/// Represent some sort of generic data source. This cound be file, memory or even network.
+/// Note that users should never use this directly please use backends instead.
+pub(crate) trait Source {
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64>;
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>>;
+}
+
+/// Represents a generic data access backend that is backed by some sort of data source.
+/// This often has temporary buffers to decompress the data from the data source.
+/// The method signatures are the same as those of the Source trait.
+pub(crate) trait Backend {
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64>;
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>>;
+}
+
+/// Represents a buffer trait which can yield its internal reference or be casted as an iterator of
+/// DirEntries.
+pub(crate) trait Buffer {
+    fn content(&self) -> &[u8];
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
diff --git a/fs/erofs/rust/erofs_sys/data/backends.rs b/fs/erofs/rust/erofs_sys/data/backends.rs
new file mode 100644
index 000000000000..3249f1af8be7
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/backends.rs
@@ -0,0 +1,4 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+pub(crate) mod uncompressed;
diff --git a/fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs b/fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs
new file mode 100644
index 000000000000..c1b1a60258f8
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs
@@ -0,0 +1,39 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::super::*;
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
+    fn fill(&self, data: &mut [u8], offset: Off) -> PosixResult<u64> {
+        self.source.fill(data, offset)
+    }
+
+    fn as_buf<'a>(&'a self, offset: Off, len: Off) -> PosixResult<RefBuffer<'a>> {
+        self.source.as_buf(offset, len)
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
-- 
2.46.0

