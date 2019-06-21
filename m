Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E02E4E19C
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 10:08:49 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VWXt6slBzDqdM
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 18:08:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.35; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VWXp5xMszDqcw
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 18:08:40 +1000 (AEST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 7C9AAF193B3EFDC9476A;
 Fri, 21 Jun 2019 16:08:36 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 16:08:29 +0800
Subject: Re: [PATCH v2 2/8] staging: erofs: add compacted compression indexes
 support
To: Chao Yu <yuchao0@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-3-gaoxiang25@huawei.com>
 <4274208b-63bc-6dfd-a2c8-a94d2fa5c8d7@huawei.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <d04f83f7-9f01-e736-cc1b-8ee438e47d3c@huawei.com>
Date: Fri, 21 Jun 2019 16:08:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <4274208b-63bc-6dfd-a2c8-a94d2fa5c8d7@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miao Xie <miaoxie@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 Du Wei <weidu.du@huawei.com>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/21 15:53, Chao Yu wrote:
> On 2019/6/21 0:07, Gao Xiang wrote:
>> This patch aims at compacted compression indexes:
>>  1) cleanup z_erofs_map_blocks_iter and move into zmap.c;
>>  2) add compacted 4/2B decoding support.
>>
>> On kirin980 platform, sequential read is increased about
>> 6% (725MiB/s -> 770MiB/s) on enwik9 dataset if compacted 2B
>> feature is enabled.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
>> +static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>> +					     unsigned long lcn)
>> +{
>> +	struct inode *const inode = m->inode;
>> +	struct erofs_vnode *const vi = EROFS_V(inode);
>> +	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
>> +	const erofs_off_t pos = Z_EROFS_VLE_EXTENT_ALIGN(ibase +
>> +							 vi->inode_isize +
>> +							 vi->xattr_isize) +
>> +		16 + lcn * sizeof(struct z_erofs_vle_decompressed_index);
> 
> use macro instead of raw number?

OK, I will wrap it up in patch v3 too.

Thanks,
Gao Xiang

> 
> Thanks,
> 
