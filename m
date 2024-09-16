Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8699697A32E
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494979;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jnMXRsMRPtiT1ZWcXZr8tNYMnmulEEkEVuwzO52loO8QoAGC5hWS56N8ACSX6o8uu
	 GBHwdGcR33ie1UNO9Ufn9N4TCA4wRN5D8KODVhZRWZQLaoPV4hsc8VGx2GWj2ut611
	 tpCO9FVIS85eQFsYS/h3u1xziaISOsRNEGwYrl6Oa1RhY7K9PclMk9AEB44CGo9mA2
	 KpVLChtvpEWVBpy6U7Zpj5UfAKl+eQXz3KgrYwl4pSQw3te1gONnPg99BLDMAHxzNB
	 uHrDSgVKhBkdInV+oAYib4o+Cgtmq8iPvtINWyJ1uhZdeI0OzCjU7lJMx2zo/pVJXp
	 e8GcJUxlhDF3A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfW67rhz302N
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494977;
	cv=none; b=g0M5diMciayDA5a3AFAy297FV0UFqqJtj+UWm/nKOFWzW++l3L3IM0+aPnJ64B0c66bfGSpPDgX5vp/3uicxpxtimcAdZRwOhvn6Tz3mGj/VZL+01ZaTuqshNWUUFkrWcE2n1KdzA/lRsX1i3602Eir2cQ4eZclG0QNTV6NhJmoIZm5Q8XpDU1jY4S0dJK0E5hqTGTZ0SviCCWp5YSUfhKW0Uhq7QsduRUZisDxBAV81Oy9oP26jGp2OpcVi1hfStIPRwX8S4rshjmJsWCXAGKMsxukiVxNLJApD5vjqMKUMviDavmIbE6GEvuEPmlEbeEXogElh2s5f13Uvw1yseg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494977; c=relaxed/relaxed;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxdYGV8cu+yh1ZfJSj1OYSGii7U9bSi5OOhmNAQVLrjzA0e4siGQAURggsy/L/qyRsbEbktR1QXxobnFtU0OLTUpz8GGdC8+bMfxLT4SoHWScGh3NIJvkTWQg9DPLIWqkvvFCPN39+VcAd50kBlCH+phT0T/jyC2s9iwWTyFi4C4UFWoKVT2hr68XdT4DKAblAPET68NkBmYmvUcdvlskmU4m0Oh/8FfIQXW/ot/nyoRFSl5CRVhp7DzagnfDaQdXKFKwrxbqN/Iux3CkCwnqSi7dJ29IPUOE9LvoZ9zpi3WCqoxEsVr7qVmSOfp3iz2/+sTO2dElEiFnWLOVi74Aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=lWj1RcoQ; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=lWj1RcoQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfS6HRtz2yxN
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:16 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D8A26997B;
	Mon, 16 Sep 2024 09:56:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494973; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RkMMOXQTsmanQe52UgGZbvf6dLNC+ICFQfOIzTuSzMo=;
	b=lWj1RcoQuWBLQcg52cSVUJlekfGYmj3eyjhUX1zRLg5iPFQua2BXf+5dlwA0+Lc8jXT9+y
	mhEoRsnJaaH9X7lCI38wRpiDni2rp/BQJ5lwFewaK/pvR610KrpNG/NUkgNhKcmNYCJmAp
	b1pfLeNHdJMtbkMKxyFkG6Rqxab08HRTEfs423n/2xiL/Zoa/un+P7GvIXjqp/YPsL1b35
	+0j+IVX4g+2Xdb3m3fIQytqD5IHifDEru+0sCOsNgHPAmP2NBWUf0vUkqvFNw3paqDEIKs
	FNQAp23to/z/F9G43nJebIYU2LBl0ZXgWAeJaOH/rF0yRVy7SO6iIz8jfifnAw==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 07/24] erofs: add data abstraction in Rust
Date: Mon, 16 Sep 2024 21:55:24 +0800
Message-ID: <20240916135541.98096-8-toolmanp@tlmp.cc>
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

