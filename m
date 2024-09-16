Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA297A32C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494981;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kTg6BbmZgZgVDH2ZNYeYDMOI40ELNJVwwOUDtv9bq0P9uCql8nC4/eBB+uDatZy6k
	 IUPI6WKJTirnAsAjlVIC8bMlgcLZ9sdlYefxZIcFMOhXsh87FwUn5sT4LJ8MkbJIm3
	 lHyVkBApr+rd/ALBgOaAti06dT19IqtfAgQ6I/ErPAqQ24j8HDcA5cpPb48IMwOerZ
	 I8xOM0pUbtF5+ctEBBKZ+4qtz6HZewTMBRqYTdcQnDDd2m2QF/4QYojAu/I33jFE4h
	 M7yo11rodXpkbc4gfXWwhb+otnQ5o4Hc+ZaAhCxw+tX09KGWJHJSVgCFbK0/Oq1tnN
	 7TJiAkY9BP7SQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfY3XbDz3c78
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494978;
	cv=none; b=iKERPxAQ5YdrdrMnsm6Fo/R9iefcEp49lOa+EEW+bzRnEdjY7ghme4lTnareCjmnAtoqOWZB9uf6W0HyXikG92LWhBZIaPPlwdUhGyym+FJvKpbyN4HoWN2urnKi4SZmuMLnQnpgdRUN47bufxHzQAI6IwxBvxhxcEj9DZgKOIJvGCxji1USSBh4+82w7C127SleYGEr0e1qseXFOK+bf+a5ZIFI4PpKf6cqQHDAKJ/NtUhrvVqwbvdZYlpFMi0rryz5lXkGv5+4+ZB+blBNtiZoqlRHtFD4I6xgUXQYKhWCqVUCFfrivVBdQSmf2Yhw8mU5W3/N+uRD2BgFBS7L6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494978; c=relaxed/relaxed;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRcBjS+5A3PEUbYEW/gvhgQV/wQB77avKTk0H/CWaIDndKODjDOSbA2WtpGu8PNQKEg/K9aQdhsgmBRxkNY7ArSbS3U3UbHINNgo6F1kWBR+VQJr0EPYopdrD+QYBvGgCaVffKV7TlFybGRda3kysOU4d2VCvgm6AAxIa1TaaTtQL4XJ09/BeCElxzx0TNQTZN2QjlvHOogY45CkarBgAoSBOQOlOwu+YzU6UIqyjSbUbBEP75fk4c8C/VOT1Pg8HHV4216Pum21cTaBfV7z21xZf6lCtryDcuS87gel68+URJoJW4GHOBty9VM/wruin8MEzsGgblnlH7OhaTB9kA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=RD9Zrmy4; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=RD9Zrmy4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfV5W55z2yWr
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:18 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCD7C6997E;
	Mon, 16 Sep 2024 09:56:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494976; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	b=RD9Zrmy4bnAEImb3l+5RmIvtBv7zzpA5277tsz28NEc29kpPHV2TkQFR0iP47WKY+05mGt
	uDA2J3GSyTW2VhipdhYWfkSQzSJeu+leX6EWumOqkYQH78h8dxxt1k0zdaOW5l60w7D3eR
	snDYYM+IoWKGgJKxfcW+CRv56yQY7095GKS72xgakamKZWssSuKp7rrTFGMRChcVmV4EV2
	iezGjTojz87rgiQ00RMiTA73/kk326M23WBZ+3X6QUxCbCS4ipne+siy3ua8QkXsZAKqAI
	OPWnpud6JYZLZfj8fF5wVBAvQwKqZQ9WsDVtloLalbjXSAxci6+P69wNpm4RQw==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 08/24] erofs: add device data structure in Rust
Date: Mon, 16 Sep 2024 21:55:25 +0800
Message-ID: <20240916135541.98096-9-toolmanp@tlmp.cc>
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

This patch introduce device data structure in Rust.
It can later support chunk based block maps.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs         |  1 +
 fs/erofs/rust/erofs_sys/devices.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/devices.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 8cca2cd9b75f..f1a1e491caec 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -25,6 +25,7 @@
 
 pub(crate) mod alloc_helper;
 pub(crate) mod data;
+pub(crate) mod devices;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod superblock;
diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys/devices.rs
new file mode 100644
index 000000000000..097676ee8720
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/devices.rs
@@ -0,0 +1,28 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use alloc::vec::Vec;
+
+/// Device specification.
+#[derive(Copy, Clone, Debug)]
+pub(crate) struct DeviceSpec {
+    pub(crate) tags: [u8; 64],
+    pub(crate) blocks: u32,
+    pub(crate) mapped_blocks: u32,
+}
+
+/// Device slot.
+#[derive(Copy, Clone, Debug)]
+#[repr(C)]
+pub(crate) struct DeviceSlot {
+    tags: [u8; 64],
+    blocks: u32,
+    mapped_blocks: u32,
+    reserved: [u8; 56],
+}
+
+/// Device information.
+pub(crate) struct DeviceInfo {
+    pub(crate) mask: u16,
+    pub(crate) specs: Vec<DeviceSpec>,
+}
-- 
2.46.0

