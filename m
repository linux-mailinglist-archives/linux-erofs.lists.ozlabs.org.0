Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AF79897A338
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495013;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=MLTzuHMBXlE1FSXi6vqMJ8hnA+plD8mBRkLJdS+uWsOhMQ/JfAAbgw3/li5lUCT/2
	 +k7gIierXMe38h8zpx9B/MDXw0LZufzBUv/O4o96xbyuFptjAuwq7OuGWf0T48inQK
	 +xd6fJHQyirGKCQGfxWoAovn2DLIfmawzRSAcJHGqSrpvCr3D8HnNNeAH+Zfvux8Rt
	 eT6NKsFjMScGqi7UeAihKObfTMzLABpCwHd8C9SKuaKkm+mygi9nemAzI24VnvlGvJ
	 oIiT4X78RfbNWggOAA2wsplpUgQmCpvgbhsnxUDzZ+UK7PZaID+TL5Vhbl1Ma+Ih76
	 mgvv3tVZ0Y7fw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mg95thhz30Bd
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495012;
	cv=none; b=Qqnj9UfU0tmV4MJuwWPPkuCM6bHMPGMRXt9on6V3DppDzDJ/ixrYStM5hcLgtazEEnJRK5cMKnc7ItonkQIEJEvZWyC8FQZiSXn2oHrE3dbk3FQs3hgOWMphAwZyfMjkfSgxdVq42BABmN/dolwRA7lbx4PpKb8ye3peXKT/kMVWFjKbPGMl4LtfLdlmQTCCSVHfkSM/2XrOx73KCZ7E9nCsraxxzaEb10TK9Mrsao8nqC775q0DATBiWuzP1BFMdfJvMD6+a2HcCcr4AzsvGJyXik1mtiBwPAg4sYszMP2jCmvG9Qd5iTdNVyIrVAKtT0uj71MbcrUgQ2FvPrEsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495012; c=relaxed/relaxed;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USjh6CUvYWLsYrS2blFOjQqLJVIiN+pHbAoOM6UYFyb2bv68PgLDzubk8cKlZncle9Gsmb0scy0LV0gilG9bdLdzFxED6nBAzBiSm/9I1UTuA+HY0vXjH11C71Z4MafMVy/jmpM4IpvzS7WzBHm05rvb1uRMafbdcasr5yHfWafFArdCu9s56vyL/4pG8+GV96Prr114+gymZK7r+l2y7uGozu6EpwH4Ya1V+eazNHxArREe0iIX690rtywfYLX3yMV2tSgzyr29pr+btWcYUYpF88j6+C4rA8EHgrj/SZV1bQDZCAQFR2rbCEAwPaDEDzDYuGX13XkOlRrp1eEiEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=hYA3YLAk; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=hYA3YLAk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mg76N8sz2yRZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:51 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0652F698D9;
	Mon, 16 Sep 2024 09:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495010; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	b=hYA3YLAkGlfGNv/YjBVf4oINn07DQc3ryRFl4VhpDnrr268EyrbbQwq3nScNcWl/lTLpCV
	sIneI5zNeXEbBT1RHindRWghQsNWkOduHtBUjELOArq/fRqh05I0eYuCd+ConAUC3+Cur/
	V9on9OFM7by6VA9r6e+0CiQ2pqw7hNTDw2ejivQ8nZkqca29/K+50uFeO+59pg0azjc45y
	x/4xqKbVSXeFDMPj+ZI5gnulA1qGKDbK1FSdH8gfuCOhO9p9dLLV+T1MHsaMuSI51Orc+k
	ZUpEWSINDnW/xapVt8YxlBpq3mlTF+2T73Rj0Z+UChcyVuqtZ5OAAVmvVpoSWg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 06/24] erofs: add alloc_helper in Rust
Date: Mon, 16 Sep 2024 21:56:16 +0800
Message-ID: <20240916135634.98554-7-toolmanp@tlmp.cc>
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

In normal rust, heap related operations are infallible meaning
that they do not throw errors and Rust will panic in usermode instead.
However in kernel, it will throw AllocError this module helps to
bridge the gaps and returns Errno universally.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs              |  1 +
 fs/erofs/rust/erofs_sys/alloc_helper.rs | 35 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/alloc_helper.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 34267ec7772d..c6fd7f78ac97 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -23,6 +23,7 @@
 /// to avoid naming conflicts.
 pub(crate) type PosixResult<T> = Result<T, Errno>;
 
+pub(crate) mod alloc_helper;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/alloc_helper.rs b/fs/erofs/rust/erofs_sys/alloc_helper.rs
new file mode 100644
index 000000000000..05ef2018d379
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/alloc_helper.rs
@@ -0,0 +1,35 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+/// This module provides helper functions for the alloc crate
+/// Note that in linux kernel, the allocation is fallible however in userland it is not.
+/// Since most of the functions depend on infallible allocation, here we provide helper functions
+/// so that most of codes don't need to be changed.
+
+#[cfg(CONFIG_EROFS_FS = "y")]
+use kernel::prelude::*;
+
+#[cfg(not(CONFIG_EROFS_FS = "y"))]
+use alloc::vec;
+
+use super::*;
+use alloc::boxed::Box;
+use alloc::vec::Vec;
+
+pub(crate) fn push_vec<T>(v: &mut Vec<T>, value: T) -> PosixResult<()> {
+    v.push(value, GFP_KERNEL)
+        .map_or_else(|_| Err(Errno::ENOMEM), |_| Ok(()))
+}
+
+pub(crate) fn extend_from_slice<T: Clone>(v: &mut Vec<T>, slice: &[T]) -> PosixResult<()> {
+    v.extend_from_slice(slice, GFP_KERNEL)
+        .map_or_else(|_| Err(Errno::ENOMEM), |_| Ok(()))
+}
+
+pub(crate) fn heap_alloc<T>(value: T) -> PosixResult<Box<T>> {
+    Box::new(value, GFP_KERNEL).map_or_else(|_| Err(Errno::ENOMEM), |v| Ok(v))
+}
+
+pub(crate) fn vec_with_capacity<T: Default + Clone>(capacity: usize) -> PosixResult<Vec<T>> {
+    Vec::with_capacity(capacity, GFP_KERNEL).map_or_else(|_| Err(Errno::ENOMEM), |v| Ok(v))
+}
-- 
2.46.0

