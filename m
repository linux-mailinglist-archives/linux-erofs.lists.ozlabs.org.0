Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B45132423E9
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Aug 2020 04:01:22 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRCbz5YH1zDqNZ
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Aug 2020 12:01:19 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRCbt1RjPzDqFv
 for <linux-erofs@lists.ozlabs.org>; Wed, 12 Aug 2020 12:01:10 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B315B9617494B5F5982D;
 Wed, 12 Aug 2020 10:01:05 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 12 Aug
 2020 10:01:04 +0800
Subject: Re: [PATCH] erofs: avoid duplicated permission check for "trusted."
 xattrs
To: Gao Xiang <hsiangkao@redhat.com>, <linux-erofs@lists.ozlabs.org>
References: <20200811070020.6339-1-hsiangkao@redhat.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <18a6a9b7-5967-1929-920a-e34e446944ac@huawei.com>
Date: Wed, 12 Aug 2020 10:01:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200811070020.6339-1-hsiangkao@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
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
Cc: Hongyu Jin <hongyu.jin@unisoc.com>, LKML <linux-kernel@vger.kernel.org>,
 stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/8/11 15:00, Gao Xiang wrote:
> Don't recheck it since xattr_permission() already
> checks CAP_SYS_ADMIN capability.
> 
> Just follow 5d3ce4f70172 ("f2fs: avoid duplicated permission check for "trusted." xattrs")
> 
> Reported-by: Hongyu Jin <hongyu.jin@unisoc.com>
> [ Gao Xiang: since it could cause some complex Android overlay
>    permission issue as well on android-5.4+, so it'd be better to
>    backport to 5.4+ rather than pure cleanup on mainline. ]
> Cc: <stable@vger.kernel.org> # 5.4+
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
