Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C397A32D
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494982;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Je9zs6DL2KSvnJEjdx9i8MOUvvT0r9awpbgIb5RlTYOBn2v2wFvLix5wLYS+ntd98
	 azG6RbZvVl1liEERMstHPgfpjpSNjr1l9SPcO20KZN4ox6mxpzdoCHAzcGSX4C4rPu
	 rlJUezFyyvGvm2o3EnU+6RIHn08HFaQv8VhOwqz1K3cIMSfg0pWqey+F/BwI3cRIf+
	 H9alXd5ghDXK8p6E/xIlo7E9MxBp64+aPymrNGu9Un9v2tLSB2d8NFcED5VVYGsbVt
	 ZhpdMMs+6RqqOopAnjM+UXkai7k2d3u8VpawzFAPs3+6ZcjVZUrfcNCY83MOAJkp3A
	 4W7Y6lwikjdrA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfZ4mkmz3cSq
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:22 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494981;
	cv=none; b=NjGjYlj103sp+mjkjpWtRs0uOvk4KWrqohp3fCxZBF4uv3+X4tgtpn44qcrj9uCFRMM8ek5u0LYe366CLtpP7shRl9fSCWxL3ZRM3I4Hq/DWhrHRDxE732onLjk0tpUiR/EsmGW9z19CxDVOQTe9vsLRil9iOaGpUBsX1kzSbCjTErOsLFj4eFn93QYoZZck2CfS0R4Mx4TMhpsq8vbLonI4X14xtNmuvX9z55cZO73keUxsoVWRYoldZZBP0bxT9ZXPK7N58EXsD7Eu/6nfJISATWXmSP7GPwtqCiWyCseJeXl/PEgcDc672oLuXfsUlwTQnL8G/QiPJAg+tEbjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494981; c=relaxed/relaxed;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmeznnKm6yoWGovRmjY711xQ24qSTGnt3KiOIbrxyEZKHJBCoQ70c8G0wzC3F6cVkkaUIF6+irKw+q8qdEobIumrlzx+6VYJJd8inu3fi/B/AuTVok0Kxr1RlyDdLa0xeA8Ci2vz6Q5aR7R670/ZziBod7L9LnxUvAKpYOTpaOsVisl0dLEPiAT8+FeJbCPQxe1sk+9KDtCdDWiuq139MlbDelowCzhQEGM5hkAjMZC8aTZdyvCt12UWdnArd16OY7UV4fXvu3lvSyusZsMl8nOaTLqMaf3du8XS0PqPKlIZLxSEEgFi9S85KU0MnG2h2sjtoyBdsM/ZwqZ0uAfAAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=JG0YywNm; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=JG0YywNm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfY1PPVz2yYq
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:21 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76EE76997F;
	Mon, 16 Sep 2024 09:56:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494979; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TBJTDvYko+/iIPJGn9oa9UFP8352ieqw0qlVnvGk9ME=;
	b=JG0YywNmLao0k+8IkcmVMo1Tn7rk9cAoA/a1PrlMTUK/v/hLtORzSDc9yFLe7400qUxPlC
	MkjpSLGmtgq6XCcw9gcFCrKWn+V2JM0xqTm2dcI0+qnF9aS40Q9WIHJrZHXdygoyTaaQ8Z
	P95rw7havM9mbyYDXxu4/7K/TSXLT3MumjiadDjOaUe/ObcxklMdAsEUpcYDmp48F6vgWi
	vKVKIMQ6OHP2Vh8abqjXykdcWiiFMC7u84n8ED/9mBPaJKwXmNfPDSg83VAEA8mZjKzDZC
	JNgvi6SCATgor+5JvNps3qtIWoLk9cBufJZtCr0SDVwo0dtiE9IrmeddrLPMLA==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 10/24] erofs: add device_infos implementation in Rust
Date: Mon, 16 Sep 2024 21:55:27 +0800
Message-ID: <20240916135541.98096-11-toolmanp@tlmp.cc>
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

