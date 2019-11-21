Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D01047E5
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2019 02:13:06 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JM4b0B0MzDqq3
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Nov 2019 12:13:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JM4V0YLGzDqNN
 for <linux-erofs@lists.ozlabs.org>; Thu, 21 Nov 2019 12:12:55 +1100 (AEDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id BA7B8717D83CA5655174;
 Thu, 21 Nov 2019 09:12:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 21 Nov
 2019 09:12:41 +0800
Subject: Re: [PATCH v2] erofs: drop all vle annotations for runtime names
To: Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <chao@kernel.org>,
 <linux-erofs@lists.ozlabs.org>
References: <20191108032526.40762-1-gaoxiang25@huawei.com>
 <20191108033733.63919-1-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c12e9c9d-74ed-2beb-4e07-f9fdd731d00f@huawei.com>
Date: Thu, 21 Nov 2019 09:12:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191108033733.63919-1-gaoxiang25@huawei.com>
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
Cc: Gao Xiang <xiang@kernel.org>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/11/8 11:37, Gao Xiang wrote:
> VLE was an old informal name of fixed-sized output
> compression came from released ATC'19 paper [1].
> 
> Drop those old annotations since erofs can handle
> all encoded clusters in block-aligned basis, which
> is wider than fixed-sized output compression after
> larger clustersize feature is fully implemented.
> 
> Unaligned encoded data won't be considered in EROFS
> since it's not friendly to inplace I/O and decompression
> inplace.
> 
> a) Fixed-sized output compression with 16KB pcluster:
>   ___________________________________
>  |xxxxxxxx|xxxxxxxx|xxxxxxxx|xxxxxxxx|
>  |___ 0___|___ 1___|___ 2___|___ 3___| physical blocks
> 
> b) Block-aligned fixed-sized input compression with
>    16KB pcluster:
>   ___________________________________
>  |xxxxxxxx|xxxxxxxx|xxxxxxxx|xxx00000|
>  |___ 0___|___ 1___|___ 2___|___ 3___| physical blocks
> 
> c) Block-unaligned fixed-sized input compression with
>    16KB compression unit:
>   ____________________________________________
>  |..xxxxxx|xxxxxxxx|xxxxxxxx|xxxxxxxx|x.......|
>  |___ 0___|___ 1___|___ 2___|___ 3___|___ 4___| physical blocks
> 
> Refine better names for those as well.
> 
> [1] https://www.usenix.org/conference/atc19/presentation/gao
> 
> Cc: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
