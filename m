Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA8997A330
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 15:56:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1726495003;
	bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=OcMhBds9aV6c8ON5UjxZWMAA6Dj9Muw2J/Je+QkAVvRoiRLHR3BDQLuICAXcZCL1a
	 pX3V4HUwNRFm1CqcnG7AZ2ICGOSvynLt/sSQiTLrdprPQ2pEckhiQku8YBp6fuErKY
	 ZopB039000VyZmPPLmyeVLp6NjB/YlQqFhKlwZaR2FVpeBOPevOpJ3+JfX2tF5L0We
	 1O91aBFefFpaln74qdsOmhQehIFsjCLQ0OItapbE15Ih1/tcTrNYkeb7Cr18KYZnjn
	 S+QL/U8GAh0zcfgTU3tXQCRUPMHRGveFDgaVK2YnzCg1+eakSEs4iws9GiGfVyBbuS
	 mN3XRGquDE42Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X6mfz1gSVz2yYn
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Sep 2024 23:56:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726495001;
	cv=none; b=PAUlj0Fy4SMkgN6g16eFe0zBfbQZvf/64bms05h8m9D7Gx0C1gnEorfQExWnXhhTXuQgO9AFrf0vI14Pv6p9YIXwkL3kDzdwCp4DKCdGHY0ki4LzJiYfEVPY2hP7IGI3tAj6PgqtxCOEOQ9LK4KUA5eG4YxVVQsd+jnhyNyMSwEpHErdXH+dVVO0nhfgpxL1ibQctolsJa7I/CqjaT1t4ZaxBejr9a6n09P5rJHLk+hK7fO+vDkn2YQhEsul3SITTBoltbl1nTHoOtgj/HoWZu7qsD05jXXsWEJsGZtFx10U7bvvPLtJkVzoIOIvfyefDBqe1UJoN8tZ2s4CsPqOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726495001; c=relaxed/relaxed;
	bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9ldvCFPXEY2y9K+h6kwddrk+AAkBj18J1sAEBmsaR7hT9Cu0Qr2+ibMUDz3Oi37tQtrWAkbKbi12IPQ3MXwQb3xlRZgE3CxiJm7MaKNcQ6Q/NLqPwS+5OjHf73D8mmF4da04bOWmtEIJof/IRYnVa2dxGT6y0e5GxeHcu4vnSFuD/X3rMYbyvfh3HJ1jr8tEv8XLyhGk7Uvgwxtowd2XrUBLeULi2qu2Q9Z6sglIBmGH+PbAb/wcrf0Xa5OwCcO8gZVH7JtVfk6gH539fArU+1Rz4+c2j/2NYAEwrQMoD2fgv528L+s4H9kBdJ3n6ooHLIpyhjK1+bY4PPGxvVj5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=CHuNQItq; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=CHuNQItq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X6mfx0SKjz2yNB
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Sep 2024 23:56:41 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F8CC697C4;
	Mon, 16 Sep 2024 09:56:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1726494998; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=9N+ZQkVun0N8rthsyIs0Y8nbkjuLiSMyhR8LZUW+bjg=;
	b=CHuNQItqrNCjweXqCeNbZP5/y6wuF0Xc8115eDrnJB7j5lXGYwk4ZEMOy2UjK96c7dmskD
	92HPC/jfiE8BXm8pxpIib1HDE14rjwgz+CDN42iMSJtQ4iM+9jHda3MrfpMjDR9oxcCNn/
	IHedfPbtIuwQnpwKyC2NWePYdy8SwnzY7Pg2ndCWl/MDDc1zEwnRonGZXSjltMPebSO+vn
	NfT6u7MwJEyevJp5AZUmBerBMkBezGEekVBpMcnTmonZrovrLv+zwQHw6dKJgrgdo+ciE1
	lAirnygtuKCk9AJfJmfxvRPDkEshevAzSrnXEoSIYk9UVW8d95p4MN6KZT6MvA==
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 00/24] erofs: introduce Rust implementation
Date: Mon, 16 Sep 2024 21:56:10 +0800
Message-ID: <20240916135634.98554-1-toolmanp@tlmp.cc>
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
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org
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

