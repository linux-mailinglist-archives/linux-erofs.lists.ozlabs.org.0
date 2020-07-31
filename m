Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEF5233DCE
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 05:48:48 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHtYT73TYzDqZC
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Jul 2020 13:48:45 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHtYK0NgQzDqYK
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 Jul 2020 13:48:33 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9D921B21CA41E6BF6D25;
 Fri, 31 Jul 2020 11:48:28 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 31 Jul
 2020 11:48:27 +0800
Subject: Re: [PATCH] erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's
To: Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>
References: <20200731024049.16495-1-hsiangkao.ref@aol.com>
 <20200731024049.16495-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0445e583-f9d6-782e-971c-a5a52dcdc6dc@huawei.com>
Date: Fri, 31 Jul 2020 11:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200731024049.16495-1-hsiangkao@aol.com>
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/7/31 10:40, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
> unbound wq. I remove this flag from places where unbound queue is
> allocated. This is supposed to improve code readability.
> 
> [1] https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> [Gao Xiang: since the original treewide patch [2] hasn't been merged
>              yet, handling the EROFS part only for the next cycle. ]
> [2] https://lore.kernel.org/r/20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
