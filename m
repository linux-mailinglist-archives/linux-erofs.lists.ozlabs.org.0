Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532997A33B
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495018;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=gKESWheCEMNOd9qUHBRnjjvMLd4EJtQdIsJTIkZ6zXf1Zg2MGOIcH0P4bMps9FG8l
	 2geAz85/d6JqjFM7hzQ8AeX5eojWD6zq2Pvj0sKZsWbZgbarmg5Drexmvwa1+1NgW0
	 2sjskUaFAh0i4MDhitHuDRklb9e1hsqYcl5PKwmBRi/Js4JxNh7wtOgk4YD/C6diwm
	 M1EMmDztOvgnjPkv7Ga/tBeqQo0/BVOWX1D53Ha/46MBfU41RRIDxVvTR/P6ZYTWU1
	 toVTeDx/mtbq7ms/FBaC5f/h/QQx1x010h8iu/bWRsHwGTaMImG9XlFeu1zMggL0QQ
	 EdoF/dA7oUfWw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgG0rKCz3c5m
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495015;
	cv=none; b=T7du7gd4xXlQxfi9rWaBxVZVqy4nQAwtth8O97dZpFz7B+Ndrgvfmgs5MrN8GRM/DXaPvsT78CgEJsiZuVslRoIO/lxLQqYHxSVo8JchsIRLC5aLym92G+2gydpYiyPy6WwYwR4eWxCEsVO2JIC5yz8oTvbd4NfzGD2lauZ8rAHraZCZ7n2RN12vJsl8hPy0E2k2SXqdVsxR4eyEoUm8FX0M/CDTNre59WJZS1Ar4ZCsLrqJo1M6zRlf2enpFCP5CRWSGbXcHqw13+AZAbQ2VL7OBFZb96sTLLOpVOqwTRAqv4KTJA6Yog/D2S9EyeN7GQ+EiNIVi5FzpsvmDg4Ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495015; c=relaxed/relaxed;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJEN8DeaFuc2Gvv2oTJYx0ozLOh+1ZtYrLLQAhMvSS2wueUbX2ftgCvX5/VfVgFi6lUn+7LT4SQ9rYXzaNQ00aiUK3/2AOkgdCh0OtsfGM+JBqrhFhzyJwYsn7ClxOWaICtIRolapUaUWP7xEE1hs0/pg4uo+xaYCGzgBQHr3c3vp+RSr8jwpb3oljmSh6BVdpUYQg+N9M3bPva5G+JnE43XSxDHLxDVgjcddqAKgcgzaGMqQ+FP8jgWr/cnidlzr6BgxA+MClz1gOMaHZ4TpfqpK28XSRxPCF8ndvmEGTJuUoeLBvJwdhfB1KPpSVHW2hMvYRWbIo3qdy61oPsPMw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gntO7RG+; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gntO7RG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgC5ZJ7z2yVX
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:55 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D356F697C4;
	Mon, 16 Sep 2024 09:56:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495014; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=RpwAvNBL1BrrWM3+ylO6h2C6ZxDk5XDbbYWzUi+PA6A=;
	b=gntO7RG+naT7UAbmN9YrOU7lFOnX6O7m9wdBElz71oXY/SvrFQPdgeh91hNsJqCtn6pwy4
	50ZUtxmlhVTf5oHnbw9y3C35Twg+2gajp9ksrcy777rB/12VpaL3VeI1voDg2npj+iyKUP
	uZT1Bt+vRqHJft7wmTCzNk6IW9qlTpu/oUGSFnEBM2Z+2YDAbQc9pFBxtn/nqVS1PDSMHG
	VRUdsVTxGTiUZ9I5Tc5kEbPwyBGnhzauQanUdZXaQB8xpL53OheHsEcVQIFviGCznCDSX9
	8iv9jVzAoYzTupEffpGl6bB0lSLXlJbrLfjayGtXQYCJT6jEEi4JozVGHjRHyg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 08/24] erofs: add device data structure in Rust
Date: Mon, 16 Sep 2024 21:56:18 +0800
Message-ID: <20240916135634.98554-9-toolmanp@tlmp.cc>
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

