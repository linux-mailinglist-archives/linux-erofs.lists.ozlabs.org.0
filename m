Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1824E1F4
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 10:33:11 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45VX5062vBzDqdD
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Jun 2019 18:33:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45VX4x11WjzDqSf
 for <linux-erofs@lists.ozlabs.org>; Fri, 21 Jun 2019 18:33:04 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C084FA8D8536B19F0AEB;
 Fri, 21 Jun 2019 16:33:01 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 21 Jun
 2019 16:32:52 +0800
Subject: Re: [PATCH v2 3/8] staging: erofs: move per-CPU buffers
 implementation to utils.c
To: Chao Yu <yuchao0@huawei.com>
References: <20190620160719.240682-1-gaoxiang25@huawei.com>
 <20190620160719.240682-4-gaoxiang25@huawei.com>
 <1d296b86-69e2-4888-2ac9-1d77f38ac3e3@huawei.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <abe96e3d-cda7-e71e-68b1-9669fe2f2241@huawei.com>
Date: Fri, 21 Jun 2019 16:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1d296b86-69e2-4888-2ac9-1d77f38ac3e3@huawei.com>
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

Hi Chao,

On 2019/6/21 15:57, Chao Yu wrote:
> On 2019/6/21 0:07, Gao Xiang wrote:
>> +static inline void *erofs_get_pcpubuf(unsigned int pagenr)
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
>> +}
> 
> [snip]
> 
>> +	percpu_data = erofs_get_pcpubuf(0);
> 
> If erofs_get_pcpubuf may return error once EROFS_PCPUBUF_NR_PAGES equals to
> zero, we'd better to check the error number here.

decompressor.c will be built-in only when decompression is enabled
and if decompression is enabled EROFS_PCPUBUF_NR_PAGES is not zero.

But I think introducing some error handling logic is not bad as well.
Will fix in the next version.

Thanks,
Gao Xiang

> 
> Thanks,
> 
