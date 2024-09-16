Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9120497A340
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495026;
	bh=aIuZG5PEljHDXPUlgWsVRtI4LVnRy+jfg4KsDBMADu4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=g2KaBiUojscTBrtaR/A7RBnIF5dhmAZDbKd/z7MJlG45qP53ZxysiVbmwM9TBg5o6
	 /Efpp8r3jbopw3QeUFrjw8V+/ZPSqIq1Zb2CVqIX5J9khOoVT6Z62sE1umA7wfbuCm
	 tNE0YOxzbalxhnyITnsvKIqGcRjwhYTBHzd0Gm7mNoBWKThJhGwY6w+G6X2YLftyyj
	 RXiGAF+RBTTn5WQ0929yvcfyk5K8Hsh4TULWvYHWDMYCOJqVJjLLZeFrje9Dx3Yql3
	 lfeVhUCJswvnSA/0fnibGDmVAr3dRZBB9z0Pvt4XZcCMHJzUGqSx0qJ8vWzfpEg4jF
	 VX5mPzqqrAWzQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgQ488Wz304C
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495023;
	cv=none; b=R9zgGYL9rTbSdLJW+RC4uEAKJFYTOadql3pyPY/q6Jg4a04pBgLBUqUDrLOcqSQiOG7I66AnPUO8yHYmYzukT982PkbnGwfatcRZsRcUeJAajumIv7FmaZGnKW6GMhWdsVhg/gF2MVZNhh/59C/qy8DVa++dubibx1JV1gv73YzNB404PWPLReM7xGHVhFc78/ymXlmRYC1eLMqeaK0MP+vna252S1cUJQ+/+dGT7D8VUkioAhWOHegNjbR9LUd6EyLgD5Y7XScTP+sM0HXuw3OOGEDGrgwCCbdwYmx8AAKdXq9HwgnSmQo49pxTMxesV5GUU2i6xG14UKLys9UNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495023; c=relaxed/relaxed;
	bh=aIuZG5PEljHDXPUlgWsVRtI4LVnRy+jfg4KsDBMADu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfNOQ/8klWeyeh3pdQrIY9eERk6dvi08rzxSe8EnXwl5RDitQ19QjzEB3OVouj5mKSw+EoNLTef7GbAvbbmprSVXSdKQ+kxTXmB0wWqHVJKDOitVWZqzrgnpTG5Ify/MYFdtwxX57EhUnsAwzkEnEgOnf2NPav6Tq5fjqO7idZn42qDhB7RSsuotBVtubTzF6xMNaL8c44iSx91cfYm1uwQkRwO3ydfXmy2AujvW/VR54k8PgTmylXyk1oGM2W46aPWoPRupSqWYtnmF9lDaPOHCCc7B1O1YU6p00OR+m9cu7GaqdGrKP83jDjo5TSCqw+yq5yyuhdM8pWYJg+Sa0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=JzgW3RT9; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=JzgW3RT9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgM4w8pz2yVX
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:03 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76A4A697C4;
	Mon, 16 Sep 2024 09:57:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495021; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aIuZG5PEljHDXPUlgWsVRtI4LVnRy+jfg4KsDBMADu4=;
	b=JzgW3RT9D4Z5Zx0GeV99WrpnWZLJKf6cD4UwQVruHRKjSt1IWDApdXssW522GAGu85TKJE
	szMUzWXMfWY4d+6AlArsH21f89D7DGFxIvxS/ynohg2VJN7VbuRLb3s9z6GsTSDB9k9tyY
	SxKljzY3Y8TrYD8aWuprNrCBpCZ6u5Ph/OdJ3hcLwdUnBO2mN6/rjkCh95g2TIXSUJIoQd
	QtMVozhUxBW1K0sVzTjCtcYV1bQz0R9qzMPS6+GcsCH5guI40E/ucfP7+HzmeppU8W5pDA
	nEfyy0mEsmcOhPs3p0CpuD1N6FYdbonSJ4n1spG/+ncP73znZUy0DRoF4cblwg==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 12/24] erofs: add directory entry data structure in Rust
Date: Mon, 16 Sep 2024 21:56:22 +0800
Message-ID: <20240916135634.98554-13-toolmanp@tlmp.cc>
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

This patch adds DirentDesc and DirCollection in Rust.
It will later be used as helper to read_dir and lookup operations.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs     |  1 +
 fs/erofs/rust/erofs_sys/dir.rs | 98 ++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/dir.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 15ed65866097..65dc563986c3 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -26,6 +26,7 @@
 pub(crate) mod alloc_helper;
 pub(crate) mod data;
 pub(crate) mod devices;
+pub(crate) mod dir;
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod map;
diff --git a/fs/erofs/rust/erofs_sys/dir.rs b/fs/erofs/rust/erofs_sys/dir.rs
new file mode 100644
index 000000000000..d4255582b7c0
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/dir.rs
@@ -0,0 +1,98 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+/// On-disk Directory Descriptor Format for EROFS
+/// Documented on [EROFS Directory](https://erofs.docs.kernel.org/en/latest/core_ondisk.html#directories)
+use core::mem::size_of;
+
+#[repr(C, packed)]
+#[derive(Debug, Clone, Copy)]
+pub(crate) struct DirentDesc {
+    pub(crate) nid: u64,
+    pub(crate) nameoff: u16,
+    pub(crate) file_type: u8,
+    pub(crate) reserved: u8,
+}
+
+/// In memory representation of a real directory entry.
+#[derive(Debug, Clone, Copy)]
+pub(crate) struct Dirent<'a> {
+    pub(crate) desc: DirentDesc,
+    pub(crate) name: &'a [u8],
+}
+
+impl From<[u8; size_of::<DirentDesc>()]> for DirentDesc {
+    fn from(data: [u8; size_of::<DirentDesc>()]) -> Self {
+        Self {
+            nid: u64::from_le_bytes([
+                data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7],
+            ]),
+            nameoff: u16::from_le_bytes([data[8], data[9]]),
+            file_type: data[10],
+            reserved: data[11],
+        }
+    }
+}
+
+/// Create a collection of directory entries from a buffer.
+/// This is a helper struct to iterate over directory entries.
+pub(crate) struct DirCollection<'a> {
+    data: &'a [u8],
+    offset: usize,
+    total: usize,
+}
+
+impl<'a> DirCollection<'a> {
+    pub(crate) fn new(buffer: &'a [u8]) -> Self {
+        let desc: &DirentDesc = unsafe { &*(buffer.as_ptr() as *const DirentDesc) };
+        Self {
+            data: buffer,
+            offset: 0,
+            total: desc.nameoff as usize / core::mem::size_of::<DirentDesc>(),
+        }
+    }
+    pub(crate) fn dirent(&self, index: usize) -> Option<Dirent<'a>> {
+        let descs: &'a [[u8; size_of::<DirentDesc>()]] =
+            unsafe { core::slice::from_raw_parts(self.data.as_ptr().cast(), self.total) };
+        if index >= self.total {
+            None
+        } else if index == self.total - 1 {
+            let desc = DirentDesc::from(descs[index]);
+            let len = self.data.len() - desc.nameoff as usize;
+            Some(Dirent {
+                desc,
+                name: &self.data[desc.nameoff as usize..(desc.nameoff as usize) + len],
+            })
+        } else {
+            let desc = DirentDesc::from(descs[index]);
+            let next_desc = DirentDesc::from(descs[index + 1]);
+            let len = (next_desc.nameoff - desc.nameoff) as usize;
+            Some(Dirent {
+                desc,
+                name: &self.data[desc.nameoff as usize..(desc.nameoff as usize) + len],
+            })
+        }
+    }
+    pub(crate) fn skip_dir(&mut self, offset: usize) {
+        self.offset += offset;
+    }
+    pub(crate) fn total(&self) -> usize {
+        self.total
+    }
+}
+
+impl<'a> Iterator for DirCollection<'a> {
+    type Item = Dirent<'a>;
+    fn next(&mut self) -> Option<Self::Item> {
+        self.dirent(self.offset).map(|x| {
+            self.offset += 1;
+            x
+        })
+    }
+}
+
+impl<'a> Dirent<'a> {
+    pub(crate) fn dirname(&self) -> &'a [u8] {
+        self.name
+    }
+}
-- 
2.46.0

