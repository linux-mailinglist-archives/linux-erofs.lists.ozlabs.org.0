Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14A97A345
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495034;
	bh=IJeFyOgl8nOrg6bU4FPruU0g/Xx5Ar0E77i2j4pU4gE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=bkRWjTTq0y2k5rC+1lHIAWfrOkzJHkrHiWE6vVztPkw9VDcmnysHFz3vb5Iq/1F0q
	 PAy+EB29uaLsKOMHmTk2hqdwbdUN2nb9uw4MdGWCIlrbcmpT+KX2kb87u/m8TmzR8c
	 Y8CT4BIxD1HCmNHOmW392BNOFV5RWldwDs6H2CmlCm2erO0Q8fq5f803XLR5klWVqi
	 K40pfbYOdnVrWf12tJn2PBapeM7V4e2FhA8wA0GGVo6WHGD/IcieLoqSxFaXRjB2kn
	 oXLfNxOY+4XV407V+0NbIe2VLQxuOKb+tbfZVwo2zDPBwLqIRQQAGRIOAUKkNr3/O6
	 s2c+sJeMGxYrw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgZ2K7yz30GV
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495031;
	cv=none; b=UwwrJm//7b1/yF4BVEAKUj7fLHttp/W2Lk86/crySWJ8QZ+02FWjZFvUQyNyh9q7Pd0aLsgJLpO3esffhHFLC3J30pCtZagPuOb/2q0apTkjb+8tQj6QL4a6dVS0xO+jbmCacqVz7ldlpnupdz95vZiArbvfLtAGMAbP7JwSmp7hjtXDXSTLYy/MQ+AZWF6XnrrH4HkNEOtZic9Iqh4Gj0piCFAVyHoFCz3tpj6Bs2/6Ck7x3NDRdGxpNKkEgrfdlwLxv7YCObBQGqiJjMYspVJk3unKUpVCACa90tyASKkwu0LhN9OebLDwgV4Z27m1KlU/fhw/qFVvw605kgHkLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495031; c=relaxed/relaxed;
	bh=IJeFyOgl8nOrg6bU4FPruU0g/Xx5Ar0E77i2j4pU4gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcFxEho3Zc6XsF9btocw1Chox/DELy0lr5fxLcdWm4dPlnqCa2NVsMgpzpV1i8TmpScMfl5j8k1mgOBSHrwCtqTwxOLLab1alX6QypyXvaa4nhgPh2JhLc51UlFXunczUpKCzMngoXFnBcIqfXzhCwxkOJsS/4ctfuPrjYXq8j1L2NANzMh9TtOPoviiJPm5T9pgqf3zlfoD7jp7BG8xxmvtCDKOgOS3r38UpEfGa0F94l7vkz93oracHvrCiXf0ixhcnEYm7MOk+R+++h2waZt9QxX7atkuLJTZBDHsDhyUwtndH+1ojXylmvWH7EwZ9KLeOHMgIYqlVO0TxAYJfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=ZXh9ANSe; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=ZXh9ANSe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgW2nQdz2yNs
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:11 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7576069845;
	Mon, 16 Sep 2024 09:57:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495029; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IJeFyOgl8nOrg6bU4FPruU0g/Xx5Ar0E77i2j4pU4gE=;
	b=ZXh9ANSeQAemFI4eZL3sOh1Z2/r3EKl6hlzBLpgjMPgsxzAe+kNNa64a9MdPQqqYmHRJsl
	3mBfx2PEAAQLsqHMGWmquqyme73AJoHHVz5iaVNcAYIqdRqV9a7B/kuw8mNrEFOkuRo5Zh
	rHWXcuY1hgx0yHt4EXAbSnG1tWurs72jBfpkJmHx6EI4we2UTFs+gunmnMG+DkvI3pBqUx
	zxoOFTdsPOxVTivfHCHMiacs26ZpzMZDkcjFGCxqvnZAjNp1vHPBaTdLo+qCF9om8mL6WW
	pTt3MbFU9KdB++Cq1L41srGGKE0GIpVdsXkZaAd70XTtDaTC2QFnVqocbpQpJw==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 16/24] erofs: implement dir and inode operations in Rust
Date: Mon, 16 Sep 2024 21:56:26 +0800
Message-ID: <20240916135634.98554-17-toolmanp@tlmp.cc>
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

Implement dir ops and inode ops in Rust.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs            |  1 +
 fs/erofs/rust/erofs_sys/data.rs       |  4 ++
 fs/erofs/rust/erofs_sys/operations.rs | 35 ++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock.rs | 59 +++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/operations.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 20c0aa81a800..8c08ac347b2b 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -30,6 +30,7 @@
 pub(crate) mod errnos;
 pub(crate) mod inode;
 pub(crate) mod map;
+pub(crate) mod operations;
 pub(crate) mod superblock;
 pub(crate) mod xattrs;
 pub(crate) use errnos::{Errno, Errno::*};
diff --git a/fs/erofs/rust/erofs_sys/data.rs b/fs/erofs/rust/erofs_sys/data.rs
index 21630673c24e..67bb66ce9efb 100644
--- a/fs/erofs/rust/erofs_sys/data.rs
+++ b/fs/erofs/rust/erofs_sys/data.rs
@@ -2,6 +2,7 @@
 // SPDX-License-Identifier: MIT or GPL-2.0-or-later
 pub(crate) mod backends;
 pub(crate) mod raw_iters;
+use super::dir::*;
 use super::inode::*;
 use super::map::*;
 use super::superblock::*;
@@ -26,6 +27,9 @@ pub(crate) trait Backend {
 /// DirEntries.
 pub(crate) trait Buffer {
     fn content(&self) -> &[u8];
+    fn iter_dir(&self) -> DirCollection<'_> {
+        DirCollection::new(self.content())
+    }
 }
 
 /// Represents a buffer that holds a reference to a slice of data that
diff --git a/fs/erofs/rust/erofs_sys/operations.rs b/fs/erofs/rust/erofs_sys/operations.rs
new file mode 100644
index 000000000000..070ba20908a2
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/operations.rs
@@ -0,0 +1,35 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+use super::inode::*;
+use super::superblock::*;
+use super::*;
+
+pub(crate) fn read_inode<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    nid: Nid,
+) -> PosixResult<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    collection.iget(nid, filesystem)
+}
+
+pub(crate) fn dir_lookup<'a, I, C>(
+    filesystem: &'a dyn FileSystem<I>,
+    collection: &'a mut C,
+    inode: &I,
+    name: &str,
+) -> PosixResult<&'a mut I>
+where
+    I: Inode,
+    C: InodeCollection<I = I>,
+{
+    filesystem
+        .find_nid(inode, name)?
+        .map_or(Err(Errno::ENOENT), |nid| {
+            read_inode(filesystem, collection, nid)
+        })
+}
diff --git a/fs/erofs/rust/erofs_sys/superblock.rs b/fs/erofs/rust/erofs_sys/superblock.rs
index f60657eff3d6..403ffdeb4573 100644
--- a/fs/erofs/rust/erofs_sys/superblock.rs
+++ b/fs/erofs/rust/erofs_sys/superblock.rs
@@ -8,6 +8,7 @@
 use super::data::raw_iters::*;
 use super::data::*;
 use super::devices::*;
+use super::dir::*;
 use super::inode::*;
 use super::map::*;
 use super::*;
@@ -287,6 +288,64 @@ fn continuous_iter<'a>(
         offset: Off,
         len: Off,
     ) -> PosixResult<Box<dyn ContinuousBufferIter<'a> + 'a>>;
+
+    // Inode related goes here.
+    fn read_inode_info(&self, nid: Nid) -> PosixResult<InodeInfo> {
+        (self.as_filesystem(), nid).try_into()
+    }
+
+    fn find_nid(&self, inode: &I, name: &str) -> PosixResult<Option<Nid>> {
+        for buf in self.mapped_iter(inode, 0)? {
+            for dirent in buf?.iter_dir() {
+                if dirent.dirname() == name.as_bytes() {
+                    return Ok(Some(dirent.desc.nid));
+                }
+            }
+        }
+        Ok(None)
+    }
+
+    // Readdir related goes here.
+    fn fill_dentries(
+        &self,
+        inode: &I,
+        offset: Off,
+        emitter: &mut dyn FnMut(Dirent<'_>, Off),
+    ) -> PosixResult<()> {
+        let sb = self.superblock();
+        let accessor = sb.blk_access(offset);
+        if offset > inode.info().file_size() {
+            return Err(EUCLEAN);
+        }
+
+        let map_offset = round!(DOWN, offset, sb.blksz());
+        let blk_offset = round!(UP, accessor.off, size_of::<DirentDesc>() as Off);
+
+        let mut map_iter = self.mapped_iter(inode, map_offset)?;
+        let first_buf = map_iter.next().unwrap()?;
+        let mut collection = first_buf.iter_dir();
+
+        let mut pos: Off = map_offset + blk_offset;
+
+        if blk_offset as usize / size_of::<DirentDesc>() <= collection.total() {
+            collection.skip_dir(blk_offset as usize / size_of::<DirentDesc>());
+            for dirent in collection {
+                emitter(dirent, pos);
+                pos += size_of::<DirentDesc>() as Off;
+            }
+        }
+
+        pos = round!(UP, pos, sb.blksz());
+
+        for buf in map_iter {
+            for dirent in buf?.iter_dir() {
+                emitter(dirent, pos);
+                pos += size_of::<DirentDesc>() as Off;
+            }
+            pos = round!(UP, pos, sb.blksz());
+        }
+        Ok(())
+    }
 }
 
 pub(crate) struct SuperblockInfo<I, C, T>
-- 
2.46.0

