Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3065597A33C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495019;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=g4cvKw8TcqoLw0NYXrFnRJPXCV27VtJj9z0Q0gEUxlC2TN5wpjNdUqWhFoarxj6Nx
	 szYUuzdqT1eeUsC6Du4I3qN+R+cf0go/nFvdWTYd3K3Q9xd3pIN8locuN7V/+bfO71
	 ersvWRedV2HHQvbh8M35WRHAg6l8cEWAXcrh2U65STBr7uPe9da/vLxDd25KijxnnQ
	 6je5Kz3Kh2yB5t8600kJwW0K+dZORa2ziZVHONHNkjuj4pSJIeE0Da5WmtCvXvpfLR
	 D2Z2h5K2et653UqCPZJnNV8hdB3pIjOGqW8BbFjorJP2PVbaT5/ki8OCkeBancFjnM
	 +w8M6+H6MpsFg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgH516Sz303K
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495017;
	cv=none; b=bl+xqaHwzHLcg87A75ubr92q2mFmDfnHBULEOLed4vKAASERtNsT2ls5Y+fRwbtKEHlnCs0sqG9XtgWfiRDwI+I+ljco6IRLVQyplK+zvkDtb6g4S+e51kwsjfUVfAPwMqTrUL705OKTBT9xl/em9jey8NGlDxK3e4cF6ghGX0WWnyzCY/cg8QQaB++rPd2JaONxKDukxHMh/kVyCIh0mp75MEra0vnSMxasFr0i6TM1udv0GGI/tG758XXm8zfMAf8f/VQkL/dwpdoCcgslFksHgfzG74nj2aPJAqJ49KY4uN2cSGDPQYMcu/LKckqsNij/p4+Kp5jxRdxeNdf4OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495017; c=relaxed/relaxed;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cP3HbbgW8KnrSaX1vu4RPiBRGtGQ+BN9Gzilzs6RCXU2fTRTFgu7yK1zOEosdm6aU8ll/scwlm74VpFIXLBxq83XY4R8LHro9HDQt1M9On0JXKdke53Z1K9SDWHklfM/0no5Fgtq1eeWvauedmuoeHEGgTWNfnfJgL2lytEAWHHIlKKRmqCyI7bogSgX05Lqe6Dyk14WsKtJcKieYLBQpDKDk5D5r6m6lvfMfCkC5OQXwewdHGlDKq+fid3djdYqaCogAha/0k3TW/htcRcKV47a3GEsgiLfUV+RQzpgNOY7TlwRQI2H4kgNV72h3CsQvhzJiYcp7SpcsYrRFsg1nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=OI84jiwE; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=OI84jiwE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgF4z4hz30CL
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:57 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C2F7F6984E;
	Mon, 16 Sep 2024 09:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495016; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=CeM2RxQ3ayEheLUMCn9fl9h9UhYePHokORV1b9tMe8Y=;
	b=OI84jiwEAZ7ZEOLluM+fIqX1Srps1RtOtX3VqfVlm4NGXwfbaD373VS/xNCdDmM/hiGYDZ
	OHX/N0Vj2xsYcLKNElDkLkxxhMbOocc0YXu8NiK8WHl784LfdiZ3VeREs4qZgrGs6gcrCr
	5SQ4cQOXbMAAWxSGTv6DB9kQD61+qf/9K9eBUDSMatJxLDWSaO4VsSF76v9Rj5+M+tvaEZ
	uvJYeTYhvh+ddlt/XjZ447m9WCXe1xX/gZKjvoJKGVc4+fL9qq5n35kSNdvH/dj/Xrf2Ni
	xyAHcPUesRUNe95B9viv+6x83gLqH4DrrdC8RgHWYKqQZy13ntEZzFiynr/o2g==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 09/24] erofs: add continuous iterators in Rust
Date: Mon, 16 Sep 2024 21:56:19 +0800
Message-ID: <20240916135634.98554-10-toolmanp@tlmp.cc>
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

