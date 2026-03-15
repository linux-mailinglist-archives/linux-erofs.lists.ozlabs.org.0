Return-Path: <linux-erofs+bounces-2703-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLQ6KPTBtmkWHwEAu9opvQ
	(envelope-from <linux-erofs+bounces-2703-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:04 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A364291059
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 15:28:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYgYW0yydz2xlM;
	Mon, 16 Mar 2026 01:27:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773584879;
	cv=none; b=Sp1v5mn1tojhqCJ1YiNszfQdTEJQo2X+G0APEPZJ68OcfnvDEvBngqthnp2ynega7+cWl9NFwrOlgHrQcyHYzttOVJtLISTDjUMCdfsRvVLc16hanWh071gyOri8KQ5KGSBnCLyLteW+36Z8w0TyPia/3yXVdw6diQxHGdhW0Xncdt4+pdZkQXjn1h4P1XTfEqSV+y1fMIojwetHRIm0ze2NfOG1alQ/F6+AC0Lbk5ymBhjie+s9H1LpNe/S9AQqMzONTbS/AuJYMojSUYeoM3g3UrKOC/nCrnqQYVxAlyo16xxll7ofcaRHNXb3f5wd1HscQrgYMqLmEFKPc0GEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773584879; c=relaxed/relaxed;
	bh=bzEzsSnvp851XuLnz6WRMg3a6wXexJdp5qeW3r6U1cI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WigyX3ZNVXj4F5aVdhs1ATaNBCuKmK8H/ogpF+O+Ol0ntbXtvZ7IRBWu8HRuUpZF0ZywnCzU3jZw5YHWTJeBvgi6R2D0SmfOkQf7y3jHTsbwkuAOAP9Bly3nfVOVXJZBgNnDelOBGI42IBJHFAXzY99qrlty7I0RQ5N9TPhukRyF0XCaRwq1Po7Rc+q/57vvT85df2+RbRFodrE12yKeJdr3bwTpwILstJIRut4wrlJPLxI1ZgufuBCPQWbVBoXA3+9gcKp23Mhj5bG2gWEs5QsQhgnCZpq9mPIUUiXt/TX6dA8WYkdE67Ty+irGSNOAuiINTV1AUsUrPTOpv+CIPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.38; helo=out28-38.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.38; helo=out28-38.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-38.mail.aliyun.com (out28-38.mail.aliyun.com [115.124.28.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYgYS6JP7z2yZ3
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 01:27:55 +1100 (AEDT)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3449517|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00617173-0.000349227-0.993479;FP=14944004511294855095|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033065182171;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.gsmlGwD_1773584866;
Received: from HUDSONZHU-MB0.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.gsmlGwD_1773584866 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 15 Mar 2026 22:27:47 +0800
From: Chengyu <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@linux.alibaba.com,
	Chengyu <hudson@cyzhu.com>
Subject: [PATCH 0/4] erofs-utils: add ublk backend for mount.erofs
Date: Sun, 15 Mar 2026 22:27:41 +0800
Message-ID: <20260315142745.56845-1-hudson@cyzhu.com>
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
X-Spamd-Result: default: False [0.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2703-lists,linux-erofs=lfdr.de];
	DMARC_NA(0.00)[cyzhu.com];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.770];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,cyzhu.com:mid]
X-Rspamd-Queue-Id: 7A364291059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds ublk (userspace block device) support to mount.erofs
as an alternative to the existing nbd backend.

Patches 1-2 refactor mount/main.c: rename nbd-specific types to
generic names and extract reusable source-opening / recovery helpers.

Patch 3 adds the core ublk backend library with per-queue threading,
device recovery, and signal-safe teardown.

Patch 4 integrates ublk into mount.erofs (-t erofs.ublk, --reattach,
unmount).

Chengyu Zhu (4):
  erofs-utils: mount: generalize nbd source types for multi-backend
    support
  erofs-utils: mount: extract reusable source-opening and recovery
    helpers
  erofs-utils: add ublk userspace block device backend
  erofs-utils: mount: integrate ublk backend

 configure.ac        |   34 +
 lib/Makefile.am     |    9 +-
 lib/backends/ublk.c | 1429 +++++++++++++++++++++++++++++++++++++++++++
 lib/liberofs_ublk.h |   53 ++
 mount/main.c        |  506 ++++++++++-----
 5 files changed, 1885 insertions(+), 146 deletions(-)
 create mode 100644 lib/backends/ublk.c
 create mode 100644 lib/liberofs_ublk.h

-- 
2.47.1


