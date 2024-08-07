Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3494B000
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2024 20:52:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723056758;
	bh=VuE+XrWYZKA6r4njiDyiADE9cjWnh8lLWOu1Q1x0m7E=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=PqK4sYcce7hxRTX0EVH4TKYz6vZjqTu0J6RauuZk7eaOoLQVQmtBjsjyd4hTX6d9Q
	 YftLzVeMAIk3mBNB7uWNchjnAgP0Nzt1V7545h2XuO+eISlWiY/fKFRTGlmc+Z+nAA
	 ybdH0sd7XWBUYuaBsHNA4sWRt55lAsR0VdKdj1QDHFIUdrFnyuisqix9tKhf6iIK3o
	 bPC38VdlPhkk4mZhOBmMRw2dCi1jDz0+aiQa4X9Z4DGm/V++Jl0YwFFtZBmMq1+Pk5
	 EWbDngzIQ1FZ4S3uLBA2nBc5M4dwtAzpQpgXNnX1n3pyi2J8hamxquet1VhPNdfeCm
	 /2AklqdcdVgxQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfK6t64WGz3dJV
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 04:52:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=h6jea1G0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
X-Greylist: delayed 306 seconds by postgrey-1.37 at boromir; Thu, 08 Aug 2024 04:52:29 AEST
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfK6j636yz3d8M
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2024 04:52:29 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF39A697C5;
	Wed,  7 Aug 2024 14:47:12 -0400 (EDT)
To: hsiangkao@linux.alibaba.com
Subject: [RFC PATCH 0/3] erofs: add rust support
Date: Thu,  8 Aug 2024 02:47:00 +0800
Message-ID: <20240807184703.722206-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.45.2
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is a patchset to add rust skeleton codes to the current Extended
Read-Only File System (erofs) implementation suggested by a recent OSPP
Project[1]. The implementation is deeply inspired by the current C implementation,
and it's based on a generic erofs_sys crate[2] written by me. 

The purpose of this patchset is to provide infrastructure to potentially
replace all of C codes with rust with better maintainability and
performance with the help of Rust's safety features and better
optimization capabilities.

This patchset implements basic I/O operations and it's generally
functional, however i haven't tested all possible testcases (some of
them are chunk-based image files) yet. So it's
welcome to be tested and given supportive reviews.

Many of the "extended" features are disabled by default and still not
implemented yet but some of them have been already implemented in the
crate but kernel-side trait implementations are not ready yet. I'm
considering implementing it in the near future.

Note that, currently Rust VFS patches are still not merged because of the
previous rejections suggested by fs-devel team[3]. So this patch set only
uses C bindings internally and each unsafe operation is examined. This
implementation only offers functions impls and gets its exposed to
original C implementation as hooks. Only some of super operations are
modified slightly to make sure memory allocation and deallocation are
done correctly. Other changes to C are basically importing bindings from
rust. Besides, A new erofs_rust_helper.c file is introduced to help rust to deal
with folio, iomap and inode internal initializations.

Though it may violate some of the Rust-For-Linux principles,
i deem it's still ok to at least give it a try by using the Bindgen C
bindings since this work does not affect other Kernel APIs or the
current Rust For Linux Kernel crate designs.

This patchset is baed on the latest erofs-linux dev tree. And the
corresponding code can also be found on my github repo[4].

[1]: https://summer-ospp.ac.cn/org/prodetail/241920019?list=org&navpage=org
[2]: https://github.com/ToolmanP/erofs-rs
[3]: https://lore.kernel.org/rust-for-linux/ZZWhQGkl0xPiBD5%2F@casper.infradead.org/
[4]: https://github.com/ToolmanP/erofs-rs-linux

Yiyang Wu (3):
  erofs: add erofs_sys crate
  erofs: add implementation for erofs_sys
  erofs: add rust options

 fs/erofs/Kconfig                             |  11 +
 fs/erofs/Makefile                            |   1 +
 fs/erofs/data.c                              |  83 ++-
 fs/erofs/dir.c                               |  20 +-
 fs/erofs/erofs_rust.rs                       | 294 +++++++++
 fs/erofs/erofs_rust_bindings.h               |  47 ++
 fs/erofs/erofs_rust_helper.c                 | 107 ++++
 fs/erofs/erofs_rust_helper.h                 |  40 ++
 fs/erofs/inode.c                             |  51 +-
 fs/erofs/internal.h                          |   3 +
 fs/erofs/namei.c                             |  30 +-
 fs/erofs/rust/erofs_sys.rs                   |  67 ++
 fs/erofs/rust/erofs_sys/alloc_helper.rs      |  57 ++
 fs/erofs/rust/erofs_sys/compression.rs       |  18 +
 fs/erofs/rust/erofs_sys/data.rs              | 640 +++++++++++++++++++
 fs/erofs/rust/erofs_sys/data/uncompressed.rs |  61 ++
 fs/erofs/rust/erofs_sys/devices.rs           |  53 ++
 fs/erofs/rust/erofs_sys/dir.rs               |  83 +++
 fs/erofs/rust/erofs_sys/inode.rs             | 407 ++++++++++++
 fs/erofs/rust/erofs_sys/map.rs               |  28 +
 fs/erofs/rust/erofs_sys/operations.rs        |  96 +++
 fs/erofs/rust/erofs_sys/superblock.rs        | 554 ++++++++++++++++
 fs/erofs/rust/erofs_sys/superblock/file.rs   | 114 ++++
 fs/erofs/rust/erofs_sys/superblock/mem.rs    | 156 +++++
 fs/erofs/rust/erofs_sys/xattrs.rs            | 175 +++++
 fs/erofs/rust/kinode.rs                      | 103 +++
 fs/erofs/rust/kinode/kinode_helper.rs        |  26 +
 fs/erofs/rust/mod.rs                         |   6 +
 fs/erofs/rust/sources.rs                     |   5 +
 fs/erofs/rust/sources/mm.rs                  |  62 ++
 fs/erofs/rust/sources/page_helper.rs         |  12 +
 fs/erofs/super.c                             | 223 +++++--
 32 files changed, 3523 insertions(+), 110 deletions(-)
 create mode 100644 fs/erofs/erofs_rust.rs
 create mode 100644 fs/erofs/erofs_rust_bindings.h
 create mode 100644 fs/erofs/erofs_rust_helper.c
 create mode 100644 fs/erofs/erofs_rust_helper.h
 create mode 100644 fs/erofs/rust/erofs_sys.rs
 create mode 100644 fs/erofs/rust/erofs_sys/alloc_helper.rs
 create mode 100644 fs/erofs/rust/erofs_sys/compression.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data.rs
 create mode 100644 fs/erofs/rust/erofs_sys/data/uncompressed.rs
 create mode 100644 fs/erofs/rust/erofs_sys/devices.rs
 create mode 100644 fs/erofs/rust/erofs_sys/dir.rs
 create mode 100644 fs/erofs/rust/erofs_sys/inode.rs
 create mode 100644 fs/erofs/rust/erofs_sys/map.rs
 create mode 100644 fs/erofs/rust/erofs_sys/operations.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/file.rs
 create mode 100644 fs/erofs/rust/erofs_sys/superblock/mem.rs
 create mode 100644 fs/erofs/rust/erofs_sys/xattrs.rs
 create mode 100644 fs/erofs/rust/kinode.rs
 create mode 100644 fs/erofs/rust/kinode/kinode_helper.rs
 create mode 100644 fs/erofs/rust/mod.rs
 create mode 100644 fs/erofs/rust/sources.rs
 create mode 100644 fs/erofs/rust/sources/mm.rs
 create mode 100644 fs/erofs/rust/sources/page_helper.rs

-- 
2.45.2

