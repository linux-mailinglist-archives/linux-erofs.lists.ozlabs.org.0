Return-Path: <linux-erofs+bounces-3248-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG8/KBjL12k/TAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3248-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 17:51:52 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9E3CD205
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 17:51:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs4Dd1sX8z2yfS;
	Fri, 10 Apr 2026 01:51:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775749905;
	cv=none; b=c/AyTlCMGZ1vE7nsVePGExM1iyazaDlDJ17EX+6wrAR1y5mDNsvGZaLMP0JwtuunKCo9b3Oae2JfKhIEt+pg5lOsh5CQE038sYHzBD1onfvMMC6guvPK2Xv+gncz3MFv4ER+IbOwy1mppsU3TOEwgge2PHH+jadURf8DIbkDVXvT700Xhi5sadN+HTIjuhMp3i6xlrcRVqQbwtOCg8HeNRq5c2G2FeTSq6UiJsYvY+fmiqznwY9Mqg2auVioRwF+bCIj9QGdyCo31Yyr8MTZr6iPPHhlJJvIjSXMMe8ZtysVgEN3QPqYP+enq3jEpMNEREl1PB+tKIU/86jncM+rvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775749905; c=relaxed/relaxed;
	bh=heTdVbAqXxGifzvVsjx1/Xn0owg2Ddsba/xSJwhQIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNVg725m8XiqRxZjXlacy62gilWGvAl9EnEiSLQQiHGaLzHku02Vy/FdPlwU5IDQ9EQOGk9lKXAGKuVpWF/F9+wH55paQPtIxDEmDmRJlCvWeu5w1fdsMbQmXBiSW9L/h4VGZ8iXE3kLVcEPws1ZKvs6lQOUDsPWnwZV+m7Ya5YfyPN9DHdxkw781YEgdUf/46/VQu3Z9JOCQV974+dZ7epiWySLfJpetrxPSEvwQDzj0TkMHKj19pqXtsY4GZCqLDwLKThEWRPPBjbTo4AaSN5bhEYX5ZO2613xmXj1sWkSDXVP0FGmaQK+2JQNfcP9JxG/wuDzsmIDYnC91m7iEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sZ//enRV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=priyena.programming@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sZ//enRV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=priyena.programming@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs4DZ5rPBz2yT0
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 01:51:41 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2ad4d639db3so5522865ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Apr 2026 08:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775749898; x=1776354698; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heTdVbAqXxGifzvVsjx1/Xn0owg2Ddsba/xSJwhQIxo=;
        b=sZ//enRVpP4r0MECqDj+IdF/XII2mchdAKmAGzbaCsj/L+6N458NOAG39tSzwXtgLF
         2mGJHMvbrReIJkUMc8H/I3CiK/XzNQXj0HL8KkIIHX61h5ikyHsQMHIRw/W0EI+sVkmU
         qDOpf+lMF64j8s4EMXu0z2//HnqHC5/AN6+o3WKKCp04ih6fjovnjPA899BhLzO/Ka7u
         AN5/5TyJ5ru6tsVuBTLThBiDkrDe/43ZxBVNaWvV6LeRld6mBmRRk58ItVRVKMtHsmpS
         hbGkRQngInFKWjUnJ8YqQeTfSnVNGGUcPV0CwBgB0p33RQT3I4NMlfaommUxnIeIwdZN
         1hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749898; x=1776354698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=heTdVbAqXxGifzvVsjx1/Xn0owg2Ddsba/xSJwhQIxo=;
        b=ifnR6CYc2hDlE9k1dqC/reejjdbmL/riiRLVmEK5/yTmGWAAMRGQgaR9MMqCpv3OKU
         e2BhDci/ds3jpD8IrUjyvwADmqA9AZL6s7GLZtpCWI51tKMVZMiqTZUQ/vmaSDBZYNPG
         2sN3mqedQWvdDSt2Y6aZFfVy3Sy02UVrntkbMAJ6OSZs1gTHEWf960+kiRDmwt8GB6Vd
         FdLx4b6U7pq/cRaHWtazIvgXsNATncM3nRyhbs0AfK8iOGZ/WTE83FYdU/jeFCPiXYED
         du/b4AmdksAmvcA8MyJ3NcGBYvYUUuUhB272ijwJz/fIrVzOkzQSxWDiJczl7exF+SGY
         WCnw==
X-Gm-Message-State: AOJu0YzFoZn1+Lsc3Zg708F4/XysOQUWZ1RkQXndBPAGYrXCe5Ln9U7w
	OqQsVuxnhr140qZ/7bvK491luLBDdMQrlcs8/kAXB9Eey3x/pFe6NfbIHhy2sAo2
X-Gm-Gg: AeBDietwiOZo7/A77FjWfcM6XNhveZqiWrGpqAvfq73/7ceAy684eOavdEtgfVa1+vH
	ytumN9U8mONZOvEecvrL1JEHuyQwGDJ1CPnf92sHvzEezx/BOkSFNN7/RzGXTbVHb+aEQX8Dbb1
	Y+D/DyRYxmoxYUvZiXmHBcLLUbWcmthOAlhNU6IswA2BRPgzy87yHZhg5FfYTlxRr/aWdrLdt+N
	0vXdBgg9LnThGtYfHrAztkqOdcDlIpr7QSUTXDB9PSeBfVFDCLEUZiz3coj4Q7p6SDcyK3mSz8l
	xXx+rkhnN5D+F/NNlox8w9JkfvNNcxqXH5RDb3FdHYPYkini9daLV6gue7bfm5IvLhXNw6Te7BV
	5WvJ/2O8QfMs/e7BbR23wYzNn3ZZC50yEauGONK0mPjMHn80UNTfG9MXDVyPmnraAsclce0WZRr
	3oO3hdgAtpqTJcVwPCSXZbOsFMPX9yoLaRjEgWVYq8Zr9W59V78xigrSkLAh5u
X-Received: by 2002:a17:903:90f:b0:2b0:5cb4:d89d with SMTP id d9443c01a7336-2b2c73fc6a6mr46470085ad.29.1775749897717;
        Thu, 09 Apr 2026 08:51:37 -0700 (PDT)
Received: from Artemesia.lan.iiitm.ac.in ([14.139.240.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749b66aasm254446845ad.68.2026.04.09.08.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:51:37 -0700 (PDT)
From: priyena.programming@gmail.com
To: linux-erofs@lists.ozlabs.org
Cc: Transcendental-Programmer <priyena.programming@gmail.com>
Subject: [PATCH] erofs-rs: fix inline xattr size for tail offsets
Date: Thu,  9 Apr 2026 15:48:35 +0000
Message-ID: <20260409154835.18533-1-priyena.programming@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPXyYWf=J5iyZS=ZRtC-mOePzcc-nq-i7P6wQuw2tqDAr9+obw@mail.gmail.com>
References: <CAPXyYWf=J5iyZS=ZRtC-mOePzcc-nq-i7P6wQuw2tqDAr9+obw@mail.gmail.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=disabled version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3248-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[priyenaprogramming@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 01C9E3CD205
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Transcendental-Programmer <priyena.programming@gmail.com>

---
 erofs/src/async/filesystem.rs | 64 ++++++++++++++++++++++++++++++++++-
 erofs/src/filesystem.rs       | 53 +++++++++++++++++++++++++++--
 erofs/src/sync/filesystem.rs  | 34 ++++++++++++++++++-
 erofs/src/types.rs            |  7 ++++
 4 files changed, 153 insertions(+), 5 deletions(-)

diff --git a/erofs/src/async/filesystem.rs b/erofs/src/async/filesystem.rs
index 1987f09..c791b49 100644
--- a/erofs/src/async/filesystem.rs
+++ b/erofs/src/async/filesystem.rs
@@ -1,5 +1,7 @@
 use alloc::format;
 use alloc::vec::Vec;
+use binrw::{BinRead, io::Cursor};
+use core::mem::size_of;
 use typed_path::Component;
 
 use bytes::Buf;
@@ -83,6 +85,44 @@ impl<I: AsyncImage> EroFS<I> {
         self.core.block_size
     }
 
+    async fn xattr_ibody_size(&self, inode: &Inode) -> Result<usize> {
+        let total_count = inode.xattr_count();
+        if total_count == 0 {
+            return Ok(0);
+        }
+
+        let inode_offset = self.core.get_inode_offset(inode.id()) as usize;
+        let xattr_start = inode_offset + inode.size();
+
+        let mut header_buf = vec![0u8; size_of::<XattrHeader>()];
+        self.image.read_exact_at(&mut header_buf, xattr_start).await?;
+        let header = XattrHeader::read(&mut Cursor::new(&header_buf))?;
+
+        let shared_count = header.shared_count as usize;
+        let total = total_count as usize;
+        if shared_count > total {
+            return Err(Error::CorruptedData(
+                "xattr shared count exceeds total count".to_string(),
+            ));
+        }
+
+        let mut offset = xattr_start + size_of::<XattrHeader>() + shared_count * size_of::<u32>();
+        let inline_count = total - shared_count;
+        for _ in 0..inline_count {
+            let mut entry_buf = vec![0u8; size_of::<XattrEntry>()];
+            self.image.read_exact_at(&mut entry_buf, offset).await?;
+            let entry = XattrEntry::read(&mut Cursor::new(&entry_buf))?;
+            offset += size_of::<XattrEntry>();
+
+            let payload = entry.name_len as usize + entry.value_len as usize;
+            offset = offset
+                .checked_add(payload)
+                .ok_or_else(|| Error::CorruptedData("xattr size overflow".to_string()))?;
+        }
+
+        Ok(offset - xattr_start)
+    }
+
     pub async fn get_inode(&self, nid: u64) -> Result<Inode> {
         let offset = self.core.get_inode_offset(nid) as usize;
         let mut buf = vec![0u8; InodeExtended::size()];
@@ -91,7 +131,29 @@ impl<I: AsyncImage> EroFS<I> {
     }
 
     pub(crate) async fn read_inode_block(&self, inode: &Inode, offset: usize) -> Result<Vec<u8>> {
-        match self.core.plan_inode_block_read(inode, offset)? {
+        let layout = inode.layout()?;
+        let xattr_size = if inode.xattr_count() == 0 {
+            0
+        } else {
+            match layout {
+                Layout::FlatInline => {
+                    let block_count = inode.data_size().div_ceil(self.core.block_size);
+                    let block_index = offset / self.core.block_size;
+                    if block_count != 0 && block_index == block_count - 1 {
+                        self.xattr_ibody_size(inode).await?
+                    } else {
+                        0
+                    }
+                }
+                Layout::ChunkBased => self.xattr_ibody_size(inode).await?,
+                _ => 0,
+            }
+        };
+
+        match self
+            .core
+            .plan_inode_block_read(inode, offset, xattr_size)?
+        {
             BlockPlan::Direct { offset, size } => {
                 if size > self.core.block_size {
                     return Err(Error::CorruptedData(format!(
diff --git a/erofs/src/filesystem.rs b/erofs/src/filesystem.rs
index dfe22aa..d44a5cd 100644
--- a/erofs/src/filesystem.rs
+++ b/erofs/src/filesystem.rs
@@ -1,4 +1,5 @@
 use alloc::{format, string::ToString};
+use core::mem::size_of;
 
 use binrw::BinRead;
 use binrw::BinReaderExt;
@@ -87,7 +88,12 @@ impl EroFSCore {
     /// Returns a `BlockPlan` describing what bytes to read.
     /// For `BlockPlan::Chunked`, the caller must perform an additional
     /// read and call `resolve_chunk_read()`.
-    pub(crate) fn plan_inode_block_read(&self, inode: &Inode, offset: usize) -> Result<BlockPlan> {
+    pub(crate) fn plan_inode_block_read(
+        &self,
+        inode: &Inode,
+        offset: usize,
+        xattr_size: usize,
+    ) -> Result<BlockPlan> {
         match inode.layout()? {
             Layout::FlatPlain => {
                 let block_count = inode.data_size().div_ceil(self.block_size);
@@ -112,7 +118,7 @@ impl EroFSCore {
                     // tail block
                     let inode_offset = self.get_inode_offset(inode.id());
                     let buf_size = inode.data_size() % self.block_size;
-                    let offset = inode_offset as usize + inode.size() + inode.xattr_size();
+                    let offset = inode_offset as usize + inode.size() + xattr_size;
                     return Ok(BlockPlan::Direct {
                         offset,
                         size: buf_size,
@@ -151,7 +157,7 @@ impl EroFSCore {
 
                 let inode_offset = self.get_inode_offset(inode.id());
                 let addr_offset =
-                    inode_offset as usize + inode.size() + inode.xattr_size() + (chunk_index * 4);
+                    inode_offset as usize + inode.size() + xattr_size + (chunk_index * 4);
 
                 Ok(BlockPlan::Chunked {
                     addr_offset,
@@ -201,4 +207,45 @@ impl EroFSCore {
     pub(crate) fn block_offset(&self, block: u32) -> u64 {
         (block as u64) << self.super_block.blk_size_bits
     }
+
+    pub(crate) fn xattr_ibody_size_from_slice(
+        data: &[u8],
+        total_count: u16,
+    ) -> Result<usize> {
+        if total_count == 0 {
+            return Ok(0);
+        }
+
+        let header = XattrHeader::read(&mut Cursor::new(data))?;
+        let shared_count = header.shared_count as usize;
+        let total = total_count as usize;
+        if shared_count > total {
+            return Err(Error::CorruptedData(
+                "xattr shared count exceeds total count".to_string(),
+            ));
+        }
+
+        let mut offset = size_of::<XattrHeader>() + shared_count * size_of::<u32>();
+        let inline_count = total - shared_count;
+        for _ in 0..inline_count {
+            if data.len() < offset + size_of::<XattrEntry>() {
+                return Err(Error::CorruptedData(
+                    "xattr entry header out of range".to_string(),
+                ));
+            }
+
+            let entry = XattrEntry::read(&mut Cursor::new(&data[offset..]))?;
+            offset += size_of::<XattrEntry>();
+
+            let payload = entry.name_len as usize + entry.value_len as usize;
+            if data.len() < offset + payload {
+                return Err(Error::CorruptedData(
+                    "xattr entry payload out of range".to_string(),
+                ));
+            }
+            offset += payload;
+        }
+
+        Ok(offset)
+    }
 }
diff --git a/erofs/src/sync/filesystem.rs b/erofs/src/sync/filesystem.rs
index 2727383..7d94727 100644
--- a/erofs/src/sync/filesystem.rs
+++ b/erofs/src/sync/filesystem.rs
@@ -143,6 +143,16 @@ impl<I: Image> EroFS<I> {
         self.core.block_size
     }
 
+    fn xattr_ibody_size(&self, inode: &Inode) -> Result<usize> {
+        let inode_offset = self.core.get_inode_offset(inode.id()) as usize;
+        let xattr_start = inode_offset + inode.size();
+        let data = self
+            .image
+            .get(xattr_start..)
+            .ok_or_else(|| Error::OutOfBounds("failed to read xattr data".to_string()))?;
+        EroFSCore::xattr_ibody_size_from_slice(data, inode.xattr_count())
+    }
+
     pub fn get_inode(&self, nid: u64) -> Result<Inode> {
         let offset = self.core.get_inode_offset(nid) as usize;
         let data = self
@@ -153,7 +163,29 @@ impl<I: Image> EroFS<I> {
     }
 
     pub(crate) fn get_inode_block(&self, inode: &Inode, offset: usize) -> Result<&[u8]> {
-        match self.core.plan_inode_block_read(inode, offset)? {
+        let layout = inode.layout()?;
+        let xattr_size = if inode.xattr_count() == 0 {
+            0
+        } else {
+            match layout {
+                Layout::FlatInline => {
+                    let block_count = inode.data_size().div_ceil(self.core.block_size);
+                    let block_index = offset / self.core.block_size;
+                    if block_count != 0 && block_index == block_count - 1 {
+                        self.xattr_ibody_size(inode)?
+                    } else {
+                        0
+                    }
+                }
+                Layout::ChunkBased => self.xattr_ibody_size(inode)?,
+                _ => 0,
+            }
+        };
+
+        match self
+            .core
+            .plan_inode_block_read(inode, offset, xattr_size)?
+        {
             BlockPlan::Direct { offset, size } => self
                 .image
                 .get(offset..offset + size)
diff --git a/erofs/src/types.rs b/erofs/src/types.rs
index f4cfcf6..5bb6df1 100644
--- a/erofs/src/types.rs
+++ b/erofs/src/types.rs
@@ -185,6 +185,13 @@ impl Inode {
         }
     }
 
+    pub fn xattr_count(&self) -> u16 {
+        match self {
+            Self::Compact((_, n)) => n.xattr_count,
+            Self::Extended((_, n)) => n.xattr_count,
+        }
+    }
+
     pub fn file_type(&self) -> FileType {
         match self {
             Self::Compact((_, n)) => FileType::from_raw_mode(n.mode as _),
-- 
2.43.0


