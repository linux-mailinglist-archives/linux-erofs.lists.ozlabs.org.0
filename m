Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E612F4DA
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2020 08:09:19 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47pwxk2NHzzDqD0
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2020 18:09:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.35; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47pwxX0n7zzDqCG
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Jan 2020 18:09:00 +1100 (AEDT)
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 64011AD2A04F99D07C71;
 Fri,  3 Jan 2020 15:08:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 3 Jan 2020
 15:08:43 +0800
Subject: Re: [PATCH 0/3] erofs: remove tags of pointers stored in a radix tree
To: Vladimir Zapolskiy <vladimir@tuxera.com>, Gao Xiang <xiang@kernel.org>,
 Chao Yu <chao@kernel.org>
References: <20200102120118.14979-1-vladimir@tuxera.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c21314f0-1061-5683-4775-280629275c7b@huawei.com>
Date: Fri, 3 Jan 2020 15:08:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200102120118.14979-1-vladimir@tuxera.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
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
Cc: linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 Matthew Wilcox <willy@infradead.org>, Anton Altaparmakov <anton@tuxera.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/1/2 20:01, Vladimir Zapolskiy wrote:
> The changeset simplifies a couple of internal interfaces and removes
> excessive tagging and untagging of workgroup pointers stored in a radix
> tree.
> 
> All the changes in the series are non-functional.
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

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
