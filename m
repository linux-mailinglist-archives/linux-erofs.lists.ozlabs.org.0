Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8197A33D
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495024;
	bh=F4hCBD/QFnbrfenytYFFJtYuvUkCDWy+jx5tXlowPUM=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=AHAsuiiDuQpS1tyh7jGBrYB7hveNJJMiI9qlTGiFG+XNRyr5c3vNvArLAeiIvX42O
	 iBJmfqb5j//XX5bn8mwlUt4a4mL9XUIFNH8yBJEPLiJIrbEy2pVdrD+Cu8Q5iOCxQ5
	 YQaHlWbNLbXy5uUlVEvJpzXLKiRTqpx8pc6VkWZZDzff+o4Eughl4ut7i2PdXr3aDD
	 W3zIwQNRBwL1oBx8B+vVxINKg9P70veJMMwKnDhBsGuWRxCdLHoMPMiisxDdJF1lOG
	 ZgzMOpZW4oqluBXA+PgCSJgFe+Qcgm29GAR7pM70p+0BXkP58E+xyfQBB22eFLfjDc
	 z8BNjkjfbo5vg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgN06Cnz305G
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495021;
	cv=none; b=eZVpFyEzjAmK6kDk2sFsGEgK6cY3lwIQ/pp057qROAjOVVyT++NhH7losa78Dkg8lgZXvh0oss+zDuLPv1+urGhnrzFaLG3hvcyH727sp226HOPXgLB7hQ/S5rT8g4PFK82/3RzFPcKpLyWjN1iTCDK72Yjwvo0lFWc2sHE/3pztAYJ52xlicJ256tG4Yha9Jf+fhup9LAIZWAg6PN9MXtj5ksZjs8oPElsKcHxslpBWj+1bU48B7wuSsgc6jnsszbJEiPIhQyg4wNhy/YWyRXsGMhcglNp8Duyv+6LS0ebAz9Lr9uSi6DA0HkxvFPioo+awm+XmZ/Uadsaw9usZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495021; c=relaxed/relaxed;
	bh=F4hCBD/QFnbrfenytYFFJtYuvUkCDWy+jx5tXlowPUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxgAHy/c4gtkDBN0vG1p56WQBMlIq7BkYRoR53fozif+zPldvckQH0N3k5YUNtXLA0wN02TXNSQQxtvnqwMD45XMMATsdLcAWVCu39MlL8oC1wI3eP3Z108rwzMpoeALXKIr7qARkq7TGXMSx1ebYk2nvCbGiHt+KGsA8otO1he63c0UJh8glpzyPJEJ228O6BVxCRPCEEpdoQnVvH8u0Y4njiPCIDoHUZStUs4Ye/In/eFZgOFnnIjSLtOt1PsRotJwhO8tMLX7LvOm6ddZD8MxFkQoBHmphKpXIDmPwBcuJSXAMzSpPZOKkyOdOVWUpvfKLr80/sa7OlXZ7IS8Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=CFSckmI4; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=CFSckmI4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgK3BlJz3c6C
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:01 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93C2F69845;
	Mon, 16 Sep 2024 09:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495019; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=F4hCBD/QFnbrfenytYFFJtYuvUkCDWy+jx5tXlowPUM=;
	b=CFSckmI4MUIPR9slBm8hO8DjCiZn8m3HjPaYgOVerbk8DEmUgIw9uVE85dm47JHVK0OQRI
	7MYVXmNEFJPIsUqwcQSjbSDy9kw0KiMRFJI3H8Sz5YX+L+ej0GwV0nO3CoNFUn3k5VxnSK
	8qCd3dKrDlY0aHo/90jKK/JJPfpi9WEFuS6Fy7eBnf38yI19S8LRwlIX6JVJJdAEHoKHDN
	WxP4HdUszJkuV08+XnKywMarGNMRm+QUOaaHev8dWlo5IcOJ8vIVc95+MfymXlzX/NKIvu
	K74GHUrHa3tW2dGbB7fbdK7GPji0+dCARhAzmPwA7yOy8HCN76mzygKk7gA5YA==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 11/24] erofs: add map data structure in Rust
Date: Mon, 16 Sep 2024 21:56:21 +0800
Message-ID: <20240916135634.98554-12-toolmanp@tlmp.cc>
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

This patch introduce core map flags and runtime map data structure
in Rust. This will later be used to do iomapping.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs     |  1 +
 fs/erofs/rust/erofs_sys/map.rs | 45 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/map.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index f1a1e491caec..15ed65866097 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -28,6 +28,7 @@
 pub(crate) mod devices;
 pub(crate) mod errnos;
 pub(crate) mod inode;
+pub(crate) mod map;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
 pub(crate) use errnos::Errno;
diff --git a/fs/erofs/rust/erofs_sys/map.rs b/fs/erofs/rust/erofs_sys/map.rs
new file mode 100644
index 000000000000..757e8083c8f1
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/map.rs
@@ -0,0 +1,45 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::*;
+pub(crate) const MAP_MAPPED: u32 = 0x0001;
+pub(crate) const MAP_META: u32 = 0x0002;
+pub(crate) const MAP_ENCODED: u32 = 0x0004;
+pub(crate) const MAP_FULL_MAPPED: u32 = 0x0008;
+pub(crate) const MAP_FRAGMENT: u32 = 0x0010;
+pub(crate) const MAP_PARTIAL_REF: u32 = 0x0020;
+
+#[derive(Debug, Default)]
+#[repr(C)]
+pub(crate) struct Segment {
+    pub(crate) start: Off,
+    pub(crate) len: Off,
+}
+
+#[derive(Debug, Default)]
+#[repr(C)]
+pub(crate) struct Map {
+    pub(crate) logical: Segment,
+    pub(crate) physical: Segment,
+    pub(crate) device_id: u16,
+    pub(crate) algorithm_format: u16,
+    pub(crate) map_type: MapType,
+}
+
+#[derive(Debug, Default)]
+pub(crate) enum MapType {
+    Meta,
+    #[default]
+    Normal,
+}
+
+impl From<MapType> for u32 {
+    fn from(value: MapType) -> Self {
+        match value {
+            MapType::Meta => MAP_META | MAP_MAPPED,
+            MapType::Normal => MAP_MAPPED,
+        }
+    }
+}
+
+pub(crate) type MapResult = PosixResult<Map>;
-- 
2.46.0

