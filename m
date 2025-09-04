Return-Path: <linux-erofs+bounces-965-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2EFB43287
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Sep 2025 08:36:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHV9q19qgz2ywR;
	Thu,  4 Sep 2025 16:36:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.44
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756967775;
	cv=none; b=FDaQhyflAf8D4NiEmCaWxzrg62FYulCVkvkmClAbY4D6Bh+n1XE2dU+GIHWvZzMBWk7Fzf0hwJ9sAfItQ7syYG6f1GEPgmMIRu45K+U4YdxuPPEyhC6IBs7M69AGKeyD5Fa8Aff7AJk0gMWAv7viz/tFt6HvXGFdq/pSxfVpIQq+LcAIPZ+L1JbSkc8S7Se+IcUyPA2eSfSWJjICxdeSDnWPVjioYc/GpfUmpbHqB91KJfiGuxSEY/xVj2ntVaaVKF9ZQZUmdq3jZz46onUJFMjKWVatflso/2/rDItCo2DoaYH54Z/81kfImpaEApdxaBjlJKS6eX69TLo9lrR8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756967775; c=relaxed/relaxed;
	bh=M+f34/jY644Ata1WHL27Yr2ReQvEblOzY/IWQPkQz6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ixS7EolOGf47fdO3Dc5NjBLg4vz9gaM1EUGZ+etRmsu9RZgoqtlrju9UziQB4B6BWlcf5QIX9jOmkM+kpcio91G0HMAv4Hc/CLPxWZkjIuYNsDINaheS3ndf8Zhx0BAe4iAAir9HRMvQ6W/xoxfjD+b/dKlilttol6Y1+0zWtZ/22R8V2L8xmO+PlGGePDePbk6uW15Zhv22C/rVEaSq0jBiVjIcXYNqDxeZ7OLPmefbCIlgs2fpvhn9IEMAt95zfWT2YYl7L/tOjqUkwECqI8Kal8jvlGfbA/l1zR8FNFI3opAV/YNiy+Q3lFxLYUZPzr7zQelUJG/fPoc3b+Ogdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.44; helo=out28-44.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.44; helo=out28-44.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-44.mail.aliyun.com (out28-44.mail.aliyun.com [115.124.28.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cHV9n5TLgz2xd6
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Sep 2025 16:36:11 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eXG5BaZ_1756967764 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 14:36:05 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v5 0/3] erofs-utils: refactor OCI and add NBD-backed OCI image mounting
Date: Thu,  4 Sep 2025 14:36:00 +0800
Message-ID: <20250904063603.560-1-hudson@cyzhu.com>
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

 lib/liberofs_oci.h |   88 ++--
 lib/remotes/oci.c  | 1029 +++++++++++++++++++++++++++++++-------------
 mkfs/main.c        |  186 ++------
 mount/Makefile.am  |    2 +-
 mount/main.c       |  257 +++++++++--
 5 files changed, 1013 insertions(+), 549 deletions(-)

-- 
2.51.0


