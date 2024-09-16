Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF0B97A33E
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495021;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KunvghRUjeIG36UUJbtB+KjMHcUmWoT0FZmH3NsPmUTF6cPJxCORm1Ohc8j719fmx
	 YXcaDWUIAcs75T8mTRnHpO9qLG3g30nhq3jaJo8Ci4kXKDzEHyttYSWYqflVDXB5gX
	 BmrUE5vOEPsoZImOIEC6e+ptPGPrJcEAxVzQNy3q3bqYbs3iBnkpfDgr7zRJtHDhn1
	 oLxoz2PP/Oq/b8dtJVmy1vM3TRBX6mp1M3TvXp0cbmOglvu0FJ9Vtvm0k0qxLEYXCt
	 iNgeQIQxB7ZW3Ah1gIRtWMZ8A+Rk9KETRJ4jNMuGhtA2C1XscA6TQghYaMvb8gV3a4
	 y2kPI/f85BWTg==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgK2Lfzz30Tq
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495019;
	cv=none; b=PEL7wrZhUvXH4GOjALFDortA05J+1IwW0ueDPtXTFqbmZfjiLvi3KSaiEkbYZ0tMpSdDhyWhAkxKeCrc7kYpr/55wFrhruu2cE5pXkSaYsOyQ+WxJ0jfZLyLBqpsi7xQHD77ECNBjTJiJvYE/Ac6TWosC1sIF3Os7HPJ8R5Ho+7g8pZg9JX9CVyNFYSvaOlRzZgoWiK4RbQ60Z6nqtYMZ3oJVfWnVs1a0+Tqc6zDoln/ueh4bsZCpTD72yyJqSzbs4fPfHKvS4SUu/URpj9b+xI+qRFp08RcH3Dbi1cyGwh6QEDVOtirxzlb2Tqk51jE7nrXi8LkGmoLYer4BFW5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495019; c=relaxed/relaxed;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcKVjMMJ7o4XtVmr7JY5to7LAspn4amlpq91OL/e3pkTazglGl0b34LwbKNTgkyh+utSeEUDbY6/2VhIfwfhzRpM37jQJ2xLTBepwUVOty18xVYK7LwBJ/0QDc0zzmlxR+2bOirG5q40sPREYTnOdkWWVEYTCey+ENTjUFXL+7hVGE0ur6GDZef7GHwU+gAoJZzP4zY0VPWTPibZ0OB44V83OKFsid3wB578ZmjvT0QIkDy2UZVjgK0d5oCUVXzg5n0SZlFfdeGlhTX/DlYJNMVIWjzPs9Oj3dgOTJhlhqyyjnbiIJV9v+0BhXPQ/7dKoKgxfTBZBYuLW9VSPIIwnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=XH3Ah7t4; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=XH3Ah7t4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgH4V9Sz3c5h
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:59 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8826697C4;
	Mon, 16 Sep 2024 09:56:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495017; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	b=XH3Ah7t4SBLcqo+8KnSh3HxrmkPHlBuTAmP7b3h1yVUBwKksZ+Ubxa+W/3dK8WnR4GYFaL
	fBCj01ajrvkvrX08TAB+rwGc3lzQOezj1NI79z0vMMGUJEwwQ+6JxMT1zql4dCuUD1+xSw
	qI7Wmb8+Jyi+AP/kSlIrKORBBr2mQDOefsvGjp3DK3MWPdi7fu1UboTPapiwZiZQ25hgF8
	aYe8WwCKZ3wOx+zqwq2vMNlaA8q0ldf3rwl8aiGiwQ4AKIGttuOZjn6mhE3QEfT51kJGdB
	cNsjRcklTvhCC9480oSqXyWn7Z7wLyCQR4JjeKroaq8Cg2hZK2UfxOP0StKvZg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 10/24] erofs: add device_infos implementation in Rust
Date: Mon, 16 Sep 2024 21:56:20 +0800
Message-ID: <20240916135634.98554-11-toolmanp@tlmp.cc>
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

Add device_infos implementation in rust. It will later be used
to be put inside the SuperblockInfo. This mask and spec can later
be used to chunk-based image file block mapping.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/devices.rs | 47 ++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/devices.rs b/fs/erofs/rust/erofs_sys/devices.rs
index 097676ee8720..7495164c7bd0 100644
--- a/fs/erofs/rust/erofs_sys/devices.rs
+++ b/fs/erofs/rust/erofs_sys/devices.rs
@@ -1,6 +1,10 @@
 // Copyright 2024 Yiyang Wu
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 
+use super::alloc_helper::*;
+use super::data::raw_iters::*;
+use super::data::*;
+use super::*;
 use alloc::vec::Vec;
 
 /// Device specification.
@@ -21,8 +25,51 @@ pub(crate) struct DeviceSlot {
     reserved: [u8; 56],
 }
 
+impl From<[u8; 128]> for DeviceSlot {
+    fn from(data: [u8; 128]) -> Self {
+        Self {
+            tags: data[0..64].try_into().unwrap(),
+            blocks: u32::from_le_bytes([data[64], data[65], data[66], data[67]]),
+            mapped_blocks: u32::from_le_bytes([data[68], data[69], data[70], data[71]]),
+            reserved: data[72..128].try_into().unwrap(),
+        }
+    }
+}
+
 /// Device information.
 pub(crate) struct DeviceInfo {
     pub(crate) mask: u16,
     pub(crate) specs: Vec<DeviceSpec>,
 }
+
+pub(crate) fn get_device_infos<'a>(
+    iter: &mut (dyn ContinuousBufferIter<'a> + 'a),
+) -> PosixResult<DeviceInfo> {
+    let mut specs = Vec::new();
+    for data in iter {
+        let buffer = data?;
+        let mut cur: usize = 0;
+        let len = buffer.content().len();
+        while cur + 128 <= len {
+            let slot_data: [u8; 128] = buffer.content()[cur..cur + 128].try_into().unwrap();
+            let slot = DeviceSlot::from(slot_data);
+            cur += 128;
+            push_vec(
+                &mut specs,
+                DeviceSpec {
+                    tags: slot.tags,
+                    blocks: slot.blocks,
+                    mapped_blocks: slot.mapped_blocks,
+                },
+            )?;
+        }
+    }
+
+    let mask = if specs.is_empty() {
+        0
+    } else {
+        (1 << (specs.len().ilog2() + 1)) - 1
+    };
+
+    Ok(DeviceInfo { mask, specs })
+}
-- 
2.46.0

