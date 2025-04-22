Return-Path: <linux-erofs+bounces-208-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ED0A96AAC
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Apr 2025 14:45:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zhhm62Zt2z3bjg;
	Tue, 22 Apr 2025 22:45:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.191
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745325926;
	cv=none; b=XDyqrkWrpEDlKz6j5ESwX9pieewu6JnYN8eqadwp5l0QGtMtGGp6nvCHGR2ttsOelCDZaE703yxnf+4/BhvSBpDuTE8yCau16C3gN0gnm5c4VOFmskgMcofPGX4uYw9plzMPFF2ZMfe/L2KnR6EdTSLkzTG+V5CkkU+Hm8mQcg471AFNLiMvJAx/mR2lnZ/KWhZvV+n3SDB40HfRC63bNHZochInOgsgX00sTjrwBAiKzxoZmweJbWAo+G0i3hw1EdgRqFmMhMgtoZIYKRJz8Sk+dFWWtxOK4BTdici5ZTffUqKHlzKQg0dS83k/p9+6HzSsxuoZwsLF6k0VXLMVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745325926; c=relaxed/relaxed;
	bh=aHan3RwYSCT+TN8Xg/ZcO+UbpDpowddr71Nc7IbxIcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1HuzRYf4V3Eek17QpxOBEAx5QSw2oxBQ0RUd16Xy2Jbl5yFHi9+w9q+7SSwC+r71sFnanNoY9hPbZud0hU4e9o+Ath7JIr0ZHT2LrvUmPZRtc/4SWMwhZKPjVrq/yN2bpU4lXrjrDF8GqUb263r4x7ce6/rAVVOLFfeVjJbOC9BidosfuppoyqPWzFagC/dnol5/SO3bYSnbsA5SpALDtI1bh3+XgmaxXv7rB5fBYnLxSrAPR5/4u3zDiPzhP3qHqsbCLVyABKmvm+CLgtzDdMmlN0mlER09HtOSmQQ+akE1aJTyEmP0TCK5JIQ8mnIh+HUYc1kgjnwXBFVhOcGug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.191; helo=szxga05-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zhhm34qQkz304l
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 22:45:22 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Zhhlg3S2Tz1j5wk;
	Tue, 22 Apr 2025 20:45:03 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 69CA11402CE;
	Tue, 22 Apr 2025 20:45:18 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Apr
 2025 20:45:17 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
CC: <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [PATCH RFC 0/4] erofs-utils: Add --meta_fix and --meta_only format options
Date: Tue, 22 Apr 2025 12:36:08 +0000
Message-ID: <20250422123612.261764-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=3.0 tests=RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

In this patchset, we have added two formatting options --meta_fix and
--meta_only to extend the ability of EROFS. In the case of using OBS,
we can convert the directory tree structure from OBS into the erofs
image and implement on-demand loading logic based on this. Since OBS
objects are often large, we need to separate the metadata area from
the data area, which is the reason we introduce the --meta_fix option.
To accelerate the formatting process, we can skip the formatting of
the raw data by adding --meta_only option.

A simple usage example is as follows:
  1. Build one xattr with OBS key in s3fs.
  2. mkfs.erofs --meta_fix --meta_only data.img /mnt/s3fs to format
  3. Implement the loading logic in kernel or userspace.

Based on the above logic, we can easily expose the directory tree
from OBS to users in the form of the EROFS file system and implement
on-demand data loading for large OBS objects.

Hongbo Li (4):
  erofs-utils: lib: introduce --meta_fix format option
  erofs-utils: lib: Implement the main logic for --meta_fix option
  erofs-utils: lib: add --meta_only format option
  erofs-utils: lib: remove the compile warning

 include/erofs/blobraw.h |  29 +++++++++
 include/erofs/config.h  |   2 +
 lib/Makefile.am         |   3 +-
 lib/blobraw.c           | 129 ++++++++++++++++++++++++++++++++++++++++
 lib/decompress.c        |   3 +
 lib/inode.c             |   6 ++
 mkfs/main.c             |  49 +++++++++++++++
 7 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100755 include/erofs/blobraw.h
 create mode 100755 lib/blobraw.c

-- 
2.22.0


