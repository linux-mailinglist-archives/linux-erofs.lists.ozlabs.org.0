Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7950C97A32B
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494982;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Arsc4BUQGGwTKC1v2HoQt9WsuSmTEVqLTAvBcwuJHYfHr1YUS1T2qVZt77WSySelg
	 6l3KJAQWkV6dndvwvEBT8SBCJK/XM69EeSC4uL41KgXoMadFqhpXBSnx4+4u8a8+hv
	 29lm0uLCQHKj3FwPBp3aTFRX0M98rsqc9AacNpFNLwEhA9/AYp2UIU2aGW97IyVe8k
	 3P20lYC+qQ5t8pTC9cstZGgmXJNN9f1WZCeeN61DA9Wux7f7sGUMoOy47vT+N2crI4
	 DF7LkY02CEQ58OCPYOrUHjF16dzklOPerthRUEJIdBAsHc6hcMu2UI40duNC5revJw
	 Yg9p9RRV4DV8Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfZ0Qh4z3cDt
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494979;
	cv=none; b=AKPSAtPn4ira/NY8UPH9Y+pUnlXmWZr9mV3gYq4Bsr8g7XljrclhQ+63b17eljmvWQU0vOCTtLjgWIxaDFOL4tiakNojHJvPWPFVrNRn0502W34argqRvOcgCQhsGvhZQ6Di8ZuRaV/9DtFpvBmr3OADASVjTeczHJlEvYQYUWkIQ87kqUNH2wjROCxtizuPGjceH9uz9tTy0/+1bqlPhCiej++W8Y/8jLM/3/3RHptMS7dTZ8x1vk7TNuzrZEL886773t58u4IItuEuWvbfoIExwYgrA9Ve21BqPCcvdIpf4rv2kErH3iG00fTgZqPudwWV8mXpjXSyZu2LhkMXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494979; c=relaxed/relaxed;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdughXY4cQNWbXvrgT9MmcJNDlgWVzhU/BW1gXn8FtZtfcx1Kcxm+OjgLB6MEJnjYUEemSX8IW//YKmducfFaPA7EmZeAtoJfsotSVkzk9EAaqYFYb9XBCBwvLDllGPzRAH/dGPSM9A2BLQO7NBcB6brv4CoOJeTAaC3GSlLBqA4BuCQHAL7xHcG5funJQ5fnFc10ToQe44Dd/ber8+L5Wi0srpqHeScP6632c/5uqSDMnbhO+q3LlQcFZAomyAgOqOW+aIc05DTqy+A/ip+Y0Y9a2ZV688eykvVom/zFyUqlsJPnqpumuK2MXaePI/N51RXXFq/0mdxZh4svErKyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=CCH/7Wpl; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=CCH/7Wpl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfW3PJNz2yTs
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:19 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A972E6997D;
	Mon, 16 Sep 2024 09:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494977; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	b=CCH/7WplQihI8IQSOeM+qSyheqlKc/+3ge+BVwwr3F5KemwNkoKCxNMRnQ5KEjxI4pHhEG
	Yp3l0ZbMtH6z/O9zF8Rc26nGuHUWn8bx19wkKPrt4BeXbonNQrPlz2DFpN7Q9YItP2rbj2
	q0bKdiKpmPkNoSNXo1wZlae5WbZLiFVfWLSkweVgwMI/m6ZJ2aDueAO/IUkcT+bEfDhNNG
	iAC0MfyYbPOKQX/767ZGpqgr2Cvkeb9Hykj33qkOFFhdAmX4ff24BsCfN/MMT1r1O/oCb5
	Abalb/CnbSKVm3eG06+rw6hM/nYxXm9ujXXKb34nWe2ZoiH2mDwYqR2uPTjBcQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 09/24] erofs: add continuous iterators in Rust
Date: Mon, 16 Sep 2024 21:55:26 +0800
Message-ID: <20240916135541.98096-10-toolmanp@tlmp.cc>
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

This patch adds a special iterator that is capable of iterating over a
memory region in the granularity of a common page. This can be later
used to read device buffer or fast symlink.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/data.rs               |  2 +
 fs/erofs/rust/erofs_sys/data/raw_iters.rs     |  6 ++
 .../rust/erofs_sys/data/raw_iters/ref_iter.rs | 68 +++++++++++++++++++
 .../rust/erofs_sys/data/raw_iters/traits.rs   | 13 ++++
 4 files changed, 89 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs

diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
index 284c8b1f3bd4..483f3204ce42 100644
--- a/fs/erofs/rust/erofs_sys/data.rs
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -1,6 +1,8 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 pub(crate) mod backends;
+pub(crate) mod raw_iters;
+use super::superblock::*;
 use super::*;
 
 /// Represent some sort of generic data source. This cound be file, memory or even network.
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters.rs b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
new file mode 100644
index 000000000000..8f3bd250d252
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
@@ -0,0 +1,6 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+pub(crate) mod ref_iter;
+mod traits;
+pub(crate) use traits::*;
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
new file mode 100644
index 000000000000..5aa2b7f44f3d
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
@@ -0,0 +1,68 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::super::*;
+use super::*;
+
+/// Continous Ref Buffer Iterator which iterates over a range of disk addresses within the
+/// the temp block size. Since the temp block is always the same size as page and it will not
+/// overflow.
+pub(crate) struct ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    sb: &'a SuperBlock,
+    backend: &'a B,
+    offset: Off,
+    len: Off,
+}
+
+impl<'a, B> ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    pub(crate) fn new(sb: &'a SuperBlock, backend: &'a B, offset: Off, len: Off) -> Self {
+        Self {
+            sb,
+            backend,
+            offset,
+            len,
+        }
+    }
+}
+
+impl<'a, B> Iterator for ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    type Item = PosixResult<RefBuffer<'a>>;
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.len == 0 {
+            return None;
+        }
+        let accessor = self.sb.blk_access(self.offset);
+        let len = accessor.len.min(self.len);
+        let result: Option<Self::Item> = self.backend.as_buf(self.offset, len).map_or_else(
+            |e| Some(Err(e)),
+            |buf| {
+                self.offset += len;
+                self.len -= len;
+                Some(Ok(buf))
+            },
+        );
+        result
+    }
+}
+
+impl<'a, B> ContinuousBufferIter<'a> for ContinuousRefIter<'a, B>
+where
+    B: Backend,
+{
+    fn advance_off(&mut self, offset: Off) {
+        self.offset += offset;
+        self.len -= offset
+    }
+    fn eof(&self) -> bool {
+        self.len == 0
+    }
+}
diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
new file mode 100644
index 000000000000..90b6a51658a9
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
@@ -0,0 +1,13 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::super::*;
+
+/// Represents a basic iterator over a range of bytes from data backends.
+/// Note that this is skippable and can be used to move the iterator's cursor forward.
+pub(crate) trait ContinuousBufferIter<'a>:
+    Iterator<Item = PosixResult<RefBuffer<'a>>>
+{
+    fn advance_off(&mut self, offset: Off);
+    fn eof(&self) -> bool;
+}
-- 
2.46.0

