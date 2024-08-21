Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EEB95931F
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 05:03:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1724209391;
	bh=hyl3fUyDOxF/SIUJhBtmLRWEgS7760xP12KGAm0rMyM=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=cD56/8zmQnH9FglltLTD7wm7lPiCo610wdxH48CHsP2waFKIFOwwpxQVuiP4AZP6n
	 v3m+uc6AQnB4Vn+WG0mlg2NaU+Axnp1dnZgRMRg1WCm/3ybRsPOgBDEZbh/d2uHe1g
	 xcx/u1HZ5GnJW2U3f1MCXK53+tlGHw/IzBUQmd0ZWZR4sNlDzCl/5/MEIjt4/8jVxV
	 X89NH5Kz0xYbx9PMq9bfzY1mg2RR1Zz3/CRdyt5iJWQuccTzrNOvYp/x1XvfJDC4Bg
	 rzeTocV21frJtLy9XOqprhiYLWEGD/7bBf8AvM822bQl+3GD7saA8UIhtmL2JPi4iP
	 QBfj3YieR+v0g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WpWNv3mZtz2yVb
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2024 13:03:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.188
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.188; helo=szxga02-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 921 seconds by postgrey-1.37 at boromir; Wed, 21 Aug 2024 13:03:08 AEST
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WpWNr1Hhnz2xfK
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2024 13:03:05 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpW1D2ZmjzpSwr;
	Wed, 21 Aug 2024 10:46:08 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 3982A1800A7;
	Wed, 21 Aug 2024 10:47:39 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:37 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
Subject: [PATCH 0/8] netfs/cachefiles: Some bugfixes
Date: Wed, 21 Aug 2024 10:42:53 +0800
Message-ID: <20240821024301.1058918-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)
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

Hi!

We recently discovered some bugs through self-discovery and testing in
erofs ondemand loading mode, and this patchset is mainly used to fix
them. These patches are relatively simple changes, and I would be excited
to discuss them together with everyone. Below is a brief introduction to
each patch:

Patch 1: Fix for wrong block_number calculated in ondemand write.

Patch 2: Fix for wrong length return value in ondemand write.

Patch 3: Fix missing position update in ondemand write, for scenarios
involving read-ahead, invoking the write syscall.

Patch 4: Previously, the last redundant data was cleared during the umount
phase. This patch remove unnecessary data in advance.

Patch 5: Code clean up for cachefiles_commit_tmpfile().

Patch 6: Modify error return value in cachefiles_daemon_secctx().

Patch 7: Fix object->file Null-pointer-dereference problem.

Patch 8: Fix for memory out of order in fscache_create_volume().


Zizhi Wo (8):
  cachefiles: Fix incorrect block calculations in
    __cachefiles_prepare_write()
  cachefiles: Fix incorrect length return value in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Fix missing pos updates in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Clear invalid cache data in advance
  cachefiles: Clean up in cachefiles_commit_tmpfile()
  cachefiles: Modify inappropriate error return value in
    cachefiles_daemon_secctx()
  cachefiles: Fix NULL pointer dereference in object->file
  netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

 fs/cachefiles/daemon.c    |  2 +-
 fs/cachefiles/interface.c |  3 +++
 fs/cachefiles/io.c        | 10 +++++-----
 fs/cachefiles/namei.c     | 23 +++++++++++++----------
 fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
 fs/netfs/fscache_volume.c |  3 +--
 6 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.39.2

