Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 560D0174419
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 02:13:17 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TpLc6WDpzDrB5
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 12:13:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TpLV0RcDzDqPC
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 12:13:02 +1100 (AEDT)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 259E8AE0469AE690B3C0;
 Sat, 29 Feb 2020 09:12:57 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 29 Feb 2020 09:12:56 +0800
Received: from architecture4 (10.160.196.180) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Sat, 29 Feb 2020 09:12:56 +0800
Date: Sat, 29 Feb 2020 09:11:26 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: correct the remaining shrink objects
Message-ID: <20200229011126.GA103844@architecture4>
References: <20200226081008.86348-1-gaoxiang25@huawei.com>
 <20200228194452.17C3F2469D@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200228194452.17C3F2469D@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.160.196.180]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,

On Fri, Feb 28, 2020 at 07:44:50PM +0000, Sasha Levin wrote:
> Hi
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a "Fixes:" tag
> fixing commit: e7e9a307be9d ("staging: erofs: introduce workstation for decompression").
> 
> The bot has tested the following trees: v5.5.6, v5.4.22, v4.19.106.
> 
> v5.5.6: Build OK!
> v5.4.22: Failed to apply! Possible dependencies:
>     bda17a4577da ("erofs: remove dead code since managed cache is now built-in")
> 
> v4.19.106: Failed to apply! Possible dependencies:
>     05f9d4a0c8c4 ("staging: erofs: use the new LZ4_decompress_safe_partial()")
>     0a64d62d5399 ("staging: erofs: fixed -Wmissing-prototype warnings by making functions static.")
>     14f362b4f405 ("staging: erofs: clean up internal.h")
>     152a333a5895 ("staging: erofs: add compacted compression indexes support")
>     22fe04a77d10 ("staging: erofs: clean up shrinker stuffs")
>     3b423417d0d1 ("staging: erofs: clean up erofs_map_blocks_iter")
>     5fb76bb04216 ("staging: erofs: cleanup `z_erofs_vle_normalaccess_readpages'")
>     6e78901a9f23 ("staging: erofs: separate erofs_get_meta_page")
>     7dd68b147d60 ("staging: erofs: use explicit unsigned int type")
>     7fc45dbc938a ("staging: erofs: introduce generic decompression backend")
>     89fcd8360e7b ("staging: erofs: change 'unsigned' to 'unsigned int'")
>     8be31270362b ("staging: erofs: introduce erofs_grab_bio")
>     ab47dd2b0819 ("staging: erofs: cleanup z_erofs_vle_work_{lookup, register}")
>     bda17a4577da ("erofs: remove dead code since managed cache is now built-in")
>     d1ab82443bed ("staging: erofs: Modify conditional checks")
>     e7dfb1cff65b ("staging: erofs: fixed -Wmissing-prototype warnings by moving prototypes to header file.")
>     f0950b02a74c ("staging: erofs: Modify coding style alignments")

I will manually backport this if it can not be automatically applied.

Thanks,
Gao Xiang

> 
> 
> NOTE: The patch will not be queued to stable trees until it is upstream.
> 
> How should we proceed with this patch?
> 
> -- 
> Thanks
> Sasha
