Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B67F97A32A
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494977;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aMXlgil4E4CEDhdid9xViGdb+btshFDpMvZf2SWeNd/P6nWmLVHOhqkQ5omL7miuw
	 z9xwCOM+LeunZRufxul9bKv0ys/upVuUpqYEPhLan5snfdQzUFwcSMxc3VvMD5j2kb
	 NL3MfgWpKz2/1Thn59I/fK54qBddyrvRjtmczAt1f1hDggDvoxlflVkCUNk4stPskP
	 DMWjBKhChN/W4Z24zMgCn2+FAHRTQTtZbLHITeLkqnLI6x/Ss/Mfg5qCkb2vXSJMZI
	 lrutcNlUlys6o9tRX6qw6QBqwNYvmc5cqIyyx/oTSYBoa0pfYPVXGakCl9aoktEepS
	 2XZWhFcl+R+Eg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfT1Kc9z3cMD
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494973;
	cv=none; b=I6/f9YfK3RBAeBidUM8q603816zgJPM+wGNada90uLs70O8C0pDDp5bN4wB2zj7hbl45lggCb88EF4O4sCZtq1D1Jv2AuttDbMmcgiE0y/Dx9xRbRfCn4xEpdI/ouKipYSiFnWpRlFPqICjpy5mjNxxf9ZRqzJRq3yjtLRVeM4pSOWirQQqDf7ioMLTVpLZzNVX3UyTfkN56psz/Mw26DYogkYq2uSR9MnTgL29xvkMVLV8emKMbLaEV+Wwx0xvY++JQ3clyZX+09OYQBbQBw8rt+3snadW/kas35tCQrCak7eHco3Mr3tzIe4Cwv1fGgre8HEJjn3iOD18fGMPFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494973; c=relaxed/relaxed;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDhqGrmiV/LH22mYJXX6n0h8ig71Fs5Fyy5sGu3mV+zSXwSUc7FMfbll8zljyb7U6Z/rpo7TdTP4DEbLENS3zxWZLSXD9oF3zv7Q28CmiUHuGcZgb0m8TyxPzPSTgOZq5uj1jUR3Al49t5FLSDgSoyrpDAXPr8wZtrrtiImpmvUGNsTlLm6eIZBjX+XssBNXZPTdCAb7xP5DP+z/cy1ES9eFUu3JkXGON66wf2msRYY1DCULb/ajlU9L+6C2bNf8ladLVKcESCywMFX+N650X5Eyh9GlwSCLNW0bygLriQHb3jCszzx6KscwRlAmUcmRXUk5XovFtLNBXX2Vgfh0NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=mGxKwz3A; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=mGxKwz3A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfP3mtDz3bpM
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:13 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C7E2B6997C;
	Mon, 16 Sep 2024 09:56:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494971; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=fUBtB1guKBDyxePSsjzX2NyUyWv+dPs0ZXuq7FSRkmE=;
	b=mGxKwz3AdeaXEa+Zwv4zhcj0QPfvTzlnGjWzfjlWezQsRbE3bBoPx8/ftT/tdocBSMQ0fo
	LrFdFTZhsKHD4yaMuCHZTS5/ybTGly29AEwBdu/fikJDE7js+xJscqfqZQraDGnnqtOyn9
	JT4PHznx8/VKrZWoOMUin0TMDGF1dJXkk5AbGRHWKH6E1wLwglj4xm27jLAM0tDXwZN0tB
	85UzIuav1PuFzzBtLnF2Erfe3QQUzzCuqKjIUcXwazk1h58EJuxI0czudN6KA7IX3yOiTC
	bZQKi1P7XCNt7KmCcd9tbyvpKk0J/V9DbachkuYvPEiux2UDmPU7osSPjvDBEg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 06/24] erofs: add alloc_helper in Rust
Date: Mon, 16 Sep 2024 21:55:23 +0800
Message-ID: <20240916135541.98096-7-toolmanp@tlmp.cc>
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

