Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CE56C43E
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 03:33:18 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45pxV40pK4zDqTh
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2019 11:33:16 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45pxTs2xPYzDqSP
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 11:33:02 +1000 (AEST)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 863E7F5BEE83D3520A83
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2019 09:32:55 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 18 Jul
 2019 09:32:50 +0800
Subject: Re: erofs compilation failure.
To: Pratik Shinde <pratikshinde320@gmail.com>
References: <CAGu0czSPMpsmWxxmBYk96t3ixO=_vnNXXveZNzR-dhQSg_mtfg@mail.gmail.com>
From: Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <56c96bca-fc01-fa3d-67e2-920a9c4afc61@huawei.com>
Date: Thu, 18 Jul 2019 09:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAGu0czSPMpsmWxxmBYk96t3ixO=_vnNXXveZNzR-dhQSg_mtfg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2019/7/18 3:47, Pratik Shinde wrote:
> Hi All,
> 
> I hope this is the correct channel to talk about this issue.
> I am trying to compile erofs with latest kernel source as follows:
> 
> ps@ps:~/linux/drivers/staging/erofs$ pwd
> /home/ps/linux/drivers/staging/erofs
> ps@ps:~/linux/drivers/staging/erofs$  make -C ~/linux  M=`pwd`
> make: Entering directory '/home/ps/linux'
> make[1]: *** No rule to make target '/home/ps/linux/drivers/staging/erofs/super.o', needed by '/home/ps/linux/drivers/staging/erofs/erofs.o'.  Stop.
> Makefile:1612: recipe for target '_module_/home/ps/linux/drivers/staging/erofs' failed
> make: *** [_module_/home/ps/linux/drivers/staging/erofs] Error 2
> make: Leaving directory '/home/ps/linux'
> 
> I ran the above make command under strace, it looks like make is not able to locate dependent '.o' files, e.g data.o, super.o etc. But, its should compile those dependencies first ? In the strace I cannot see gcc invoked on this '.c' files.
> 
> Is this the correct way of compiling the source ?

seems not.. Actually the question is not for erofs development.
I didn't observe any compile error on erofs.

Could you please refer guides on the internet?

Thanks,
Gao Xiang

> Help appreciated. !
> 
> Thank you.
> --Pratik.
> 
