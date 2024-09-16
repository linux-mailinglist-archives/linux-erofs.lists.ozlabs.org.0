Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4915897A350
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495045;
	bh=iVEpuQCRq5HfW1zEs0Xldj9thdzekA2PSp+UaBg4euk=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=lJHj5A8Mxl5BhEibQro2Y7+6Yx1Sk7kQl9tZPuH8lwd9aHnqVs8J8CiwNMmK9fum4
	 yq3f0pghtKn3p9lZ9BeRqIKLdEci8LWPNGXAzH7PKGVoBtyZ47OVkxVmcshV8gCqe0
	 BMEpTHXZ+MnTnzq/glyVIhHIp+CEnpjBbKY15ssyNwScKsbd/inNWdWjS/Xe5QQHB1
	 LpDbTwaEEFB8Zx3Cwis48AWQXL6eFzsMfy1JmBR0EhHwykbdszIelet9j0cwB+/IIN
	 HoAtEP1dXeElaGff6opT36H4I72e9b4Nm2W+3tYbLm+lqG/Kotc8RVECiPj07TWI6U
	 fHWhpBkLbr64A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mgn14mLz30DD
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:57:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495043;
	cv=none; b=cJjgMTfTdtFqx8yKE2hj3WXuKCeomU6K8MwDu1DTiviHPVt5hD2Ri1DRlO/qsOCjseFoIg0FJGLPt/sxHxiCXU93jLPv3XLXyUZuGpPWkctb7P3R9pPMxEeLODoiLzBXx8JUqymWcI0uGEl7zRiofeEnkmz/595zCxdYDxp/EhqmIBlz9/JfLchd/ycvbxSK0Z33S+aBKiPD4hgJ/s2F1swGrS9mK+9eVNlT6BWF9xVsvkjDOyKocUJdR5MSn5IhMOEy6cKpp4anLWM11/kA5ON2skmMHsQ413JCJWyw7jwklZtTCLWeo/LdcNrSQxZTXHKyhag0Ccd/lZFumC3vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495043; c=relaxed/relaxed;
	bh=iVEpuQCRq5HfW1zEs0Xldj9thdzekA2PSp+UaBg4euk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As3ZizH6c/5NFOdtzH5LxewD4vQN6bvE2XQyXJD8r2qi3uWsXiSMatThOZUVzx65m4MeLw0eOe+xNx6PCfjsTGya+elAujMIsiK8ho+3bdAAzs89Vk2FbMB4iptG3Vov9tOxI1L7i0sPYy6bzv+jscT8xeTB6yolB/35Wwcpeiu3japtyg3hogXa7LDiyoHpyC3/T+HndWNdZQQ6iUeIX9FhzEZj5zLnSKZ3uHlW3AXj8z7lACh3IJF4f2fLblXJYoMZToRNnOf4yqcObq+KasImL5I5clbhLbcUP1BRW7Buj15HgWMHz0K27K0GBaFIjWip+UGK6cXMtgYi95uVHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=X4baUaJu; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=X4baUaJu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mgl2hfDz2yTs
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:57:23 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5407B69846;
	Mon, 16 Sep 2024 09:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726495041; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iVEpuQCRq5HfW1zEs0Xldj9thdzekA2PSp+UaBg4euk=;
	b=X4baUaJuu1m/SZcizjCUwjQXlm2cqf/Wsik3+r0ZAj0Dsx1wUrzzvdWixSm+HzNQVhpbBH
	7pEknBiEY52wUf/Ntn1D1CENrM44nH9qkHp//5Ehmwavc2rz41hCKJmzvvJu/EaCatnECd
	JLUHPJsylOQ+KaMJoiFUzPEuG0L7FP2pJpr7jWA3K5p+MXgtQZdtZSUPqswck7TEIiUNbw
	nkvJzl55CjR5pTO0hjZcoNxb5/ZWgGvAKIUvXmXdvkN5EmtaGUvIbS6FYAFK4fwgVTJDnA
	Vlr6mklfEGHUgfNmXRNtMVyexGCFFXHp20eM31T/GXzyy3MIxL/N+cG21fb/YA==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 22/24] erofs: add skippable iters in Rust
Date: Mon, 16 Sep 2024 21:56:32 +0800
Message-ID: <20240916135634.98554-23-toolmanp@tlmp.cc>
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

This patch introduce self-owned skippable data iterators in Rust.
This iterators will be used to access extended attributes later.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys/data/raw_iters.rs | 121 ++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/fs/erofs/rust/erofs_sys/data/raw_iters.rs b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
index 8f3bd250d252..f1ff0a251596 100644
--- a/fs/erofs/rust/erofs_sys/data/raw_iters.rs
+++ b/fs/erofs/rust/erofs_sys/data/raw_iters.rs
@@ -4,3 +4,124 @@
 pub(crate) mod ref_iter;
 mod traits;
 pub(crate) use traits::*;
+
+use super::*;
+use alloc::boxed::Box;
+
+/// Represents a skippable continuous buffer iterator. This is used primarily for reading the
+/// extended attributes. Since the key-value is flattened out in its original format.
+pub(crate) struct SkippableContinuousIter<'a> {
+    iter: Box<dyn ContinuousBufferIter<'a> + 'a>,
+    data: RefBuffer<'a>,
+    cur: usize,
+}
+
+fn cmp_with_cursor_move(
+    lhs: &[u8],
+    rhs: &[u8],
+    lhs_cur: &mut usize,
+    rhs_cur: &mut usize,
+    len: usize,
+) -> bool {
+    let result = lhs[*lhs_cur..(*lhs_cur + len)] == rhs[*rhs_cur..(*rhs_cur + len)];
+    *lhs_cur += len;
+    *rhs_cur += len;
+    result
+}
+
+#[derive(Debug, Clone, Copy, PartialEq)]
+pub(crate) enum SkipCmpError {
+    PosixError(Errno),
+    NotEqual(Off),
+}
+
+impl From<Errno> for SkipCmpError {
+    fn from(e: Errno) -> Self {
+        SkipCmpError::PosixError(e)
+    }
+}
+
+impl<'a> SkippableContinuousIter<'a> {
+    pub(crate) fn try_new(
+        mut iter: Box<dyn ContinuousBufferIter<'a> + 'a>,
+    ) -> PosixResult<Option<Self>> {
+        if iter.eof() {
+            return Ok(None);
+        }
+        let data = iter.next().unwrap()?;
+        Ok(Some(Self { iter, data, cur: 0 }))
+    }
+    pub(crate) fn skip(&mut self, offset: Off) -> PosixResult<()> {
+        let dlen = self.data.content().len() - self.cur;
+        if offset as usize <= dlen {
+            self.cur += offset as usize;
+        } else {
+            self.cur = 0;
+            self.iter.advance_off(dlen as Off);
+            self.data = self.iter.next().unwrap()?;
+        }
+        Ok(())
+    }
+
+    pub(crate) fn read(&mut self, buf: &mut [u8]) -> PosixResult<()> {
+        let mut dlen = self.data.content().len() - self.cur;
+        let mut bcur = 0_usize;
+        let blen = buf.len();
+        if dlen != 0 && dlen >= blen {
+            buf.clone_from_slice(&self.data.content()[self.cur..(self.cur + blen)]);
+            self.cur += blen;
+        } else {
+            buf[bcur..(bcur + dlen)].copy_from_slice(&self.data.content()[self.cur..]);
+            bcur += dlen;
+            while bcur < blen {
+                self.cur = 0;
+                self.data = self.iter.next().unwrap()?;
+                dlen = self.data.content().len();
+                if dlen >= blen - bcur {
+                    buf[bcur..].copy_from_slice(&self.data.content()[..(blen - bcur)]);
+                    self.cur = blen - bcur;
+                    return Ok(());
+                } else {
+                    buf[bcur..(bcur + dlen)].copy_from_slice(self.data.content());
+                    bcur += dlen;
+                }
+            }
+        }
+        Ok(())
+    }
+
+    pub(crate) fn try_cmp(&mut self, buf: &[u8]) -> Result<(), SkipCmpError> {
+        let dlen = self.data.content().len() - self.cur;
+        let blen = buf.len();
+        let mut bcur = 0_usize;
+
+        if dlen != 0 && dlen >= blen {
+            if cmp_with_cursor_move(self.data.content(), buf, &mut self.cur, &mut bcur, blen) {
+                Ok(())
+            } else {
+                Err(SkipCmpError::NotEqual(bcur as Off))
+            }
+        } else {
+            if dlen != 0 {
+                let clen = dlen.min(blen);
+                if !cmp_with_cursor_move(self.data.content(), buf, &mut self.cur, &mut bcur, clen) {
+                    return Err(SkipCmpError::NotEqual(bcur as Off));
+                }
+            }
+            while bcur < blen {
+                self.cur = 0;
+                self.data = self.iter.next().unwrap()?;
+                let dlen = self.data.content().len();
+                let clen = dlen.min(blen - bcur);
+                if !cmp_with_cursor_move(self.data.content(), buf, &mut self.cur, &mut bcur, clen) {
+                    return Err(SkipCmpError::NotEqual(bcur as Off));
+                }
+            }
+
+            Ok(())
+        }
+    }
+    pub(crate) fn eof(&self) -> bool {
+        self.data.content().len() - self.cur == 0 && self.iter.eof()
+    }
+}
-- 
2.46.0

