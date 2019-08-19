Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF38392158
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 12:35:36 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Br0z3FYNzDqjb
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 20:35:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Br0j4bqKzDqhm
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 20:35:17 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 51609BA7CB78A0572AFD;
 Mon, 19 Aug 2019 18:35:12 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 18:35:03 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 0/6] staging: erofs: first stage of corrupted compressed images
Date: Mon, 19 Aug 2019 18:34:20 +0800
Message-ID: <20190819103426.87579-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819080218.GA42231@138>
References: <20190819080218.GA42231@138>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

I have fuzzed EROFS for about a day and observed the following
issues due to corrupted compression images by my first fuzzer
(It seems ok for uncompressed images for now). Now it can survive
for 10+ minutes on my PC (Let me send out what I'm done and
I will dig it more deeply...)

All the fixes are trivial.

Note that those have dependency on EFSCORRUPTED, so for-next
is needed and I will manually backport them by hand due to
many cleanup patches...

Thanks,
Gao Xiang

Gao Xiang (6):
  staging: erofs: some compressed cluster should be submitted for
    corrupted images
  staging: erofs: cannot set EROFS_V_Z_INITED_BIT if fill_inode_lazy
    fails
  staging: erofs: add two missing erofs_workgroup_put for corrupted
    images
  staging: erofs: avoid loop in submit chains
  staging: erofs: detect potential multiref due to corrupted images
  staging: erofs: avoid endless loop of invalid lookback distance 0

 drivers/staging/erofs/zdata.c | 46 ++++++++++++++++++++++++++---------
 drivers/staging/erofs/zmap.c  |  9 +++++--
 2 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

