Return-Path: <linux-erofs+bounces-718-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC71FB14CFC
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Jul 2025 13:25:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4brtLJ57fqz30W9;
	Tue, 29 Jul 2025 21:25:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753788312;
	cv=none; b=P9OLkfmxThoBiBO/2u1M1GooykZekRZCzwYdAESizafNueqaMh3rG9CrDTNTSOJ25RhhdcTZBiJ4TPEtqEuTtS2iljLjQrG/KPgTE6YgXBjuG+Z+e6SUS+p9qx1VkAzBxXEtZU2vAYLIi+rYIDjlK+XAQbCaOgbILPswI//8QFO3V2D8q9Jv5ufwhEgNX+Sa34EqAjXmjncLhQYhiNy8xMLIb9N6T25WocXV0GXVg3EkTC3UU6Tp+B3rsQtoIe5/a1Sg7SKeHFLnL5rMWS19vgZ+BkkzdGZ3MNZwp7tgwgSLXRwx+Zu3iD6Ay16Lk3aS86b9yUSjpURToK6HCIeasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753788312; c=relaxed/relaxed;
	bh=cZo04MNm80tqS0AYIxvaujX74yDlvf8vXW2cJvSXlf4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBO4uZDXSdary34DMe7G1rUnSiFmI1wWgvpQDzgnwMmc179eZV4uPaEhkRHu/o3yXTO3cjHrAHXWqZYJrMj9/Hz/7RQM1RlvHVLnfvftZY2UyvSsW9oaINQhmu0c2zfpIwuuH1jCi/hVkGFwTbOkGn8dLb1yxz+a1KukCVXDlzEcnOw2F8RobMt8LpK5byWlzuSmCqPMbHyXPQvDktg5NmaOZ7FwDTiFywD50qy60DsaS6ej9l7SRy313NjEFTq/eUqHuKvh6IXWK6w7RphIFLSsOYgLTGV6WLQOtW100Ro7wPRTUdXhTWQ2hh+79h1jAAIEyH7303pbW6jAyGDMiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brtLH4b27z30P3
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 21:25:11 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4brssw5x7Cz13Mkj
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 19:04:04 +0800 (CST)
Received: from kwepemp500007.china.huawei.com (unknown [7.202.195.151])
	by mail.maildlp.com (Postfix) with ESMTPS id A70BA140156
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Jul 2025 19:07:09 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 kwepemp500007.china.huawei.com (7.202.195.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Jul 2025 19:07:08 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhurui10@huawei.com>,
	<songgongzheng@huawei.com>, <lihongbo22@huawei.com>, <qinbinjuan@huawei.com>,
	<caihaomin@huawei.com>, <caihe@huawei.com>, zhaoyifan
	<zhaoyifan28@huawei.com>
Subject: [RFC 0/4] Introduce experimental support for image generation from S3
Date: Tue, 29 Jul 2025 19:06:06 +0800
Message-ID: <20250729110610.3438246-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.46.0
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
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500007.china.huawei.com (7.202.195.151)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

From: zhaoyifan <zhaoyifan28@huawei.com>

This patch set allows mkfs.erofs to build images from a new data backend:
S3 (or other S3 API compatible object storage services).
Currently, the support is limited, including:
1. Only supports building index-only images.
2. Only object key and size is respected during building.
3. Only supports AWS Signature Version 2 authentication.

The current feature support meets our team's business needs. I hope to work
with the community in my spare time to polish this patch set, making the
support fully featured.

zhaoyifan (4):
  erofs-utils: mkfs: introduce source_mode enumeration
  erofs-utils: introduce build support for libcurl, openssl and libxml2
    library
  erofs-utils: mkfs: introduce `--s3=...` option
  erofs-utils: mkfs: support EROFS index-only image generation from S3

 configure.ac       |  41 +++
 include/erofs/s3.h |  42 ++++
 lib/Makefile.am    |   5 +
 lib/s3.c           | 612 +++++++++++++++++++++++++++++++++++++++++++++
 mkfs/Makefile.am   |   3 +-
 mkfs/main.c        | 296 +++++++++++++++++-----
 6 files changed, 937 insertions(+), 62 deletions(-)
 create mode 100644 include/erofs/s3.h
 create mode 100644 lib/s3.c

-- 
2.46.0


