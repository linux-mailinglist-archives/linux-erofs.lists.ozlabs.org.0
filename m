Return-Path: <linux-erofs+bounces-3281-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELESDkYa2WnfmAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3281-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 17:41:58 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0EB3D9889
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Apr 2026 17:41:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsgyq0fJhz2ybQ;
	Sat, 11 Apr 2026 01:41:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775835715;
	cv=none; b=SjyM4guZqbsVYMjyRhpLy6zbPfP5cX6RATgjz9RPzwiDqGb8PGwJYz5A1Mn3r0ca9YAYY6uyN7fxMqZ3RqBWmihk0oudVQ7o4f2sIRsTOXTgT/GPxPXEs/OUIoXIb19y9Joryv+v9jvsd6IAFKix5vOBJxZKxrNoGHTeNMRNgSyJQhEDtzuqY0JBNFfGEi0uWgp9nw3cQUViRDsIzzpr7JQDtkACPkqOO2dy3/7EWKv5pcGX0aBZX9dfZF8wm3nMDDn/rjFbBP2mCyInRic1KPpHDL18qNszSxWCmnLBOQyUXkpxrSPN3DlHi5W05urVOYDynhc6bKWEwtQ0UiWRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775835715; c=relaxed/relaxed;
	bh=heTdVbAqXxGifzvVsjx1/Xn0owg2Ddsba/xSJwhQIxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg4kIrLWS1B7O7upgmYLINL1sg80Dfk97+SmaK7xCNy/KTz7k+20cviYlHCd4HzAYbDvRZjZLZ3UEU6FfWiL2NCNG7q3+Q8b4V2vMEP+bG3c9u3keJ+1BXPcP/gTkdjwxR3VdJfsEUb6H0qV5hUa6dQCnw51D7LkUnuMdJELiz9+kaIxFKhQ3Nl+YVoa0+qRguZcTXXUsxR6icvHv92nLpG40NMyWWkho1uhLg7CUEzk8H4tQwCykRoToUuKoK77Ptly3SiXG1r8AE/9TGvkRUAKpeAsZ308OOXVDgQEeY50oAcMdbV2/bd3Jj8pQXJ5eCp/QXReG10QbzjUivULSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nogztmWg; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=priyena.programming@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nogztmWg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=priyena.programming@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsgyn2rMYz2yZ6
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Apr 2026 01:41:53 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so1455444a12.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775835711; x=1776440511; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heTdVbAqXxGifzvVsjx1/Xn0owg2Ddsba/xSJwhQIxo=;
        b=nogztmWgc/Ij/qfIBDoiDviKK7hHIpyMpxxCnZrREEHUvcMdOmS/sEPbYkxncCEON0
         jaAaEIVgcZ52tkfO0iysXS9dJxKlDy0bpjoax2TLF1CDa1mX8Mr1/VQ86v7/UfptnzAV
         o8P4HQ9s8CmCyOCVu9cCrDNl3LiEnWgGUCtmpx2XRlUN8ACyIhVZ+WNOd99m9Amau+O1
         yp4lyb9cNbe5YZPStOMXRUJimMwXEILH1D8K/6/V1vZ48WQ29/RrTDBwMyU019cz6Jic
         q9p5mKtSAcXsiPbHGh+bfemcJFuSDOKMlzkDloc23U8xaLx1DY8t48sEM9rvemNo1eCp
         Caew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775835711; x=1776440511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=heTdVbAqXxGifzvVsjx1/Xn0owg2Ddsba/xSJwhQIxo=;
        b=szjgU9TGcotzGv7BQRQAAj704baKwACR/VW+1k+GoLuhMkHyFZ4SbxGRpw4Ct3ZaOb
         ETga4oDIBG/l2WnmM+qoR7vuqYzfVWvGkIODMKmdVdBb7056p5/PRvFKfOsEVnt+lVVS
         jfYTESIh6vxxYab/9tlBRgVqTnxSbMSYHPxteB9NsQeUx/4z8CQPw6VsBnBTBuZMcjXa
         GnfOt9Cfhr5QfMYbHh4Qk01QEZSty9YwnTGH30SdtKif3FiYDfZPkbFa5vouU5Lb7n8Y
         1dpYV2blps6TxfUSB1Dq+A0+/61IfIN0oDE3kWW+QC0U5zdm7DJBfeFZGs5qmofRf+DY
         LSXg==
X-Gm-Message-State: AOJu0YxwSPz4BHt45qPaMXEY9sWs2V+waKBeWPswUp8EoHDfg5rLh4C7
	WhNt8svaUc77/S4xQTAXGAGPgHhd/lUuLEkifSkJ3XnKFPwqcRkodh5isRmBxkIf
X-Gm-Gg: AeBDieumV6bTXmuMDO8B6wxUNSe8HmU8hOwLJi55U9M76KFqTlPcsvRC9ESo8XTnNZX
	YQKovOvvOvsUe/p1v+kmagjgGVYJEYTpYDMXoe8ONjQQeeQOJZec5DzpnoEgs9byg92vrSdVkVt
	oDw5QbZBaZWJe2JkPkfl9apyt1WJkBcPbf6KzOGXHxDLs4bEWS/4YaB73jEeMpIqU8Bbf6pKwR4
	u+qWp05nz0iy08blpjh2FoVvhVzXpmF4Xi16c2zWDxgvy/stXwQEg9wIuFwbBj2hfBZ+VQqDZtB
	joDWBN5v+P5UddHA3k2OAVyd7ItqWBy+iNy9w2BOnjf+w2RRpT9lMporfQJbKw129k18eVSaYoB
	3OjQHpKKJoG48n7Z+0/z+e1ZJL9/5a2/26XzdvjjGFPWkS5hcYoG1Q782R+CVmPUFts8J+6Q7vg
	JDrwnS2n2giyPVdhdy7suo8SpgpAhK7WfgI8g2kwS9xWScBBT3lI7/lPvfWc/I
X-Received: by 2002:a17:902:cf08:b0:2b2:6df1:1108 with SMTP id d9443c01a7336-2b2d59a34bcmr39084445ad.15.1775835710674;
        Fri, 10 Apr 2026 08:41:50 -0700 (PDT)
Received: from Artemesia.lan.iiitm.ac.in ([14.139.240.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm34040025ad.71.2026.04.10.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:41:50 -0700 (PDT)
From: priyena.programming@gmail.com
To: linux-erofs@lists.ozlabs.org
Cc: Transcendental-Programmer <priyena.programming@gmail.com>
Subject: [PATCH v2] erofs-rs: fix inline xattr size for tail offsets
Date: Fri, 10 Apr 2026 15:41:36 +0000
Message-ID: <20260410154136.16916-1-priyena.programming@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409154835.18533-1-priyena.programming@gmail.com>
References: <20260409154835.18533-1-priyena.programming@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3281-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 4F0EB3D9889
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


