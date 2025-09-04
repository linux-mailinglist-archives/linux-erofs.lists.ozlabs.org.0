Return-Path: <linux-erofs+bounces-961-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36976B431A1
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 07:33:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHSnM4qSrz2xnM;
	Thu,  4 Sep 2025 15:33:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.45
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756964007;
	cv=none; b=PGyDMtWMFnSm2pVuczK2JlLyS79fC8LBOUqnoCG0+U4jaw/MxG6w/V9jP1mNlqQ8LWihhfWQL98XYKMdj/JWmNacQe9yLFx0U6lVfVIEMYawQJUs8cBTwtByjrXTsEK3fMFzc6px64VmPRFGwYXXVpWFPbJpBJtXPWj1JngsFiAimtQHDOBN4l/5PANF9Q8taZ4XgeLoUCjP9k4Mqc0p3PKDLEV+8mjkPQPw6jVLiAM0yj/hkMs/6DDa7mnaTo1Un4pbdX85GtwE5kDrsse+8Tn8PN4/8bsaq5ve8ne/vWR5bhs8IN6351tuTFuNEbYafN1/dcw/3J9CBzJNZ69JmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756964007; c=relaxed/relaxed;
	bh=8EP5H4lCCQH/O8cnj0k/VhslyrGd3MIR1Lw0SPBjVms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhCkp/R4xH/ch4tohwAwYE9J83X5Dls0ai+6W4hzQ+C2mRXnM1vnBBDLQQXi/lAXvCfVg/d2Z1ZDtLncHqCODBkWiyQTZkNql88swJdjJDBKAiuGFZjyQDiV4daRjuZFSoDexnO8oapGqqaKcgAZtVE7xKYggh/qTU2IJuNTyaFPRRGmywBb5N7L6q4mDR4xoRzf0jQZHMNAAPWSP7+vzdtQPDvoek/upkJwjvghNFFaMYAfE/tpljwVYaDWVt3ULBLBiXCsFsZdVUx96myPj08TM+SsCkTSMmBCe8fxjtxiexXGmfJRfBefZsy74k0ef6qD3dmTp0LHWrt9mBm1xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.45; helo=out28-45.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.45; helo=out28-45.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-45.mail.aliyun.com (out28-45.mail.aliyun.com [115.124.28.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHSnL1R1tz2xns
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 15:33:23 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eX6SV8l_1756963996 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 13:33:17 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v4 0/3] erofs-utils: refactor OCI and add NBD-backed OCI image mounting
Date: Thu,  4 Sep 2025 13:33:11 +0800
Message-ID: <20250904053314.65700-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901051042.10905-1-hudson@cyzhu.com>
References: <20250901051042.10905-1-hudson@cyzhu.com>
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

From: Chengyu Zhu <hudsonzhu@tencent.com>

This series refactors the OCI handling in erofs-utils and adds NBD-backed
mounting of OCI images. It enables mounting EROFS container images directly
from registries without pre-downloading.

Chengyu Zhu (3):
  erofs-utils:mkfs: move parse_oci_ref to lib
  erofs-utils: refactor OCI code for better modularity
  erofs-utils: add NBD-backed OCI image mounting

 lib/liberofs_oci.h |   91 ++--
 lib/remotes/oci.c  | 1093 +++++++++++++++++++++++++++++---------------
 mkfs/main.c        |  201 ++------
 mount/Makefile.am  |    2 +-
 mount/main.c       |  257 +++++++++--
 5 files changed, 1014 insertions(+), 630 deletions(-)

-- 
2.51.0


