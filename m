Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B0597A323
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494975;
	bh=ZuP3bujGZDBP75xkwLAFw1ksH6b/fY1knDKclkC/wOs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=f6f/Zq66Xhpshpuv2LH7HpqtAfgCSL5l1XrgV6HgNNTFq6xnukK4Y4+CFEPirXmkV
	 qD3Zla9AtGP9iswM4IGqyc185816gOQK/sRa+yHGYd+W2xAhyoaJyqZqhqmieMYKLB
	 gRjHupskzqomXWLoSSxleKt1i7bM7yypX/6e49es2usYn2jLLbBgT0n0NprPY+LgdH
	 QK7CVZUwEwd/c000OEYUUQHKEYWmuFGWi9X/hDFsSxByTKHabGFE7H5EJTHJqdzNQX
	 WrL1JY3ptCEDq1HwzHFl7ahD88g/IwIA9gfiDcRLhiKpzfNzWDPXBNYOOu0ocenBEq
	 XEY0VuDrcVwRA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfR2NPYz3c5Z
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494968;
	cv=none; b=IKJpdijmoKj803sTv6PFZUCj6sGgEmVGnC0WvT2b0xxu/qYKybPe+E6LZv1PphVcVXzzA62FLFoJsrXPmTiiIRN7M/Jlm/A4ZzQYn/O/HnbQg49z+lOZrrK/kXG8LG1NgzOVPtZ0XYrTlBQsghVvrywq7QM9+fmhPLRbAoU7ib69gbzMD4ZeAv1DXhKkbzgAJOVi73C4Ds3DV2s3njOuh4lVAExsz3n3Hf3SIPouTDuErDiX3TqSoqQGJz2svCyxTGiur1ONy3Y90PIpXdvybwSTHBtdXM/vKpwcyJRvy/yI30uprnWca+QjCDZpn4Edmvh+85HrHWxtHSPqKCd5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494968; c=relaxed/relaxed;
	bh=ZuP3bujGZDBP75xkwLAFw1ksH6b/fY1knDKclkC/wOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlRp/xx5q2HqSl0cJ0qbS6QszX74y3SZbii96+opk9lScnyKwUqSjhZJDGXG41i0T/+Q+HpTDcHRTAVhfutQ1jhN+MfSsP/cmkJYeIO2fN9vV3hdYhlNb3VqoyzmUiyUaEoEmGDpDswXEboPG3JOToWhxF9IjosraNDBn1rEUZjRgB8nBFnLjNcjkeTFHd6zZCLmBuJRTnZXa8i7y3DWg9OVF0QwSK0Qx9O8sNwFcqPUELLQNxyvLq15sIf2hSybGakqO+dhpCVkg82F91Bgw0yfL3olHRN2RCQF+PvGjbyyEeTQBLKdwHU7fbVr3WFv7oRBWv7YEGH/DgnyjpLAjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gyk0nQmk; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=gyk0nQmk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfJ2cztz2yNs
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:08 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EAF26997C;
	Mon, 16 Sep 2024 09:56:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494966; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZuP3bujGZDBP75xkwLAFw1ksH6b/fY1knDKclkC/wOs=;
	b=gyk0nQmkxsEqOOxgE8ynnJjvoHp7k6fjXxzCvSyGQOfo+h9L0F5KJATkjaAn0pWRdTQET5
	Ue3ZEkO9CNHy3yU0EEktidTpqs37MehOPJvMo1OfE+r8OWe6W5R1FAYIvXTk5R8vhMjngK
	/kFb/8wgj2A7qaVWEbHumKFTmOLw8Tx8NoSubGjhKlKjao3eo63ffH2xIeH5/GERY/SBwX
	I6N6IBG8vCe67HLzkEbYvzW3UmEaM+97jK8Ojlckv7G71Hyh54Ug2Ny5UMibB1ln0qr6yg
	tfFRmmQzVy8oFe/9IV0xkW75hEIocoxCZQWudbMlxHk8N6O/NkaKhZcC7gKfqQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 03/24] erofs: add Errno in Rust
Date: Mon, 16 Sep 2024 21:55:20 +0800
Message-ID: <20240916135541.98096-4-toolmanp@tlmp.cc>
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

Introduce Errno to Rust side code. Note that in current Rust For Linux,
Errnos are implemented as core::ffi::c_uint unit structs.
However, EUCLEAN, a.k.a EFSCORRUPTED is missing from error crate.

Since the errno_base hasn't changed for over 13 years,
This patch merely serves as a temporary workaround for the missing
errno in the Rust For Linux.

Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/rust/erofs_sys.rs        |   6 +
 fs/erofs/rust/erofs_sys/errnos.rs | 191 ++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+)
 create mode 100644 fs/erofs/rust/erofs_sys/errnos.rs

diff --git a/fs/erofs/rust/erofs_sys.rs b/fs/erofs/rust/erofs_sys.rs
index 0f1400175fc2..2bd1381da5ab 100644
--- a/fs/erofs/rust/erofs_sys.rs
+++ b/fs/erofs/rust/erofs_sys.rs
@@ -19,4 +19,10 @@
 pub(crate) type Nid = u64;
 /// Erofs Super Offset to read the ondisk superblock
 pub(crate) const EROFS_SUPER_OFFSET: Off = 1024;
+/// PosixResult as a type alias to kernel::error::Result
+/// to avoid naming conflicts.
+pub(crate) type PosixResult<T> = Result<T, Errno>;
+
+pub(crate) mod errnos;
 pub(crate) mod superblock;
+pub(crate) use errnos::Errno;
diff --git a/fs/erofs/rust/erofs_sys/errnos.rs b/fs/erofs/rust/erofs_sys/errnos.rs
new file mode 100644
index 000000000000..40e5cdbcb353
--- /dev/null
+++ b/fs/erofs/rust/erofs_sys/errnos.rs
@@ -0,0 +1,191 @@
+// Copyright 2024 Yiyang Wu
+// SPDX-License-Identifier: MIT or GPL-2.0-or-later
+
+#[repr(i32)]
+#[non_exhaustive]
+#[allow(clippy::upper_case_acronyms)]
+#[derive(Debug, Copy, Clone, PartialEq)]
+pub(crate) enum Errno {
+    NONE = 0,
+    EPERM,
+    ENOENT,
+    ESRCH,
+    EINTR,
+    EIO,
+    ENXIO,
+    E2BIG,
+    ENOEXEC,
+    EBADF,
+    ECHILD,
+    EAGAIN,
+    ENOMEM,
+    EACCES,
+    EFAULT,
+    ENOTBLK,
+    EBUSY,
+    EEXIST,
+    EXDEV,
+    ENODEV,
+    ENOTDIR,
+    EISDIR,
+    EINVAL,
+    ENFILE,
+    EMFILE,
+    ENOTTY,
+    ETXTBSY,
+    EFBIG,
+    ENOSPC,
+    ESPIPE,
+    EROFS,
+    EMLINK,
+    EPIPE,
+    EDOM,
+    ERANGE,
+    EDEADLK,
+    ENAMETOOLONG,
+    ENOLCK,
+    ENOSYS,
+    ENOTEMPTY,
+    ELOOP,
+    ENOMSG = 42,
+    EIDRM,
+    ECHRNG,
+    EL2NSYNC,
+    EL3HLT,
+    EL3RST,
+    ELNRNG,
+    EUNATCH,
+    ENOCSI,
+    EL2HLT,
+    EBADE,
+    EBADR,
+    EXFULL,
+    ENOANO,
+    EBADRQC,
+    EBADSLT,
+    EBFONT = 59,
+    ENOSTR,
+    ENODATA,
+    ETIME,
+    ENOSR,
+    ENONET,
+    ENOPKG,
+    EREMOTE,
+    ENOLINK,
+    EADV,
+    ESRMNT,
+    ECOMM,
+    EPROTO,
+    EMULTIHOP,
+    EDOTDOT,
+    EBADMSG,
+    EOVERFLOW,
+    ENOTUNIQ,
+    EBADFD,
+    EREMCHG,
+    ELIBACC,
+    ELIBBAD,
+    ELIBSCN,
+    ELIBMAX,
+    ELIBEXEC,
+    EILSEQ,
+    ERESTART,
+    ESTRPIPE,
+    EUSERS,
+    ENOTSOCK,
+    EDESTADDRREQ,
+    EMSGSIZE,
+    EPROTOTYPE,
+    ENOPROTOOPT,
+    EPROTONOSUPPORT,
+    ESOCKTNOSUPPORT,
+    EOPNOTSUPP,
+    EPFNOSUPPORT,
+    EAFNOSUPPORT,
+    EADDRINUSE,
+    EADDRNOTAVAIL,
+    ENETDOWN,
+    ENETUNREACH,
+    ENETRESET,
+    ECONNABORTED,
+    ECONNRESET,
+    ENOBUFS,
+    EISCONN,
+    ENOTCONN,
+    ESHUTDOWN,
+    ETOOMANYREFS,
+    ETIMEDOUT,
+    ECONNREFUSED,
+    EHOSTDOWN,
+    EHOSTUNREACH,
+    EALREADY,
+    EINPROGRESS,
+    ESTALE,
+    EUCLEAN,
+    ENOTNAM,
+    ENAVAIL,
+    EISNAM,
+    EREMOTEIO,
+    EDQUOT,
+    ENOMEDIUM,
+    EMEDIUMTYPE,
+    ECANCELED,
+    ENOKEY,
+    EKEYEXPIRED,
+    EKEYREVOKED,
+    EKEYREJECTED,
+    EOWNERDEAD,
+    ENOTRECOVERABLE,
+    ERFKILL,
+    EHWPOISON,
+    EUNKNOWN,
+}
+
+impl From<i32> for Errno {
+    fn from(value: i32) -> Self {
+        if (-value) <= 0 || (-value) > Errno::EUNKNOWN as i32 {
+            Errno::EUNKNOWN
+        } else {
+            // Safety: The value is guaranteed to be a valid errno and the memory
+            // layout is the same for both types.
+            unsafe { core::mem::transmute(value) }
+        }
+    }
+}
+
+impl From<Errno> for i32 {
+    fn from(value: Errno) -> Self {
+        -(value as i32)
+    }
+}
+
+/// Replacement for ERR_PTR in Linux Kernel.
+impl From<Errno> for *const core::ffi::c_void {
+    fn from(value: Errno) -> Self {
+        (-(value as core::ffi::c_long)) as *const core::ffi::c_void
+    }
+}
+
+impl From<Errno> for *mut core::ffi::c_void {
+    fn from(value: Errno) -> Self {
+        (-(value as core::ffi::c_long)) as *mut core::ffi::c_void
+    }
+}
+
+/// Replacement for PTR_ERR in Linux Kernel.
+impl From<*const core::ffi::c_void> for Errno {
+    fn from(value: *const core::ffi::c_void) -> Self {
+        (-(value as i32)).into()
+    }
+}
+
+impl From<*mut core::ffi::c_void> for Errno {
+    fn from(value: *mut core::ffi::c_void) -> Self {
+        (-(value as i32)).into()
+    }
+}
+/// Replacement for IS_ERR in Linux Kernel.
+#[inline(always)]
+pub(crate) fn is_value_err(value: *const core::ffi::c_void) -> bool {
+    (value as core::ffi::c_ulong) >= (-4095 as core::ffi::c_long) as core::ffi::c_ulong
+}
-- 
2.46.0

