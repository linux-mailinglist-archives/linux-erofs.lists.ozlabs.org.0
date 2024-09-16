Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AAF97A321
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726494968;
	bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=gtsusZc/XnpYtPcZHcjJvYK3PdTFvn2aCDwTBs8w4kPuIE0MB7Dm+kILxiy/D8qfG
	 whBfHIvx1cZM4MZ0zeGFYJQA7wsAKSf/NO6aBENhcgw+8DmRFBF7XMxJkvJ4Od9XTx
	 ktzvYCftPXRJlTs7CvCIREObtdkpmnYtEb5k0nkEjNffLR24hu3EStVGVjdmnkh2+c
	 MZsy+MktoHE7hvLPpkd8ABBfyjdeW087uOluHTyZZmTlcDC1cldJeOwu3523QWhhee
	 R1ukzUiELGyYnsHnZbKLdRPdGkA6xJFsNL4qVeiHuyicrKQPyMJxouHN9lKVOhWFKy
	 jIPTdFtGpgdhQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfJ5MSCz2yZ0
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726494963;
	cv=none; b=CII7TrckLc55Y0J/mvEjJ3GXDTGCjloaE4b3ad8UoYU75da0cmM8eJKhHi2v8WLl+fpcmkO3gkilpSb6+bA0D3wOetOPMCAkyFy7uFdTpe2+TzI4dONilMRZ7hjC7g6pc4rq3zEEZ5frhhbl8+mnPi3uZgJw47J1+cMZrgRWoKntAjvpS6nqgohhPAu40XZo/XNBagEMIpyhX9VT+Ra5Yga2dZ9NH795pG4wcClAFij625q0oWu1zDgNF1ys3VuSWzHkY/8NudDZAuFhTdMla+VXuV8MN3TxXL9dFNyH+zzAqPEshwUqVFq8Ub+XXJofR8jFUYyL+tYpTPVFiHCPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726494963; c=relaxed/relaxed;
	bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gBTdMCYS1bFyuWX27e5zNmgHkWEV12rQKiJPi8sJf1irVdRFPpsRCh0Gaf+rBs7xLHceleJTBmMX8fcLE0m2aXYaw6se/mIeH1vtQ3Dc8xXO0ijTNVyYoaKIErP0V+CHHV7zntp4xBPfBeLCR6JuATkRA6rYjrFQI/FgeUbHB4xoFtNkTowzM/I8oMSjBDd960NO7G14mqn+LtCzU5QHh/B79UYz0Ca5UD/TErCs58/+7nBVT42Bg+M18hQc2X+Xe1iViOEmTOVld4dfKg5TP/kJW/dGjxr+rc9k7ssix9W3MXIpezLOzYlf1IGtBhLDE9aO20NkF+0kNFBPYZUG4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=l6a/8fFj; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=l6a/8fFj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfB71F3z2yNB
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:02 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E19169799;
	Mon, 16 Sep 2024 09:55:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494958; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	b=l6a/8fFj2/PvQcWCumcQLWs2m5I0tlDX/65VILGQQKYi8aivsrOhhRmPbEhIWSwy4G5tc9
	FEy3khtCymynox7uYG5voXxoUprQ9XT7tjzBt19wsycB0oPtWGnommd0NpOIqgsrr9fQoH
	tgkj/JxaFTA7xoargGoa9vT5Yr7VVzi0VTpax2W1Se5vP17Rba41skQfXkMf2NL/YLRyQD
	hN4CfgqgiZt2NhT1PgsnAoocTELhDXiaNxresJdBEgPUrhA0qLA7Yx3afrCms3k/Kq+MKy
	965KUhba0fwMQUtEDzLWnhPxLAJIZ8cKGAO5lUOKx4Sk8ogSg5CXjXB8iLMdeQ==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 00/24] erofs: introduce Rust implementation
Date: Mon, 16 Sep 2024 21:55:17 +0800
Message-ID: <20240916135541.98096-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
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

Greetings,

So here is a patchset to add Rust skeleton codes to the current EROFS
implementation. The implementation is deeply inspired by the current C 
implementation, and it's based on a generic erofs_sys crate[1] written
by me. The purpose is to potentially replace some of C codes to make
to make full use of Rust's safety features and better
optimization guarantees.

Many of the features (like compression inodes) still
fall back to C implementation because of my limited time and lack of
Rust counterparts. However, the Extended Attributes work purely in Rust.

Some changes are done to the original C code.
1) Some of superblock operations are modified slightly to make sure
memory allocation and deallocation are done correctly when interacting
with Rust.
2) A new rust_helpers.c file is introduced to help Rust to deal with
self-included EROFS API without exporting types that are not
interpreted in Rust.
3) A new rust_bindings.h is introduced to provide Rust functions
externs with the same function signature as Rust side so that
C-side code can use the bindings easily.
4) CONFIG_EROFS_FS_RUST is added in dir.c, inode.c, super.c, data.c,
and xattr.c to allow C code to be opt out and uses Rust implementation.
5) Some macros and function signatures are tweaked in internal.h
with the compilation options.

Note that, since currently there is no mature Rust VFS implementation
landed upstream, this patchset only uses C bindings internally and
each unsafe operation is examined. This implementation only offers
C-ABI-compatible functions impls and gets its exposed to original C
implementation as either hooks or function pointers.

Also note that, this patchset only uses already-present self-included
EROFS API and it uses as few C bindings generated from bindgen as
possible, only inode, dentry, file and dir_context related are used,
to be precise.

Since the EROFS community is pretty interested in giving Rust a try,
I think this patchset will be a good start for Rust EROFS.

This patchset is based on the latest EROFS development tree.
And the current codebase can also be found on my github repo[2].

[1]: https://github.com/ToolmanP/erofs-rs
[2]: https://github.com/ToolmanP/erofs-rs-linux

Yiyang Wu (24):
  erofs: lift up erofs_fill_inode to global
  erofs: add superblock data structure in Rust
  erofs: add Errno in Rust
  erofs: add xattrs data structure in Rust
  erofs: add inode data structure in Rust
  erofs: add alloc_helper in Rust
  erofs: add data abstraction in Rust
  erofs: add device data structure in Rust
  erofs: add continuous iterators in Rust
  erofs: add device_infos implementation in Rust
  erofs: add map data structure in Rust
  erofs: add directory entry data structure in Rust
  erofs: add runtime filesystem and inode in Rust
  erofs: add block mapping capability in Rust
  erofs: add iter methods in filesystem in Rust
  erofs: implement dir and inode operations in Rust
  erofs: introduce Rust SBI to C
  erofs: introduce iget alternative to C
  erofs: introduce namei alternative to C
  erofs: introduce readdir alternative to C
  erofs: introduce erofs_map_blocks alternative to C
  erofs: add skippable iters in Rust
  erofs: implement xattrs operations in Rust
  erofs: introduce xattrs replacement to C

 fs/erofs/Kconfig                              |  10 +
 fs/erofs/Makefile                             |   4 +
 fs/erofs/data.c                               |   5 +
 fs/erofs/data_rs.rs                           |  63 +++
 fs/erofs/dir.c                                |   2 +
 fs/erofs/dir_rs.rs                            |  57 ++
 fs/erofs/inode.c                              |  10 +-
 fs/erofs/inode_rs.rs                          |  64 +++
 fs/erofs/internal.h                           |  47 ++
 fs/erofs/namei.c                              |   2 +
 fs/erofs/namei_rs.rs                          |  56 ++
 fs/erofs/rust/erofs_sys.rs                    |  47 ++
 fs/erofs/rust/erofs_sys/alloc_helper.rs       |  35 ++
 fs/erofs/rust/erofs_sys/data.rs               |  70 +++
 fs/erofs/rust/erofs_sys/data/backends.rs      |   4 +
 .../erofs_sys/data/backends/uncompressed.rs   |  39 ++
 fs/erofs/rust/erofs_sys/data/raw_iters.rs     | 127 +++++
 .../rust/erofs_sys/data/raw_iters/ref_iter.rs | 131 +++++
 .../rust/erofs_sys/data/raw_iters/traits.rs   |  17 +
 fs/erofs/rust/erofs_sys/devices.rs            |  75 +++
 fs/erofs/rust/erofs_sys/dir.rs                |  98 ++++
 fs/erofs/rust/erofs_sys/errnos.rs             | 191 +++++++
 fs/erofs/rust/erofs_sys/inode.rs              | 398 ++++++++++++++
 fs/erofs/rust/erofs_sys/map.rs                |  99 ++++
 fs/erofs/rust/erofs_sys/operations.rs         |  62 +++
 fs/erofs/rust/erofs_sys/superblock.rs         | 514 ++++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs     |  94 ++++
 fs/erofs/rust/erofs_sys/xattrs.rs             | 272 +++++++++
 fs/erofs/rust/kinode.rs                       |  76 +++
 fs/erofs/rust/ksources.rs                     |  66 +++
 fs/erofs/rust/ksuperblock.rs                  |  30 +
 fs/erofs/rust/mod.rs                          |   7 +
 fs/erofs/rust_bindings.h                      |  39 ++
 fs/erofs/rust_helpers.c                       |  86 +++
 fs/erofs/rust_helpers.h                       |  23 +
 fs/erofs/super.c                              |  51 +-
 fs/erofs/super_rs.rs                          |  59 ++
 fs/erofs/xattr.c                              |  31 +-
 fs/erofs/xattr.h                              |   7 +
 fs/erofs/xattr_rs.rs                          | 106 ++++
 40 files changed, 3153 insertions(+), 21 deletions(-)
 create mode 100644 fs/erofs/data_rs.rs
 create mode 100644 fs/erofs/dir_rs.rs
 create mode 100644 fs/erofs/inode_rs.rs
 create mode 100644 fs/erofs/namei_rs.rs
 create mode 100644 fs/erofs/rust/erofs_sys.rs
 create mode 100644 fs/erofs/rust/erofs_sys/alloc_helper.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/backends/uncompressed.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/ref_iter.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/raw_iters/traits.rs
 create mode 100644 fs/erofs/rust/erofs_sys/devices.rs
 create mode 100644 fs/erofs/rust/erofs_sys/dir.rs
 create mode 100644 fs/erofs/rust/erofs_sys/errnos.rs
 create mode 100644 fs/erofs/rust/erofs_sys/inode.rs
 create mode 100644 fs/erofs/rust/erofs_sys/map.rs
 create mode 100644 fs/erofs/rust/erofs_sys/operations.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/mem.rs
 create mode 100644 fs/erofs/rust/erofs_sys/xattrs.rs
 create mode 100644 fs/erofs/rust/kinode.rs
 create mode 100644 fs/erofs/rust/ksources.rs
 create mode 100644 fs/erofs/rust/ksuperblock.rs
 create mode 100644 fs/erofs/rust/mod.rs
 create mode 100644 fs/erofs/rust_bindings.h
 create mode 100644 fs/erofs/rust_helpers.c
 create mode 100644 fs/erofs/rust_helpers.h
 create mode 100644 fs/erofs/super_rs.rs
 create mode 100644 fs/erofs/xattr_rs.rs

-- 
2.46.0

