Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF4A19523C
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 08:43:45 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48pYkk4qR3zDqcj
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Mar 2020 18:43:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48pYhx1mwjzDqY6
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Mar 2020 18:42:09 +1100 (AEDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 337B86471CB043EFAF78;
 Fri, 27 Mar 2020 15:42:06 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 27 Mar
 2020 15:41:57 +0800
Subject: Re: [PATCH] erofs-utils: avoid using old compatibility type uint
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>, Li Guifu
 <bluce.liguifu@huawei.com>, Li GuiFu <bluce.lee@aliyun.com>
References: <20200324081949.26355-1-hsiangkao.ref@aol.com>
 <20200324081949.26355-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <451f49e9-d1ee-2bc9-75ff-49e9c7cacc69@huawei.com>
Date: Fri, 27 Mar 2020 15:41:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200324081949.26355-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/3/24 16:19, Gao Xiang via Linux-erofs wrote:
> This should fix the following buildroot autobuild issues
> with some configration on ARM platform [1]:
> 
> compress.c: In function 'vle_compress_one':
> compress.c:209:10: error: unknown type name 'uint'
>     const uint qh_aligned = round_down(ctx->head, EROFS_BLKSIZ);
>           ^~~~
> compress.c:210:10: error: unknown type name 'uint'
>     const uint qh_after = ctx->head - qh_aligned;
>           ^~~~
> compress.c: In function 'z_erofs_convert_to_compacted_format':
> compress.c:313:8: error: unknown type name 'uint'
>   const uint headerpos = Z_EROFS_VLE_EXTENT_ALIGN(inode->inode_isize +
>         ^~~~
> compress.c:316:8: error: unknown type name 'uint'
>   const uint totalidx = (legacymetasize -
>         ^~~~
> 
> [1] http://autobuild.buildroot.net/results/842a3c6416416d7badf4db9f38e3b231093a786a
> Signed-off-by: Gao Xiang <hsiangkao@aol.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
