Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 3658E49720
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 03:47:39 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SWDS5cZNzDqXG
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jun 2019 11:47:36 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SWDM4MNLzDqS4
 for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jun 2019 11:47:31 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 60CF686CD082B136A475;
 Tue, 18 Jun 2019 09:47:21 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 18 Jun
 2019 09:47:11 +0800
Subject: Re: [RFC PATCH 0/8] staging: erofs: decompression inplace approach
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
 <20190617203609.GA22034@kroah.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <c86d3fc0-8b4a-6583-4309-911960fbe862@huawei.com>
Date: Tue, 18 Jun 2019 09:47:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190617203609.GA22034@kroah.com>
Content-Type: text/plain; charset="utf-8"
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
Cc: devel@driverdev.osuosl.org, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, weidu.du@huawei.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/18 4:36, Greg Kroah-Hartman wrote:
> On Sat, Jun 15, 2019 at 02:16:11AM +0800, Gao Xiang wrote:
>> At last, this is RFC patch v1, which means it is not suitable for
>> merging soon... I'm still working on it, testing its stability
>> these days and hope these patches get merged for 5.3 LTS
>> (if 5.3 is a LTS version).
> 
> Why would 5.3 be a LTS kernel?
> 
> curious as to how you came up with that :)

My personal thought is about one LTS kernel one year...
Usually 5 versions after the previous kernel...(4.4 -> 4.9 -> 4.14 -> 4.19),
which is not suitable for all historical LTSs...just prepare for 5.3...

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
> 
