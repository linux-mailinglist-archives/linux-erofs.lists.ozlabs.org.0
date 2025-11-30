Return-Path: <linux-erofs+bounces-1455-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61213C95136
	for <lists+linux-erofs@lfdr.de>; Sun, 30 Nov 2025 16:16:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dK9c94WQgz2yvY;
	Mon, 01 Dec 2025 02:16:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.61
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764515801;
	cv=none; b=QEDEREE/UepXvlxvVmy9yPNYLdKPhiCW5Vo6pc3rn/hQYnIAwrc3ajpU3G/Vwm+p0RDR8wUyL1CZfnJVhWePZvnKmwSEJ5GZs0D/n1dhsJz/6GjnObpyT0SZMf1FziDoE3nWrTkzUpa15XVZ7GqJOD7fLEnE4ABrfYNIgA23rJOxkldmcq52sHJzTsjeXRI8Jng0QbPPwDen3z13eO41yZdsN9v9ZCdJtSMmKL7lmnt7l6+UXNxXBLHopMduSCJ/RIOjUv2aU2+XPVY38ftJSCTiecCInU7iTXu88U617SO7tVEKjcxDGpaeKl7My0pDYXrP9qsZ/iOQ9DX593aaEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764515801; c=relaxed/relaxed;
	bh=e2GEak83ePNHJnxp4ciXHSzy+OmZyxXRZDcrvj0CGgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBTmHnzGaYXjmTWxNi4AasjB04cTMxtQi5QKB9JwoQjsvKK1Z2vxBPhOAye8+x/HflnYHsnGls20sFTCMnZ8vIPluiRylCbV61zBuaIfdjpU5c6hW7rCmxPm+0beN/OmJDeo2WrBY31hgsIZ9PFfcc+L4O7fhLrvFpRaGZipDjjIQYDirmZgsdMT/ySx1CIct0wSJEmNA8ARpsrl5v6KU3Z/mZH+AsVlPbrJ1ilD0WdGNEH1cLwC1j9CkT9iOAuhA6jwso08n8l/shVPqr+r0rdwzFBTs2n82kKTgF5nccRNuCg9cm1swvyMsIbcscvBHKTtZ0yptpypyvXJqLrU5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.61; helo=out28-61.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.61; helo=out28-61.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-61.mail.aliyun.com (out28-61.mail.aliyun.com [115.124.28.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dK9c6552pz2yqP
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Dec 2025 02:16:34 +1100 (AEDT)
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.fZiFcR9_1764515786 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 30 Nov 2025 23:16:27 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	hudsonzhu <hudsonzhu@tencent.com>
Subject: [PATCH 0/2] erofs-utils: lib: oci: implement on-demand caching and direct IO
Date: Sun, 30 Nov 2025 23:16:24 +0800
Message-ID: <20251130151626.95009-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.47.1
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
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: hudsonzhu <hudsonzhu@tencent.com>

This patchset improves OCI blob handling efficiency by introducing an 
on-demand local file cache and implementing direct data writing to 
the target file descriptor.

These changes significantly reduce memory usage during large downloads 
and enhance random access performance for remote images by avoiding 
redundant data transfers.

Chengyu Zhu (2):
  erofs-utils: lib: oci: add on-demand blob cache
  erofs-utils: lib: oci: write downloaded data directly to fd

 lib/liberofs_oci.h |   1 +
 lib/remotes/oci.c  | 358 +++++++++++++++++++++++++++++----------------
 2 files changed, 234 insertions(+), 125 deletions(-)

-- 
2.47.1


