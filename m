Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5812DE8C
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Jan 2020 11:42:58 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47nnnC02pvzDq9m
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Jan 2020 21:42:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=foxmail.com (client-ip=183.3.255.84; helo=qq.com;
 envelope-from=blucer.lee@foxmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=foxmail.com header.i=@foxmail.com header.b="pt7DzPgL"; 
 dkim-atps=neutral
X-Greylist: delayed 68 seconds by postgrey-1.36 at bilbo;
 Wed, 01 Jan 2020 21:42:42 AEDT
Received: from qq.com (smtpbg449.qq.com [183.3.255.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47nnmy5Yr0zDq9R
 for <linux-erofs@lists.ozlabs.org>; Wed,  1 Jan 2020 21:42:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1577875258;
 bh=xSzbciF65EFxZZveBGFtCJmuXuomzQhGfY4qqpwAWIM=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=pt7DzPgLsqgIrCbPWaz14KOx2NRFshova1fPTDjoaQUIm3ZdrTvC/XdQFBuRAIoxW
 Kf1KdFDcYM0J9xhudU/FpsnG0yCwaibPSUSC7FTRMBmvOSNJ9uQmxqF7yG7G68sN5d
 cno7p33nKrSHZw2tdU+/Yx5QKYYWHqQuczBs5kyQ=
X-QQ-mid: esmtp3t1577875257tnjg6qdy2
Received: from [192.168.0.101] (unknown [223.166.142.159])
 by esmtp4.qq.com (ESMTP) with 
 id ; Wed, 01 Jan 2020 18:40:56 +0800 (CST)
X-QQ-SSF: 0100000000000040FF100000000000Y
X-QQ-FEAT: /eYKt59m1vWOCRWGvRatEuYHjFpct0+HLnmfwRhnHSto139JmG23iji22k+i4
 jtCqck1ko45DSXEX7NM3HKGix50JvvqeZYLuVp1BFg3UXE+jS3BmSxAlroga6iJK5hDb6Ew
 Fur2emqfDA7uOErmHhPLmjzgO1CYXO2b0RB/lt3/e7seMr5e93P9v1nZsf+UEwgQJXjCxHm
 SRNahhqtSsL38dkNWJyryL37BlaV4mnWzdHHr4rVT8kwB27y6HVZx6qQ1IeWyF0EUyp9jfo
 d5E891+u1Paw7S5g9McOCjeG4=
X-QQ-GoodBg: 0
Subject: Re: [PATCH] erofs-utils: wrap up sb feature operations
To: Gao Xiang <gaoxiang25@huawei.com>, Li Guifu <bluce.liguifu@huawei.com>,
 linux-erofs@lists.ozlabs.org
References: <20191231082200.152744-1-gaoxiang25@huawei.com>
From: Li Guifu <blucer.lee@foxmail.com>
Message-ID: <3ca37c97-b68f-554f-3047-9e226577d3cc@foxmail.com>+17D2233954253851
Date: Wed, 1 Jan 2020 18:40:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191231082200.152744-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgforeign:bgforeign12
X-QQ-Bgrelay: 1
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> Add some helpers for shorter lines. No logic change.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> 

It looks good
Reviewed-by: Li Guifu <blucer.lee@foxmail.com>


Because the pre email Li Guifu <blucerlee@gmail.com> is not work at
chinese mainland, so replace it with Li Guifu <blucer.lee@foxmail.com>

Thanks,



