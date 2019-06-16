Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA84739C
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Jun 2019 09:21:50 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45RQkz6YLnzDqSh
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Jun 2019 17:21:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45RQkv1qhKzDqM4
 for <linux-erofs@lists.ozlabs.org>; Sun, 16 Jun 2019 17:21:42 +1000 (AEST)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5A8BF53647C697CF2FA8;
 Sun, 16 Jun 2019 15:21:38 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sun, 16 Jun
 2019 15:21:32 +0800
Subject: Re: [PATCH v3 1/2] staging: erofs: add requirements field in
 superblock
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190611024220.86121-1-gaoxiang25@huawei.com>
 <20190613083541.67091-1-gaoxiang25@huawei.com>
 <a4d587eb-c4f0-b9e5-7ece-1ac38c2735f3@huawei.com>
 <20190616071439.GA11880@kroah.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <b2608d35-1d9f-0747-ce3c-ddfd6273e865@huawei.com>
Date: Sun, 16 Jun 2019 15:21:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190616071439.GA11880@kroah.com>
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
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 weidu.du@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/6/16 15:14, Greg Kroah-Hartman wrote:
> On Sun, Jun 16, 2019 at 03:00:38PM +0800, Gao Xiang wrote:
>> Hi Greg,
>>
>> Sorry for annoying... Could you help merge these two fixes? Thanks in advance...
> 
> It was only 3 days, please give me at the very least, a week or so for
> staging patches.
> 
>> decompression inplace optimization needs these two patches and I will integrate
>> erofs decompression inplace optimization later for linux-next 5.3, and try to start 
>> making effort on moving to fs/ directory on kernel 5.4...
> 
> You can always send follow-on patches, I apply them in the correct
> order.  I will get to these next week, thanks.

OK, I was actually just afraid of the appling order. I was thinking of merging
these two patches in advance since the new series has the dependency on these patches.

Thanks,
Gao Xiang

> 
> greg k-h
> 
