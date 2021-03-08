Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552483305AC
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Mar 2021 02:45:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dv1PL29bSz3cK7
	for <lists+linux-erofs@lfdr.de>; Mon,  8 Mar 2021 12:45:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com;
 envelope-from=yuchao0@huawei.com; receiver=<UNKNOWN>)
X-Greylist: delayed 920 seconds by postgrey-1.36 at boromir;
 Mon, 08 Mar 2021 12:45:08 AEDT
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dv1PJ1Sfbz30Qk
 for <linux-erofs@lists.ozlabs.org>; Mon,  8 Mar 2021 12:45:04 +1100 (AEDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dv11K63Mlz16HZg;
 Mon,  8 Mar 2021 09:27:49 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 8 Mar 2021
 09:29:31 +0800
Subject: Re: [PATCH v2] erofs: fix bio->bi_max_vecs behavior change
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>, Chao Yu
 <chao@kernel.org>
References: <20210306033109.28466-1-hsiangkao@aol.com>
 <20210306040438.8084-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6525c63c-a6e2-8c39-6c9a-1ca9b54632d8@huawei.com>
Date: Mon, 8 Mar 2021 09:29:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210306040438.8084-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
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
Cc: Martin
 DEVERA <devik@eaxlabs.cz>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2021/3/6 12:04, Gao Xiang wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> Martin reported an issue that directory read could be hung on the
> latest -rc kernel with some certain image. The root cause is that
> commit baa2c7c97153 ("block: set .bi_max_vecs as actual allocated
> vector number") changes .bi_max_vecs behavior. bio->bi_max_vecs
> is set as actual allocated vector number rather than the requested
> number now.
> 
> Let's avoid using .bi_max_vecs completely instead.
> 
> Reported-by: Martin DEVERA <devik@eaxlabs.cz>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Looks good to me, btw, it needs to Cc stable mailing list?

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
