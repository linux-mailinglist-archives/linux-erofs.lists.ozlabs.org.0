Return-Path: <linux-erofs+bounces-956-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FAB4187B
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Sep 2025 10:29:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGwkl3fjMz2yGM;
	Wed,  3 Sep 2025 18:29:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.87
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756888159;
	cv=none; b=gidC2YIpXfp4mATsZk9aII87F77fOlR+RpBj1vHlDbOGJB5f6hVNv0cFR3s0JFyOFMpJ7lsgZpd39eNyUeGgBX1NSn3Pw6EHM3bnUN7PfcGly7LbfCIwoZA8KcV6KP4fyP9i4gLXTpBfuiq/lwu4oOoCgvG66aWaYweW2IeZTjzyUzm3YNj62aEfMFvhUch1NzGcaEXsjxAscF8N6gqup6dAmQAlTWoR50QQ/mOLStbOQEbP9HTAksklbBKjLyCFDsRDmpxYg+tlyMhiZaneiX7b7NdGTTaMYauIt3DQwaX7o+nUGVPCCLngBOcXFHCUAA9x8oqW+oznr9EKof09Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756888159; c=relaxed/relaxed;
	bh=4pwNl3aEtsJwXoyeOMOj7ZaYMOAc92SWM1VAke5tg5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpbdK+1m8zOVJJgW1X3sA03aO1mgMH69u64tvnaokES5ZDcmZA6yrUUqvXVNp1hcnWs9cVMLJKDaVKca1wD+S/4NQIVpOfMly/Rm0MjQo6vtMGIl577RbQ4lBTAaAs2Y4O4ZLz8qimvoqmhVjjnAdB6HM2oLCLfjzaZY61oZMH8nZj/Zlpuss0r4MAi2JQLHRMifU6lDCFOA9yYb2HUFZRtN4hSOFYl8+LkwOspaC/Apy6sIx3xyn8iGYaNQ8hLj3VV1ajPegbQRxEnwy5SoT3bff32vFHfOIZDNQnlpTmszPt4vldiJx1v6vPu2e8r713MFSox33tVQMk0rm0yI2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.87; helo=out28-87.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.87; helo=out28-87.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-87.mail.aliyun.com (out28-87.mail.aliyun.com [115.124.28.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGwkj5PmSz2xQ1
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Sep 2025 18:29:15 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eWS3HLS_1756888148 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 16:29:09 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v3 0/2] erofs-utils: refactor OCI and add NBD-backed OCI image mounting
Date: Wed,  3 Sep 2025 16:29:04 +0800
Message-ID: <20250903082906.83826-1-hudson@cyzhu.com>
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
from registries without pre-downloading

Chengyu Zhu (2):
  erofs-utils: refactor OCI code for better modularity
  erofs-utils: add NBD-backed OCI image mounting

 lib/liberofs_oci.h |   97 ++--
 lib/remotes/oci.c  | 1087 +++++++++++++++++++++++++++++---------------
 mkfs/main.c        |  192 ++------
 mount/Makefile.am  |    3 +-
 mount/main.c       |  236 ++++++++++
 5 files changed, 1036 insertions(+), 579 deletions(-)

-- 
2.51.0


