Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B612E64A
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 13:56:43 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pSj45b6ZzDqBK
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2020 23:56:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pSht4NDSzDq9y
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2020 23:56:26 +1100 (AEDT)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id AAC6655C97BE70526419;
 Thu,  2 Jan 2020 20:56:18 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jan 2020 20:56:17 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 2 Jan 2020 20:56:17 +0800
Date: Thu, 2 Jan 2020 20:55:51 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Vladimir Zapolskiy <vladimir@tuxera.com>
Subject: Re: [PATCH 0/3] erofs: remove tags of pointers stored in a radix tree
Message-ID: <20200102125551.GB53770@architecture4>
References: <20200102120118.14979-1-vladimir@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200102120118.14979-1-vladimir@tuxera.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme720-chm.china.huawei.com (10.1.199.116) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
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
Cc: Miao Xie <miaoxie@huawei.com>, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, Anton Altaparmakov <anton@tuxera.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Vladimir,

On Thu, Jan 02, 2020 at 02:01:15PM +0200, Vladimir Zapolskiy wrote:
> The changeset simplifies a couple of internal interfaces and removes
> excessive tagging and untagging of workgroup pointers stored in a radix
> tree.
> 
> All the changes in the series are non-functional.

This radix tree tag was planned to be reserved for other use in order
to differ it from the current fixed-sized output compression management
structure. I agree that it can be simplified for now, so I will test
this series and apply. However, I think such XArray tagged pointer
usage is useful.

p.s. I'm converting this radix tree to XArray and cleaning up
related functions for the next cycle as well.

Thanks,
Gao Xiang

> 
> Vladimir Zapolskiy (3):
>   erofs: remove unused tag argument while finding a workgroup
>   erofs: remove unused tag argument while registering a workgroup
>   erofs: remove void tagging/untagging of workgroup pointers
> 
>  fs/erofs/internal.h |  4 ++--
>  fs/erofs/utils.c    | 15 ++++-----------
>  fs/erofs/zdata.c    |  5 ++---
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> -- 
> 2.20.1
> 
