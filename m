Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBB7915E7F
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 07:56:58 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m4AztpIu;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W7YxZ6qYPz3d9V
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jun 2024 15:56:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m4AztpIu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W7YxS3yvYz3ckk
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jun 2024 15:56:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719294998; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qOQAhF4cxd2PxWr9yp1EnOrOJTkQF/0pnQMJkucMV6M=;
	b=m4AztpIuCKEREaGvI5Lq4cEhYHMwOEFyM8oSNB26Ks0f1yE81xBmzkMNCG7OiXWdb4UV6rXoGq3QX5YH+fJPPAuBDLD0kSAlyLPn9hInQNw687im+mij95V25qYDU/lsMBTwUI7NKztQJ9uJfkIalo5MrRAxGZvuXxDpo3Re3QA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9EdQCU_1719294996;
Received: from 30.97.48.187(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9EdQCU_1719294996)
          by smtp.aliyun-inc.com;
          Tue, 25 Jun 2024 13:56:36 +0800
Message-ID: <75fcd060-99f0-44ec-bcc1-4dd6d712e97c@linux.alibaba.com>
Date: Tue, 25 Jun 2024 13:56:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs-utils: lib: add
 erofs_{rebuild_make_root,enable_sb_chksum}
To: Hongzhen Luo <hongzhen@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20240625032456.1347088-1-hongzhen@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240625032456.1347088-1-hongzhen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2024/6/25 11:24, Hongzhen Luo wrote:
> Move erofs_sb_csum_set() and erofs_mkfs_alloc_root() into liberofs
> for external use.
> 
> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
> ---
> v2: Update the commit message.
> v1: https://lore.kernel.org/all/20240625031005.1334796-1-hongzhen@linux.alibaba.com/
> ---

I failed to apply this patch.  Again, please rebase your patch
on either -dev or -experimental branch.

Thanks,
Gao Xiang
