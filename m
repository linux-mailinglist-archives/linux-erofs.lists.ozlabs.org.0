Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3DE1E5BCE
	for <lists+linux-erofs@lfdr.de>; Thu, 28 May 2020 11:25:28 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Xj3T57CjzDqX9
	for <lists+linux-erofs@lfdr.de>; Thu, 28 May 2020 19:25:25 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Xj3N2fQmzDqVq
 for <linux-erofs@lists.ozlabs.org>; Thu, 28 May 2020 19:25:16 +1000 (AEST)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 236CE8628A9E2B396CDF;
 Thu, 28 May 2020 17:25:09 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 17:25:06 +0800
Subject: Re: [PATCH] erofs: suppress false positive last_block warning
To: Gao Xiang <hsiangkao@redhat.com>, <linux-erofs@lists.ozlabs.org>, Chao Yu
 <chao@kernel.org>
References: <20200528084844.23359-1-hsiangkao@redhat.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <4bc811ed-f406-1f77-94f7-5e61c4657001@huawei.com>
Date: Thu, 28 May 2020 17:25:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528084844.23359-1-hsiangkao@redhat.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/5/28 16:48, Gao Xiang wrote:
> As Andrew mentioned, some rare specific gcc versions could report
> last_block uninitialized warning. Actually last_block doesn't need
> to be uninitialized first from its implementation due to bio == NULL
> condition. After a bio is allocated, last_block will be assigned
> then.
> 
> The detailed analysis is in this thread [1]. So let's silence those
> confusing gccs simply.
> 
> [1] https://lore.kernel.org/r/20200421072839.GA13867@hsiangkao-HP-ZHAN-66-Pro-G1
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
