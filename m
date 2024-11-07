Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181E9C0378
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 12:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730977837;
	bh=5gNPxAj4Vh1uSG/vA7lwLvCZS+6wWpqjntmjQw8WOe8=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=mOjukugbDCEtQHqTqZJThjinT8M93qfpo0I2cTdGJGycsE+NyGcrjv56U+aCbOqTK
	 FlUafPl/xJ5CRJybeDY3Mw1UP+O1uJVWGKxZqUFBFBi4xx8L65Y4ePTlLqu5+TZyws
	 qLUaB6IjmyU7DsRdtz+YTNgf2mWvzcN3czIYdmZehO5IaW7tWYIwbb5r3jI95ZXJZv
	 HTCDvrE3DoxYZG3Fa9fq926NFiS6i4uENyyqjHcY6BNqsctC2Hvt76deatSMDVilLl
	 lEtYKRvuO7AOIDqrUcOdcXbtk8mSZcxPGxjgDaD9K07/3nF65K2wXs2xVEKdkbLz+Z
	 7+kqbb8sl3lnA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkfWK3MQ4z3bnx
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 22:10:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730977835;
	cv=none; b=dDZSJKmafPBDclK/cW3J+hOdmx7egO0w8H1hCqmaTE3UYIl7i8wa1pUnNleyDYYj3HGGxPCueiX2myW1SHCrE755fmHoOddzYQWP7YTPryVg96vrPpsvDBAOM3ahSUtkTAr//SxBY/hBa32mLjmIGkQv6Ta91vr+DHTxl2BdJhNknC4PYIDNXN5MvCbHz6FVb805yqN8vhzlgOSPOLUTnGorQGAbgn0oPJUN8Bq61dbyaesieTKVP9SnRfZDaubMPkI/duDWEiQXjJZhqY9jXPoIr8yR2UacPW+ppHVAVw04O/KdKKJL1+bjUC+DHYJsx7kAj8OypfSUWeTuid03Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730977835; c=relaxed/relaxed;
	bh=5gNPxAj4Vh1uSG/vA7lwLvCZS+6wWpqjntmjQw8WOe8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yxah5OdAE1RMxQeTPDlFVhVOmJv4qbTxuvQVKXkQ1Oq9urNGq077gWGsd8/LAVBTF32V2dTmRM6qfmaw/xAHQ8nHK23r5p+bW+BYfXnXtEzRzWYAJu7STXJqd3Dumq7m8QWg7MLtZ8jNTVUwad5D5BRNmik2qwqlKexPIubDfxOHoEu3kgTFOuPDPLjkuj69RsafKd6LknvRnP4tLfWJu/sFjawlcmpsrIuagzDdzLu0GF14iXh652MMq42SSasE8yyu/CExP5Y17maE2AjKpJySdNo0OjtG91ZsBTSWc93tThJca7yo72dkISCli6ePba0PzjyjISYNvn8DwndG1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkfWF4Npnz3blC
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 22:10:30 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XkfT31B71z2Fbqn;
	Thu,  7 Nov 2024 19:08:39 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 8379B1401E9;
	Thu,  7 Nov 2024 19:10:21 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:20 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
Subject: [PATCH v2 0/5] fscache/cachefiles: Some bugfixes
Date: Thu, 7 Nov 2024 19:06:44 +0800
Message-ID: <20241107110649.3980193-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Zizhi Wo via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Zizhi Wo <wozizhi@huawei.com>
Cc: yangerkun@huawei.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Changes since V1[1]:
 - Removed some incorrect patches.
 - Modified the description of the first patch.
 - Modified the fourth patch to move fput out of lock execution.

Recently, I sent the first version of the patch series. After some
discussions, I made modifications to a few patches and have now officially
sent this second version.

This patchset mainly includes 5 fix patches about fscache/cachefiles.
Additionally, patches 2, 3, and 5 have already been ACKed. The first patch
fixes an issue with the incorrect return length, and the fourth patch
addresses a null pointer dereference issue with file.

[1] https://lore.kernel.org/all/20240821024301.1058918-1-wozizhi@huawei.com/

Zizhi Wo (5):
  cachefiles: Fix incorrect length return value in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Fix missing pos updates in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Clean up in cachefiles_commit_tmpfile()
  cachefiles: Fix NULL pointer dereference in object->file
  netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

 fs/cachefiles/interface.c | 14 ++++++++++----
 fs/cachefiles/namei.c     |  5 -----
 fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
 fs/netfs/fscache_volume.c |  3 +--
 4 files changed, 40 insertions(+), 20 deletions(-)

-- 
2.39.2

