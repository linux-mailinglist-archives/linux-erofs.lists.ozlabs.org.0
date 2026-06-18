Return-Path: <linux-erofs+bounces-3663-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 48mbGqeXM2qvDwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3663-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:00:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF069DF58
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:00:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=SU3Kgypi;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3663-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3663-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggs7j2btRz2yfD;
	Thu, 18 Jun 2026 17:00:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781766049;
	cv=none; b=XCGY7bMj3zMoJNWz5aWSCGNMwPUzY8mKedkpPPxUt9xUM6LbfbiZHh/7Y/VVOKFhMudz8vBHKkZ4B9MB6Fsu8LhgIFmxjdFVEiwu+vKjNSkUyFJ+ouy//hEK25sERGsG+M26xb41MgvrC84Z6hbwb0n0mxedHmqC63TiSJlLyqUyHzJgTbRBdYtk7gKELJ3bzfIWl7bo1qTosa+OzxbC+uisG5e9926DvRfEPIs7kWMTC0eLmI6t3Tp4oapJODzlyH9WhurD1UXoL8QyhY/4/rqQ+kYOJPzeMA77YG1IwaONDiS/nZAUQgCftPAnXg5XpkCYvFITaQMkYjcINo90IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781766049; c=relaxed/relaxed;
	bh=6mwJU1kGJiQ3XPOnrDchdhkD2qiU59ejcqlwBkjki9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fFRZkO6UZaOoFYIwMfqyu0a+jSU/Cs/LZ7dbHtNu4bLlDF4RGF0Sz2leUUUmgeRlvQuW3QJezO6S0m9MXAYipI0SdbjXXZ+6U8GS1LbYZdWUNSvlOwGJxB3uK9TcVCGTqpLRe1tj2nKxqH5qXJx6qaDsP+XSWYCcd/sWikWioZTthChYoj6tGKzIgCpbPsGW1N/RggP7if62QD3uIx46Vf3Q2AGxS7jtYgfRILoZIWXHbOZH9o+WbhJMqngw1x06Vm8n2yoxP2szIYobYTzoqfrn7QhMPp63UHiz7rwXmfVPcjxYnPd6hs5790UhKMYxAZaWHw0zp5m0ZzUCp0KMiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=SU3Kgypi; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggs7f0CFLz2xM7
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 17:00:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6mwJU1kGJiQ3XPOnrDchdhkD2qiU59ejcqlwBkjki9Q=;
	b=SU3KgypiYmo1ATYJqOIDQ96bi7bClGJefwkHgPyCfNJIfMxWQuVyBEkm9HKm9C+GaT50bsZio
	wPAXe0ryKwqy04v8SV8k7xYshJKdK42bGd7DY0ZUPZPOx+pjkDNjOgW0jJLtP2mR/2vTfAspx7Q
	oIHKEeyKdy2oYfn+m8SAGA4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4ggryJ196Fz1cywm;
	Thu, 18 Jun 2026 14:52:40 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 0ABEF405D1;
	Thu, 18 Jun 2026 15:00:38 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Jun
 2026 15:00:37 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <yekelu1@huawei.com>, <jingrui@huawei.com>, <zhukeqian1@huawei.com>,
	<zhaoyifan28@huawei.com>
Subject: [RFC PATCH 0/3] erofs-utils: introduce file-merge incremental build
Date: Thu, 18 Jun 2026 14:59:19 +0800
Message-ID: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3663-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42EF069DF58

This series adds an incremental file-merge mode for mkfs.erofs.

This is motivated by layered microVM snapshots (memory and rootfs)
backed by EROFS external devices.  With blob indexes, mkfs can describe
file contents at block granularity and let a new layer store only
modified ranges while reusing unchanged data from lower images.

This series reuses the existing incremental build interface and adds a
new file-merge mode.  In this mode, when a source file exists in the
upper directory and a same-name file exists in the lower image, mkfs
treats holes in the sparse upper file as ranges that should inherit
data from the lower file.  Data ranges in the upper file are promoted
into the new image, while compatible clean lower ranges can be reused.

For compressed files, mkfs walks the sparse upper source and the lower
extent mapping together.  If a lower compressed extent is completely
unchanged by the upper source, it can be inherited directly.  If upper
data appears inside a lower extent, mkfs keeps the clean prefix when
possible and recompresses the promoted dirty suffix from the upper
source.  For uncompressed data, mkfs builds a logical source view that
selects the lower or upper backing file per range.

This allows incremental images to describe merged file contents without
materializing entire files in the new layer.  It is especially useful
for layered microVM snapshot images backed by multiple external devices.

The interface is still open to discussion.  It currently relies on
sparse source files to encode the inherit semantics.  In addition, mkfs
still lacks an interface to split blob data and blob indexes out of the
incremental build output, which needs further discussion.

Yifan Zhao (3):
  erofs-utils: lib: directly propagate vfile errors
  erofs-utils: refactor inode data source vfiles
  erofs-utils: support incremental file merge

 include/erofs/blobchunk.h |   4 +-
 include/erofs/importer.h  |   1 +
 include/erofs/internal.h  |  33 ++--
 lib/Makefile.am           |   4 +-
 lib/blobchunk.c           |  24 +--
 lib/compress.c            | 224 ++++++++++++++++++++++-
 lib/file_merge.c          | 118 ++++++++++++
 lib/inode.c               | 369 ++++++++++++++++++++++++++++----------
 lib/liberofs_compress.h   |   5 +
 lib/liberofs_file_merge.h |  22 +++
 lib/liberofs_rebuild.h    |   3 +-
 lib/rebuild.c             |  97 ++++++++--
 lib/remotes/s3.c          |  25 +--
 lib/tar.c                 |  23 +--
 man/mkfs.erofs.1          |  11 +-
 mkfs/main.c               |  17 +-
 16 files changed, 826 insertions(+), 154 deletions(-)
 create mode 100644 lib/file_merge.c
 create mode 100644 lib/liberofs_file_merge.h

-- 
2.47.3


