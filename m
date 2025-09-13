Return-Path: <linux-erofs+bounces-1024-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3536AB55F7F
	for <lists+linux-erofs@lfdr.de>; Sat, 13 Sep 2025 10:28:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cP4Db4WX9z2yqR;
	Sat, 13 Sep 2025 18:27:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.84
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757752079;
	cv=none; b=ceth2YiDm+EC4cyBQOIS5o54UXWy+nkZj2VdOTTWg3QMYENqkBeBeNTcfI94iIBkj5MoasgQAi/UOGEKcdYFEx1gyL7YJLlZXdmD5LhCKFpudIaPuCRbeJyLdSuBK04zORmazBihnvcTEOTeL6IIThy2WOkF0TxX4UVlZ3Dgy+KotZLU1zFEqgI5EFC2efqUYPdrezwktm7ShfSWfRdpCOWQuwJiWPLvXoI/7n4jKQ3sIrCm7GYmNiSRaCNOeAAvUkkOHtbzdOjymDHoG1XnJO3XnYNRRmX00jGoiuCp91ctD9E2rfY4u+vlD0ZH0SKEWxNodFMY11EZAeRYunVz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757752079; c=relaxed/relaxed;
	bh=q7zOZbU/90CmSu3TPYIqL1+TbPeK47ob7uOWaQG0BJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RaKCG9CxCixlDpYt0ifS7aeiwDz1cKz3nJ6j3Sbe6Fd5+FRX27DqSPlVS0Uz5zu+CXT6yj47WieDpHk8kMPMc7GqXoDcuFxeL0gV/YYboZ0WpXtmKI/8uf5DoI+7x5/oRx3wBN13inGVzshlKKpM5RZ2fk8tFufiksuwaFqAKo1/ZJy/OE4LSu+EuKLyaC20gzFWKGJw/M0b6jyImT8woLbq+zrvcL6Ij179lLGFM9WKCc772JFWypPNQf7hcLP+NSo7tNkATYJb6Q2oksyz/lMDCTw02aDSA4foSg7mcSH5IaRHk30TMzlR2vDtsaF9XgbDckAIRBqlhDKIjvVNiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.84; helo=out28-84.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.84; helo=out28-84.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-84.mail.aliyun.com (out28-84.mail.aliyun.com [115.124.28.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cP4DZ0VLZz2xnr
	for <linux-erofs@lists.ozlabs.org>; Sat, 13 Sep 2025 18:27:55 +1000 (AEST)
Received: from HUDSONZHU-MC1.tencent.com(mailfrom:hudson@cyzhu.com fp:SMTPD_---.eeCA7oq_1757752069 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 13 Sep 2025 16:27:50 +0800
From: ChengyuZhu6 <hudson@cyzhu.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: [PATCH v1 0/2] oci: improve layer identification with digest-based approach
Date: Sat, 13 Sep 2025 16:27:46 +0800
Message-ID: <20250913082748.88070-1-hudson@cyzhu.com>
X-Mailer: git-send-email 2.51.0
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

This patch series improves OCI layer identification by replacing layer indices
with layer digests for more precise and reliable layer selection.

Chengyu Zhu (2):
  mount: change oci layer option from "oci=X" to "oci.layer=X"
  oci: replace layer index with layer digest

 lib/liberofs_oci.h |  6 ++--
 lib/remotes/oci.c  | 72 ++++++++++++++++++++++++++++++++--------------
 mkfs/main.c        | 21 +++++++-------
 mount/main.c       | 39 +++++++++++++------------
 4 files changed, 85 insertions(+), 53 deletions(-)

-- 
2.51.0


