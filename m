Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F65503A4
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2019 09:35:53 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45XLgV4xVXzDqX8
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2019 17:35:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuchao0@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XLfb0RlhzDqCb
 for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2019 17:35:02 +1000 (AEST)
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 825BA6EB3A94ED6FA231;
 Mon, 24 Jun 2019 15:34:56 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 24 Jun
 2019 15:34:47 +0800
Subject: Re: [PATCH v3 0/8] staging: erofs: decompression inplace approach
To: Gao Xiang <hsiangkao@aol.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
References: <20190624072258.28362-1-hsiangkao@aol.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <b07bc3f7-e85e-896a-c8ae-4800ca6c9816@huawei.com>
Date: Mon, 24 Jun 2019 15:34:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
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
Cc: devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>,
 linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2019/6/24 15:22, Gao Xiang wrote:
> This is patch v3 of erofs decompression inplace approach, which is sent
> out by my personal email since I'm out of office to attend Open Source
> Summit China 2019 these days. No major change from PATCH v2 since no
> noticeable issue raised from landing to our products till now, mainly
> as a response to Chao's suggestions.
> 
> See the bottom lines which are taken from RFC PATCH v1 and describe
> the principle of these technologies.
> 
> The series is based on the latest staging-next since all dependencies
> have already been merged.
> 
> changelog from v2:
>  - wrap up some offsets as marcos;
>  - add some error handling for erofs_get_pcpubuf();
>  - move some decompression inplace stuffes from PATCH 5 -> 6.

Thanks for the update, those all changes look good to me. :)

Thanks,
