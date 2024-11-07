Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 928C79C0384
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 12:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1730977869;
	bh=TyKChjgjx8z3Q5K+gIWVLrspDaXNa6gELS0JGdLPVdo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eyApW/xDlgeoOdTJ1WmtRKPMwKL0LEN1VlJvXgVxuhma8IQiID0IqTFpaL+ECaLEW
	 pN0vkoelHjuN1jtFQxC8zxWEc3e3Ficfy9N8lGfOLgn5eXtzi0eV1M6dVLC58N1ZU4
	 X5wb7x0b+NFI+vcMGMI0DtTArei7rVV9iGG1bMckCvWUG82HBUP5ngVxFuWJHin8I4
	 dQGoF1uG3YeVO6xenYJxDJU/W0oHQRd2u0x+cERRewlGskaJkFKYPPMtRCaKKAuR0H
	 3FwP7SyVdFmDbmddbfXGgJQ04RcO/t2KuuzL6lJIJHBMzNXbMBwEU2/m7sgaSGADX0
	 SXJdkOrDJfZEQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkfWx46tTz3bnc
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Nov 2024 22:11:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.187
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730977867;
	cv=none; b=R4/5MUaqWV7n0Ym4QhLI6MBC28k8PV6Kqg6HAcxsDCSApqppNlgo+9DRI3gNQRdW2GkWpDG8/zTU3u7NKQ+n4BtjTKZIDSMbd5Z6zCL4Tj/3Pp+aPyHhVC65u3J9EKQAo0yE7gmoikZleiqA5uQBduqDPZ7bb/nvJGLRIuI3GWJNvgl8HHkodk/mjVZ9tE2Ok6z9f2v1LZge6Sahu6IlTxDp49zSu1cBre9c6VFLmVUhbXhPgDP3H02uWmMmDZgCl5R5sCWCTYZheAeNdZgcGJNP4IxOaA55ur88yUt88BXVTB4y7750YBVQoRjaCKraBwXIDyOYHrr3yMZcq3sZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730977867; c=relaxed/relaxed;
	bh=TyKChjgjx8z3Q5K+gIWVLrspDaXNa6gELS0JGdLPVdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDJ4PlimbYbMx5AeX0pIrn27yoAn6qsT2KXo3fXbplu1dz1y/huCh6UW0LtSEBzcbQ/brfYwFT6DYxisf++LANlf9N2g/QJoVeklV6wCvYrXolJIILSHs29I1Qn/lmgm2SQr2nf8joQCDtpQu/oAJODHoCeEWq7U352TQ/hhbSDKZJFTNmRA598K8suIn78nw2aYncTrKyisBHbsBrG6akvaDf7GJ4xva6v2kgtpJJkLyeMGHcmmtuIV09c90Sv4B2SrHQ2hCa9rKH0gcUiBlfnDFbvtqy8vPUfv7hW22z8kWt5rVhY5Vdq8hlFfPC+WFukJJLvjJhKVR4s8473jhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=szxga01-in.huawei.com; envelope-from=wozizhi@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkfWt5sbmz3bps
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Nov 2024 22:11:06 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XkfSL0W0fz10QlX;
	Thu,  7 Nov 2024 19:08:02 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D8A41400DC;
	Thu,  7 Nov 2024 19:10:23 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:22 +0800
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
Subject: [PATCH v2 2/5] cachefiles: Fix missing pos updates in cachefiles_ondemand_fd_write_iter()
Date: Thu, 7 Nov 2024 19:06:46 +0800
Message-ID: <20241107110649.3980193-3-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241107110649.3980193-1-wozizhi@huawei.com>
References: <20241107110649.3980193-1-wozizhi@huawei.com>
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

In the erofs on-demand loading scenario, read and write operations are
usually delivered through "off" and "len" contained in read req in user
mode. Naturally, pwrite is used to specify a specific offset to complete
write operations.

However, if the write(not pwrite) syscall is called multiple times in the
read-ahead scenario, we need to manually update ki_pos after each write
operation to update file->f_pos.

This step is currently missing from the cachefiles_ondemand_fd_write_iter
function, added to address this issue.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
Acked-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/ondemand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index bdd321017f1c..38ca6dce8ef2 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -77,8 +77,10 @@ static ssize_t cachefiles_ondemand_fd_write_iter(struct kiocb *kiocb,
 
 	trace_cachefiles_ondemand_fd_write(object, file_inode(file), pos, len);
 	ret = __cachefiles_write(object, file, pos, iter, NULL, NULL);
-	if (!ret)
+	if (!ret) {
 		ret = len;
+		kiocb->ki_pos += ret;
+	}
 
 	return ret;
 }
-- 
2.39.2

