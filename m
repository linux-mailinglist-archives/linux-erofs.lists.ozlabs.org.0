Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD4D911BD8
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 08:33:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1718951636;
	bh=xaoPyb93L8PR3FDD4HMCthq+UJVY09NZxiHpIIv3g5M=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=HqZBXbvou8oJnt4lJ24Wg+UzP/CzLwOtk8RFL4W3nWciqbBFI0MCjSN3C//URyEyG
	 66bzDn1h4S+wPgyWeKdqmIaziKsqzUyO19Fb8fDDFgdogZA1Hb7ichi9YzkquTfdjH
	 QdS/SROi5wL2XFs7sN7nwRq7g84rzMVWz8u3drfk1esor+sgpvQyw/ijsg8EuHG5qM
	 Jqy7wkSuMWVuZ0lG2RKfyfQj7k2ZGlI07aHGQ9wck1v+UcviJ7HgOdR9t5V3hYBa6V
	 ERbcX8koivLTWyeMFmtRYVt4SrciA9lLgOv/XHwSvnuJhuLOkItgy2xfu4wwFTXbw8
	 HP+s6x5xoZOoA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W56yD08gfz3cXT
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2024 16:33:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W56y85GSQz30Vb
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2024 16:33:52 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W56Rx0GDLzZcGh;
	Fri, 21 Jun 2024 14:11:09 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 7694E18006E;
	Fri, 21 Jun 2024 14:15:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Jun
 2024 14:15:26 +0800
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>, <dhavale@google.com>, <dhowells@redhat.com>
Subject: [PATCH 0/2] support query ondemand feature for erofs and cachefiles
Date: Fri, 21 Jun 2024 14:18:06 +0800
Message-ID: <20240621061808.1585253-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, lihongbo22@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all!

These two patches is used to support query ondemand feature
for erofs and cachefiles modules. Since erofs over fscache
introduces CONFIG_EROFS_FS_ONDEMAND and CONFIG_CACHEFILES_ONDEMAND,
we cannot know whether the kernel supports this feature or not
in userspace. So we introduce the sysfs interface for users'
applications to obtain this.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Hongbo

Hongbo Li (2):
  erofs: support query erofs ondemand feature by sysfs interface
  cachefiles: support query cachefiles ondemand feature

 fs/cachefiles/Makefile   |   3 +-
 fs/cachefiles/internal.h |   7 +++
 fs/cachefiles/main.c     |   7 +++
 fs/cachefiles/sysfs.c    | 101 +++++++++++++++++++++++++++++++++++++++
 fs/erofs/sysfs.c         |   6 +++
 5 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 fs/cachefiles/sysfs.c

-- 
2.34.1

