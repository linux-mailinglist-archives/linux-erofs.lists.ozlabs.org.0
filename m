Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AC7A1653C
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 02:55:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ybtj60M6bz300V
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 12:55:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737338152;
	cv=none; b=GcSSO7ghEWy77pHwF33KJDkR4RwE1pKftsvXMRmA3c2ilYwPBFa+bW/8mUxshIJ6QsQn8xGLLVkyL+dCW8HnB/1mxPLsyRyIzvDm5he8JGOwq2hktx+/1VNAazw45+cdTaW+pwAQr8HuFiNoRU1ymwtbAq81edaHt3J//+Ml1XBfyU2IElD69+54CfkRhO2mvBySrE4/rUn5pHX6/7rOxJBmFCDxD4CyqfIvEdjMUjYYGP3cKOSow6O1AYBsZKfsoG+DpbfLhVtxWGTWvgmB/NxSDduaVC+tQHRkd6qJuyVzZCklWAUlK2U2OIk5os6MYjf5zYJwzkw/XTee6q+9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737338152; c=relaxed/relaxed;
	bh=OYCRGzXVclNcnQTq/KDRss+2PMdGwcOUPNXh4dk9R5w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Hdzes/oJ2L5oXqoHQagSuceuQL5hSlDAfx5T9gBXXnlXEH9pqKN+9QpPz/HAb59mkTUZyB0jh1LiekiMdtpFzuAfxKlRMUfoMF7o5RX2zUQGy/lEPvOObSCDuSA2EPgk/rem8qJ0skg35x5Ay8Ff4SgcUhl6iBB1pTM+bI4yKyYbiHzqauCiJjNNuRSFwnfqUL9fVJdqnnShQ2gSoJn3vqbeV7qtj6mBWHtVj0nfPgR7eHDMc5blK9dVwlbB9tP6FtCvWuTqcgFDOmP/gBcTUnx1QsuvGx57ID9RorTtfA/zH8/rwk3/bBtD2dKudlytyya5Tne0s+2yZCeuom/jXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vrQtt+em; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vrQtt+em;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ybtj230fmz2yFD
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 12:55:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737338145; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=OYCRGzXVclNcnQTq/KDRss+2PMdGwcOUPNXh4dk9R5w=;
	b=vrQtt+emQEjmPa/Z2rpnG90ipKnbAoKdAK7uY1xIZtbCSqi19gZ0M3S7M+GNEdFv9nNKLojGJvesm8XiWwC+E2hSpHMbwkduI56fFVPZsNuO82MpDEiYdW6srpZEN1yEDu/vi1SNM6lB8BwUyR7NoXrpdiv3T11LkcD05TiuxYY=
Received: from 30.221.129.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNv7zF6_1737338142 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 09:55:42 +0800
Message-ID: <109605af-8df5-49dc-be5e-81ec907bfcbf@linux.alibaba.com>
Date: Mon, 20 Jan 2025 09:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] data corruption of init process
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>, linux-erofs@lists.ozlabs.org
References: <c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de>
 <14b78097-ee6a-4e91-9688-172ce807299b@linux.alibaba.com>
 <1ee54399-88ef-440e-9262-cba0bcc28c90@pengutronix.de>
 <b73823e2-a976-4831-90c7-405316440236@linux.alibaba.com>
In-Reply-To: <b73823e2-a976-4831-90c7-405316440236@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2025/1/20 09:45, Gao Xiang wrote:

...

> 
> After I picked "erofs: ... i_ino ...., index ...." lines out, sort them,
> and use`sed -e 's/.*(\([0-9a-f]*\))$/\1/'` to parse the sorted items of
> BAD and GOOD cases,
> 
> I found each decompressed page cache page (which will be visible to
> the userspace) is the same, so I'm very confused why it could happen.
> 

     - First of all, could you also confirm the output if the following
       patch is applied:

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0cd6b5c4df98..3c2cff623016 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -264,6 +264,11 @@ void erofs_onlinefolio_end(struct folio *folio, int err)
         if (v & ~EROFS_ONLINEFOLIO_EIO)
                 return;
         folio->private = 0;
+       ptr = kmap_local_folio(folio, 0);
+       hash = fnv_32_buf(ptr, PAGE_SIZE, FNV1_32_INIT);
+       erofs_info(NULL, "%px i_ino %lu, index %lu dst %px (%x) err %d",
+                  folio, folio->mapping->host->i_ino, folio->index, ptr, hash,
+                  v & EROFS_ONLINEFOLIO_EIO);
         folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
  }

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index aff09f94afb2..39d857acd3d0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1847,7 +1847,7 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)

         /* if some pclusters are ready, need submit them anyway */
         err = z_erofs_runqueue(&f, 0) ?: err;
-       if (err && err != -EINTR)
+       if (err)
                 erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
                           err, folio->index, EROFS_I(inode)->nid);

I'd like to know if some error is returned (especially EINTR) to
user space which could cause something...

Thanks,
Gao Xiang

