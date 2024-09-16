Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D0E97A326
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494975;
	bh=eYDsY4wqAO9NUWwayzJIYghS8a27BSxppsolaWA5lxs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=VyXK7avv1s7QG16FSJ0aYFLLPQoRigMS6/3/iHz5li57hGszp/YO74Q1gPxv8iwfR
	 91stmcoBxo6I190TZOjd/ikekj1kTwREAPzg+EO3mguaFMkMzNvd3tMslIMDb45Yko
	 xq60qIzJzCtfwGa83YB3QXcnrcbZphjujCflq0XejXxB4eRFb3FKlQl1LaF+Oph0G7
	 u0h48+vOFHhuNdGpPlN9nCsWmujCrsNyWm2OnKh4usrrKrN5eAJ6zRf8MYt6DTzMFA
	 2m4a8lQrdKDNJ4fWmKmPqpZUU72IdIwWmCwgdep/SyuLBcEdDVI7TxVTfP+AT22jG1
	 02Wt8wQVllArg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfR6YFzz3cCn
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494970;
	cv=none; b=Y/yR+bVa2fP1gDwrMH6h5zYreuo+hs+oZ8YRxq4Iy2B9AWnwb2n3RHtWuzjGkQLFV0TKdO/QfcH9tcffrvqNqgLKGTvuVEFZhOn/4EyR6kEAo8e7N89H7rRJrRUQ7WDKGCDIa4qfKwPkLndwhHATEHxUM6TaYp+w0ym2Jxc3WwclCBgCf7SdEaIVC3wxWkfBshm4k72H7rYqn04t/fAYYmyK+3YbYrTPIWAHIaqncVw+pe5Tw+sWbv3L2TRGxeiCWq8sxLiUm3SvQ2A5QhwKhBaE+l1AxoL5iW7O2jOM5tLXnXJzXMEi8DAf8YCXj91L5kI5cyRZ7rFIQEAdbJn8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494970; c=relaxed/relaxed;
	bh=eYDsY4wqAO9NUWwayzJIYghS8a27BSxppsolaWA5lxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDRQaBJSIj9olW8lHNmfeQ8a4rCA7O9n5ma8JyQctXCL4sniFHqkl5esOyURgqwa9DaHbe9pMr60ETbGY2OkSzh/2dt5fy4+VUB3n75xGH15QbW76B0Ak0U81fzP9gWEeSyGm2RpSbUrYBhqVv59gvznl10kwIPNRiLW6WQzaOsPvLJsCDbladuZFvknVrVGXCjUJtIMzMnlMPY+YHVVlQJ0HRBUhqdbEUfE9sEYhN2QY3OmMRXm9LwRVat1AWmqltxW6H8rY9lobty/37PpFNmDYIz8qQSvRr9HdSqYKhXGa9KZsZ9oxAu0KJyrX5faS9s5EoFmBbPpKtSqZDyZvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gZEWWmKy; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gZEWWmKy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfK70fKz2yQl
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:09 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 496286997D;
	Mon, 16 Sep 2024 09:56:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494968; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eYDsY4wqAO9NUWwayzJIYghS8a27BSxppsolaWA5lxs=;
	b=gZEWWmKyv5QhK9EAxaWSqUbJLLmLD9oYn+CDX1Z7R21OyTyIDmytGlCA7fvRoknPzCqW+u
	cR1ccN/L37ejFpGKu/vjzNjS89YEEYtQRKqVigjNM6UJeM5EC0b/xWOcT5Kxm2DRKSHmST
	/IpN+xZWU407r+5FXBqYC2REg8E+dgD6zfXcPEahSw7uU2Yce7slicSuygg9FCs/WbO5L5
	yYWesHS5Eub1vIzjfn63G7/8+ydliWreaxHZA8e1Id284Au29KdeE4Nb6gY7sCFF4wnkvs
	HddeuqSWxrgJptfT2n4N1bUqMxc5omHT9dFZ1x7u7pGN2rDU26ZekgO4E67duQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 04/24] erofs: add xattrs data structure in Rust
Date: Mon, 16 Sep 2024 21:55:21 +0800
Message-ID: <20240916135541.98096-5-toolmanp@tlmp.cc>
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

This patch introduces on-disk and runtime data structure of Extended
Attributes implementation in erofs_sys crate. This will be later used to
implement the op handler.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs        |  12 +++
 fs/erofs/rust/erofs_sys/xattrs.rs | 124 ++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/xattrs.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 2bd1381da5ab..6f3c12665ed6 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -25,4 +25,16 @@
 
 pub(crate) mod errnos;
 pub(crate) mod superblock;
+pub(crate) mod xattrs;
 pub(crate) use errnos::Errno;
+
+/// Helper macro to round up or down a number.
+#[macro_export]
+macro_rules! round {
+    (UP, $x: expr, $y: expr) => {
+        ($x + $y - 1) / $y * $y
+    };
+    (DOWN, $x: expr, $y: expr) => {
+        ($x / $y) * $y
+    };
+}
diff --git a/fs/erofs/rust/erofs_sys/xattrs.rs b/fs/erofs/rust/erofs_sys/xattrs.rs
new file mode 100644
index 000000000000..d1a110ef10dd
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/xattrs.rs
@@ -0,0 +1,124 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use alloc::vec::Vec;
+
+/// The header of the xattr entry index.
+/// This is used to describe the superblock's xattrs collection.
+#[derive(Clone, Copy)]
+#[repr(C)]
+pub(crate) struct XAttrSharedEntrySummary {
+    pub(crate) name_filter: u32,
+    pub(crate) shared_count: u8,
+    pub(crate) reserved: [u8; 7],
+}
+
+impl From<[u8; 12]> for XAttrSharedEntrySummary {
+    fn from(value: [u8; 12]) -> Self {
+        Self {
+            name_filter: u32::from_le_bytes([value[0], value[1], value[2], value[3]]),
+            shared_count: value[4],
+            reserved: value[5..12].try_into().unwrap(),
+        }
+    }
+}
+
+pub(crate) const XATTR_ENTRY_SUMMARY_BUF: [u8; 12] = [0u8; 12];
+
+/// Represented as a inmemory memory entry index header used by SuperBlockInfo.
+pub(crate) struct XAttrSharedEntries {
+    pub(crate) name_filter: u32,
+    pub(crate) shared_indexes: Vec<u32>,
+}
+
+/// Represents the name index for infixes or prefixes.
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct XattrNameIndex(u8);
+
+impl core::cmp::PartialEq<u8> for XattrNameIndex {
+    fn eq(&self, other: &u8) -> bool {
+        if self.0 & EROFS_XATTR_LONG_PREFIX != 0 {
+            self.0 & EROFS_XATTR_LONG_MASK == *other
+        } else {
+            self.0 == *other
+        }
+    }
+}
+
+impl XattrNameIndex {
+    pub(crate) fn is_long(&self) -> bool {
+        self.0 & EROFS_XATTR_LONG_PREFIX != 0
+    }
+}
+
+impl From<u8> for XattrNameIndex {
+    fn from(value: u8) -> Self {
+        Self(value)
+    }
+}
+
+#[allow(clippy::from_over_into)]
+impl Into<usize> for XattrNameIndex {
+    fn into(self) -> usize {
+        if self.0 & EROFS_XATTR_LONG_PREFIX != 0 {
+            (self.0 & EROFS_XATTR_LONG_MASK) as usize
+        } else {
+            self.0 as usize
+        }
+    }
+}
+
+/// This is on-disk representation of xattrs entry header.
+/// This is used to describe one extended attribute.
+#[repr(C)]
+#[derive(Clone, Copy)]
+pub(crate) struct XAttrEntryHeader {
+    pub(crate) suffix_len: u8,
+    pub(crate) name_index: XattrNameIndex,
+    pub(crate) value_len: u16,
+}
+
+impl From<[u8; 4]> for XAttrEntryHeader {
+    fn from(value: [u8; 4]) -> Self {
+        Self {
+            suffix_len: value[0],
+            name_index: value[1].into(),
+            value_len: u16::from_le_bytes(value[2..4].try_into().unwrap()),
+        }
+    }
+}
+
+/// Xattr Common Infix holds the prefix index in the first byte and all the common infix data in
+/// the rest of the bytes.
+pub(crate) struct XAttrInfix(pub(crate) Vec<u8>);
+
+impl XAttrInfix {
+    fn prefix_index(&self) -> u8 {
+        self.0[0]
+    }
+    fn name(&self) -> &[u8] {
+        &self.0[1..]
+    }
+}
+
+pub(crate) const EROFS_XATTR_LONG_PREFIX: u8 = 0x80;
+pub(crate) const EROFS_XATTR_LONG_MASK: u8 = EROFS_XATTR_LONG_PREFIX - 1;
+
+/// Supported xattr prefixes
+pub(crate) const EROFS_XATTRS_PREFIXS: [&[u8]; 7] = [
+    b"",
+    b"user.",
+    b"system.posix_acl_access",
+    b"system.posix_acl_default",
+    b"trusted.",
+    b"",
+    b"security.",
+];
+
+/// Represents the value of an xattr entry or the size of it if the buffer is present in the query.
+#[derive(Debug)]
+pub(crate) enum XAttrValue {
+    Buffer(usize),
+    Vec(Vec<u8>),
+}
-- 
2.46.0

