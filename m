Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDEC8AAE9B
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 14:36:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1713530204;
	bh=C6RRbxVLK9srOH1/uG0m5UGlaGVm/Cnp16IBmPSVuEQ=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=kXmTfRtTdapXZb6wmbw2dE6DmIZ6KEiEvSqpgMQQh1EwX0TNyWkItYsGzg+uBqdIv
	 9jbhx2krEAWHqK8GAd093CoAM3m5lYlBuS8RkqfiiMJKoyB4cVVh6YfOefQUnbdei1
	 TSKbMkHqqkC7UNZOcijTRzeqed//QqfTGuARBU/Zq8WUl2d/TVBiUXZr5yeFxFsaka
	 Y6U0jnkf2TPmNnEJKHPxYzcixw9+zwXQSRLNLJMWHQa+O1Kugo19ySVMDCVo6DDli8
	 ZntnPkH4c+EYbOnlw9zxxHor22WNeeFHv4LqpyBLVRyhy1gGITDsY1oLDwIsYe5v56
	 1rRJfhxSikCnA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VLYzw2XKCz3dJB
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Apr 2024 22:36:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=libaokun1@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VLYzN1ZkRz3cll
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 Apr 2024 22:36:14 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VLYvH4K5szdb00;
	Fri, 19 Apr 2024 20:32:43 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id D821E18007B;
	Fri, 19 Apr 2024 20:35:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Apr
 2024 20:35:38 +0800
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH -next v3 0/2] erofs: reliably distinguish block based and fscache mode
Date: Fri, 19 Apr 2024 20:36:09 +0800
Message-ID: <20240419123611.947084-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
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
From: Baokun Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Baokun Li <libaokun1@huawei.com>
Cc: brauner@kernel.org, yangerkun@huawei.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, viro@zeniv.linux.org.uk
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christian,

As your original patch had some "DOS line endings", I failed at am it, so
manually changed the relevant content when making v2, which caused Author
to be modified, I just noticed this and corrected it, apologies for that.

Changes since v2:
  Get rid of erofs_fs_context.

Changes since v1:
  Allocate and initialise fc->s_fs_info in erofs_fc_get_tree() instead of
  modifying fc->sb_flags.

V1: https://lore.kernel.org/r/20240415121746.1207242-1-libaokun1@huawei.com/
V2: https://lore.kernel.org/r/20240417065513.3409744-1-libaokun1@huawei.com/

Baokun Li (1):
  erofs: get rid of erofs_fs_context

Christian Brauner (1):
  erofs: reliably distinguish block based and fscache mode

 fs/erofs/internal.h |   7 ---
 fs/erofs/super.c    | 124 ++++++++++++++++++++------------------------
 2 files changed, 55 insertions(+), 76 deletions(-)

-- 
2.31.1

