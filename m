Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD304165904
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 09:20:21 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48NSFb0VWGzDqCY
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Feb 2020 19:20:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 48NSFP5Tc6zDq6Q
 for <linux-erofs@lists.ozlabs.org>; Thu, 20 Feb 2020 19:20:05 +1100 (AEDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 70D15595F2CA640EE134;
 Thu, 20 Feb 2020 16:20:00 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 20 Feb
 2020 16:19:50 +0800
Subject: Re: [PATCH v3] erofs: convert workstn to XArray
To: Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
References: <20200220024642.91529-1-gaoxiang25@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <c3372d97-ec77-6928-719e-39195c8c33f8@huawei.com>
Date: Thu, 20 Feb 2020 16:19:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200220024642.91529-1-gaoxiang25@huawei.com>
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
Cc: Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2020/2/20 10:46, Gao Xiang wrote:
> XArray has friendly APIs and it will replace the old radix
> tree in the near future.
> 
> This convert makes use of __xa_cmpxchg when inserting on
> a just inserted item by other thread. In detail, instead
> of totally looking up again as what we did for the old
> radix tree, it will try to legitimize the current in-tree
> item in the XArray therefore more effective.
> 
> In addition, naming is rather a challenge for non-English
> speaker like me. The basic idea of workstn is to provide
> a runtime sparse array with items arranged in the physical
> block number order. Such items (was called workgroup) can be
> used to record compress clusters or for later new features.
> 
> However, both workgroup and workstn seem not good names from
> whatever point of view, so I'd like to rename them as pslot
> and managed_pslots to stand for physical slots. This patch
> handles the second as a part of the radix tree convert.
> 
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
